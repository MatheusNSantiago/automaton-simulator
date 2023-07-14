import 'dart:math';

import 'package:automata_simulator/constants.dart';
import 'package:automata_simulator/domain/geometry/point.dart';
import 'package:automata_simulator/domain/model/link.dart';
import 'package:automata_simulator/domain/model/node.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../utils.dart';
part 'canvas_state.dart';

final n = [
  Node(key: UniqueKey(), label: 'Q0', position: Point(100, 300)),
  Node(key: UniqueKey(), label: 'Q1', position: Point(280, 300)),
].asMap().map((key, node) => MapEntry(node.id, node));

final n0 = n.values.toList()[0];
final n1 = n.values.toList()[1];
final l = [
  Link(from: n0, to: n1, label: 'a'),
].asMap().map((key, link) => MapEntry(link.id, link));

class CanvasCubit extends Cubit<CanvasState> {
  final TransformationController transform = TransformationController();

  CanvasCubit() : super(CanvasState(nodes: n, links: l));

  Offset toScene(Offset global) => transform.toScene(global);
  TransformationController getTransformationController() => transform;

  Rect getMaxSize() {
    Rect rect = Rect.zero;
    for (final node in state.nodesList) {
      rect = Rect.fromLTRB(
        min(rect.left, node.rect.left),
        min(rect.top, node.rect.top),
        max(rect.right, node.rect.right),
        max(rect.bottom, node.rect.bottom),
      );
    }
    return rect;
  }

  void zoom(double delta, [Offset? mousePosition]) {
    final matrix = transform.value.clone();

    if (mousePosition != null) {
      final local = toScene(mousePosition);
      matrix.translate(local.dx, local.dy);
      matrix.scale(delta, delta);
      matrix.translate(-local.dx, -local.dy);
    } else {
      matrix.scale(delta, delta);
    }

    transform.value = matrix;
  }

  void zoomIn() => zoom(1.1);
  void zoomOut() => zoom(0.9);
  void zoomReset() => transform.value = Matrix4.identity();
  int getZoom() => (transform.value.getMaxScaleOnAxis() * 100).round();

  void pan(Offset delta) {
    final matrix = transform.value.clone();
    matrix.translate(delta.dx, delta.dy);
    transform.value = matrix;
  }

  void addNode(Offset position) {
    final lastLabel = state.nodesList.map((node) => node.label).sorted().last;
    final newLabel = state.nodes.isEmpty
        ? 'Q0'
        : 'Q${int.parse(lastLabel.substring(1)) + 1}';

    Node node = Node(
      key: UniqueKey(),
      label: newLabel,
      position: toScene(position).toPoint(),
    ).translate(dx: -kNodeRadius, dy: -kNodeRadius);

    state.nodes[node.id] = node;
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
        selection.add(node.id);
      }
    }
    if (selection.isNotEmpty) {
      setSelection(selection, hover);
    } else {
      deselectAll(hover);
    }
  }

  // ╾───────────────────────────────────────────────────────────────────────────────────╼

  bool isSelected(String id) => state.selected.contains(id);
  bool isHovered(String id) => state.hovered.contains(id);

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
    if (node != null) selection.add(node.id);

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

      node.translate(dx: delta.dx, dy: delta.dy);

      for (final link in state.links.values) {
        final isConnectedWithNode = (link.from == node || link.to == node);

        if (isConnectedWithNode) {
          link.update();
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
