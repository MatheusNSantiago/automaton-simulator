import 'package:automata_simulator/domain/geometry/point.dart';
import 'package:automata_simulator/domain/geometry/quadratic_bezier.dart';
import 'package:automata_simulator/domain/model/node.dart';

class Link {
  final Node from;
  final Node to;
  late QuadraticBezier path;
  late Point _cp;
  String? label;
  bool _cpWasMoved = false;
  String get id => '${from.id} -> ${to.id}';

  Link({
    required this.from,
    required this.to,
    this.label,
  }) {
    cp = Point.middle(from.center, to.center);
  }

  // ╭──────────────────────────────────────────────────────────╮
  // │                      Controll Point                      │
  // ╰──────────────────────────────────────────────────────────╯

  set cp(Point cp) {
    _cp = cp;
    path = QuadraticBezier(from.center, cp, to.center);
  }

  Point get cp => _cp;

  void translateControlPoint({double dx = 0, double dy = 0}) {
    cp = cp.translate(dx: dx, dy: dy);
    _cpWasMoved = true;
  }

  // ╾───────────────────────────────────────────────────────────────────────────────────╼

  bool hasNode(Node node) => from == node || to == node;

  void update() {
    if (!_cpWasMoved) cp = Point.middle(from.center, to.center);

    path = QuadraticBezier(from.center, cp, to.center);
  }
}
