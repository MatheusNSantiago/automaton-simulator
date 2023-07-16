import 'package:automata_simulator/constants.dart';
import 'package:flutter/material.dart';
import 'package:automata_simulator/domain/geometry/point.dart';

class Node {
  Size size = const Size.fromRadius(kNodeRadius);
  Point position;
  String label;
  final Color color;

  Node({
    required this.position,
    required this.label,
    this.color = Colors.blueAccent,
  });

  Rect get rect => position.toOffset() & size;
  Point get center => Point.fromOffset(rect.center);

  double get x => center.x;
  double get y => center.y;

  Node translate({double dx = 0, double dy = 0}) {
    position = position.translate(dx: dx, dy: dy);
    return this;
  }

  Map<String, dynamic> toJson() => {
        'position': position.toJson(),
        'label': label,
        'color': color.value,
      };

  factory Node.fromJson(Map<String, dynamic> json) {
    return Node(
      position: Point.fromJson(json['position']),
      label: json['label'],
      color: Color(json['color']),
    );
  }
}
