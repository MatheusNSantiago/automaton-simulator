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
  String get id => '${from.label} -> ${to.label}';

  Link({
    required this.from,
    required this.to,
    this.label,
    Point? cp,
  }) {
    this.cp = cp ?? Point.middle(from.center, to.center);
  }

  bool hasNode(Node node) => (from == node) || (to == node);

  void updatePath() {
    if (!_cpWasMoved) {
      // Se o CP não mudou, então quem mudou foi a posição dos nodes e o CP deve ser atualizado
      // pra ser o ponto médio deles
      cp = Point.middle(from.center, to.center);
    }
    path = QuadraticBezier(from.center, cp, to.center);
  }

  Point get cp => _cp;
  set cp(Point cp) {
    _cp = cp;
    path = QuadraticBezier(from.center, cp, to.center);
  }

  void translateControlPoint({double dx = 0, double dy = 0}) {
    cp = cp.translate(dx: dx, dy: dy);
    _cpWasMoved = true;
  }

  Map<String, dynamic> toJson() => {
        'from': from.label,
        'to': to.label,
        'cp': cp.toJson(),
        'label': label,
      };

  factory Link.fromJson(Map<String, dynamic> json, Map<String, Node> nodes) {
    return Link(
      from: nodes[json['from']]!,
      to: nodes[json['to']]!,
      cp: Point.fromJson(json['cp']),
      label: json['label'],
    );
  }
}
