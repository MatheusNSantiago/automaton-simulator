part of 'canvas_cubit.dart';

class CanvasState {
  final Set<String> selected;
  final Set<String> hovered;
  final NodeList nodes;
  final Map<String, Link> links;
  final double zoom;

  Offset? marqueeStart, marqueeEnd;
  Point? linkEnd;
  Node? linkStart;
  Link? selectedLink;

  CanvasState({
    this.selected = const {},
    this.hovered = const {},
    this.nodes = NodeList.empty,
    required this.links,
    this.zoom = 1,
    this.marqueeStart,
    this.marqueeEnd,
    this.linkEnd,
    this.linkStart,
    this.selectedLink,
  });

  bool get isMarqueeActive => marqueeStart != null && marqueeEnd != null;
  bool get isTemporaryLinkActive => linkStart != null && linkEnd != null;

  List<Link> get linkList => links.values.toList();

  CanvasState copyWith({
    NodeList? nodes,
    Map<String, Link>? links,
    Set<String>? selected,
    Set<String>? hovered,
    double? zoom,
    Optional<Offset?> marqueeStart = const Optional(),
    Optional<Offset?> marqueeEnd = const Optional(),
    Optional<Node?> linkStart = const Optional(),
    Optional<Point?> linkEnd = const Optional(),
    Optional<Link?> selectedLink = const Optional(),
  }) {
    return CanvasState(
      nodes: nodes ?? this.nodes,
      links: links ?? this.links,
      selected: selected ?? this.selected,
      hovered: hovered ?? this.hovered,
      zoom: zoom ?? this.zoom,
      marqueeStart:
          marqueeStart.isValid ? marqueeStart.value : this.marqueeStart,
      linkEnd: linkEnd.isValid ? linkEnd.value : this.linkEnd,
      marqueeEnd: marqueeEnd.isValid ? marqueeEnd.value : this.marqueeEnd,
      linkStart: linkStart.isValid ? linkStart.value : this.linkStart,
      selectedLink:
          selectedLink.isValid ? selectedLink.value : this.selectedLink,
    );
  }
}
