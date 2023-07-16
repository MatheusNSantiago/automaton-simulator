import 'package:automata_simulator/constants.dart';
import 'package:automata_simulator/domain/canvas/canvas.dart';
import 'package:automata_simulator/domain/canvas/i_canvas_repository.dart';
import 'package:automata_simulator/domain/geometry/point.dart';
import 'package:automata_simulator/domain/model/link.dart';
import 'package:automata_simulator/domain/model/node.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../utils.dart';
part 'canvas_state.dart';

final n = [
  Node(label: 'Q0', position: Point(100, 300)),
  Node(label: 'Q1', position: Point(280, 300)),
].asMap().map((key, node) => MapEntry(node.label, node));

final n0 = n.values.toList()[0];
final n1 = n.values.toList()[1];
final l = [
  Link(from: n0, to: n1, label: 'a'),
].asMap().map((key, link) => MapEntry(link.id, link));
@injectable
class CanvasCubit extends Cubit<CanvasState> {
  final ICanvasRepository repository;
  final TransformationController transform = TransformationController();

  // CanvasCubit(this.repository) : super(CanvasState(nodes: {}, links: {}));
  CanvasCubit(this.repository) : super(CanvasState(nodes: n, links: l));

  Offset toScene(Offset global) => transform.toScene(global);
  TransformationController getTransformationController() => transform;

  Future<void> writeCurrentState() async {
    final canvas = Canvas(nodes: state.nodes, links: state.links);

    await repository.saveCanvas(canvas);
  }

  Future<void> readCanvas() async {
    final canvas = await repository.getCanvas();

    emit(state.copyWith(nodes: canvas.nodes, links: canvas.links));
  }

  void zoom(double delta, [Offset? mousePosition]) {
    var matrix = transform.value;
    final newZoom = (delta - 1) + state.zoom;

    final isBetweenLimits = newZoom >= 0.5 && newZoom <= 2.25;
    if (!isBetweenLimits) return;

    emit(state.copyWith(zoom: newZoom));

    final isFromMouse = mousePosition != null;
    if (isFromMouse) {
      final local = toScene(mousePosition);
      matrix.translate(local.dx, local.dy);
      matrix.scale(delta, delta);
      matrix.translate(-local.dx, -local.dy);
    } else {
      final translation = matrix.getTranslation();

      // reseta tudo. O zoom será calculado em relação ao canvas inicial, e não ao atual
      // Antes: zoom(1.1) seguido de zoom(0.9) -> o zoom final seria 0.99
      // Agora: zoom(1.1) seguido de zoom(0.9) -> o zoom final é 1
      matrix.setIdentity();

      // Restaura a posição da matriz
      matrix.translate(translation.x, translation.y);

      // Calcula o novo zoom
      matrix.scale(newZoom, newZoom);
    }

    transform.value = matrix;
  }

  void zoomIn() => zoom(1.1);
  void zoomOut() => zoom(0.9);
  void resetZoom() {
    emit(state.copyWith(zoom: 1.0));
    zoom(1.0);
  }


  void pan(Offset delta) {
    const maxW = 500, maxH = 400;
    final matrix = transform.value.clone();

    var dx = delta.dx / state.zoom;
    var dy = delta.dy / state.zoom;

    final translation = transform.value.getTranslation();
    final x = translation.x + dx;
    final y = translation.y + dy;

    final isInVerticalBounds = (-maxH <= y) && (y <= maxH);
    final isInHorizontalBounds = (-maxW <= x) && (x <= maxW);

    if (!isInHorizontalBounds) dx = 0;
    if (!isInVerticalBounds) dy = 0;

    matrix.translate(dx, dy);
    transform.value = matrix;
  }

  void addNode(Offset position) {
    var label = 'Q0';

    if (state.nodes.isNotEmpty) {
      final lastLabel = state.nodesList.map((node) => node.label).sorted().last;
      label = 'Q${int.parse(lastLabel.substring(1)) + 1}';
    }
    Node node = Node(
      label: label,
      position: toScene(position).toPoint(),
    ).translate(dx: -kNodeRadius, dy: -kNodeRadius);

    state.nodes[node.label] = node;
    emit(state);
  }

  // ╭──────────────────────────────────────────────────────────╮
  // │                          Links                           │
  // ╰──────────────────────────────────────────────────────────╯

  void addLink(Node from, Node to, [String? label]) {
    final link = Link(from: from, to: to, label: label);
    state.links[link.id] = link;
    emit(state);
  }

  void startTemporaryLink({required Node startAt}) {
    emit(
      state.copyWith(
        linkStart: Optional.value(startAt),
        linkEnd: Optional.value(startAt.position),
      ),
    );
  }

  void changeLinkLabel(Link link, String label) {
    state.links[link.id]!.label = label;
    emit(state);
  }

  void updateTemporaryLink({required Offset end}) {
    final endPoint = toScene(end).toPoint();

    emit(state.copyWith(linkEnd: Optional.value(endPoint)));
  }

  void clearTemporaryLink() {
    emit(state.copyWith(linkStart: Optional.none, linkEnd: Optional.none));
  }

  void translateControlPoint(Link link, Offset delta) {
    state.links[link.id]!.translateControlPoint(dx: delta.dx, dy: delta.dy);
    emit(state);
  }

  Link? getLinkCloseToPoint(Offset rawOffset, {double minimumDistance = 10}) {
    final point = toScene(rawOffset).toPoint();
    for (final link in state.links.values) {
      if (link.path.isPointInDistance(point, minimumDistance)) return link;
    }
    return null;
  }

  void setSelectedLink(Link? link) {
    state.selectedLink = link;
    emit(state);
  }

  void clearSelectedLink() {
    state.selectedLink = null;
    emit(state);
  }

  // ╭──────────────────────────────────────────────────────────╮
  // │                          Marque                          │
  // ╰──────────────────────────────────────────────────────────╯

  void setMarquee({required Offset? start, required Offset? end}) {
    emit(
      state.copyWith(
        marqueeStart: Optional.value(start),
        marqueeEnd: Optional.value(end),
      ),
    );
  }

  void clearMarquee() {
    emit(state.copyWith(
      marqueeStart: Optional.none,
      marqueeEnd: Optional.none,
    ));
  }

  void checkMarqueeSelection([bool hover = false]) {
    if (!state.isMarqueeActive) return;
    final selection = <String>{};
    final rect = Rect.fromPoints(
      toScene(state.marqueeStart!),
      toScene(state.marqueeEnd!),
    );

    for (final node in state.nodesList) {
      if (rect.overlaps(node.rect)) {
        selection.add(node.label);
      }
    }
    if (selection.isNotEmpty) {
      setSelection(selection, hover);
    } else {
      deselectAll(hover);
    }
  }

  // ╾───────────────────────────────────────────────────────────────────────────────────╼

  bool isNodeSelected(Node node) => state.selected.contains(node.label);
  bool isNodeHovered(Node node) => state.hovered.contains(node.label);

  List<Node> getSelectedNodes() {
    final nodes = <Node>[];
    for (final id in state.selected) {
      if (state.nodes.containsKey(id)) {
        nodes.add(state.nodes[id]!);
      }
    }
    return nodes;
  }

  Node? getNodeOnPosition(Offset offset) {
    return state.nodesList
        .firstWhereOrNull((node) => node.rect.contains(toScene(offset)));
  }

  void checkSelection(Offset offset, [bool hover = false]) {
    final selection = <String>[];
    final node = getNodeOnPosition(offset);
    if (node != null) selection.add(node.label);

    if (selection.isNotEmpty) {
      setSelection({selection.last}, hover);
    } else {
      deselectAll(hover);
    }
  }

  void moveSelection(Offset delta) {
    for (final id in state.selected) {
      final node = state.nodes[id];
      if (node == null) continue;

      node.translate(dx: delta.dx / state.zoom, dy: delta.dy / state.zoom);

      for (final link in state.links.values) {
        final isConnectedWithNode = (link.from == node || link.to == node);

        if (isConnectedWithNode) {
          link.updatePath();
        }
      }
    }
    emit(state);
  }

  void setSelection(Set<String> ids, [bool hover = false]) {
    if (hover) {
      emit(state.copyWith(hovered: ids));
    } else {
      emit(state.copyWith(selected: ids));
    }
  }

  void deselectAll([bool hover = false]) {
    if (hover) {
      emit(state.copyWith(hovered: const {}));
    } else {
      emit(state.copyWith(selected: const {}));
    }
  }
}
