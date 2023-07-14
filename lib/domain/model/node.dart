import 'package:automata_simulator/constants.dart';
import 'package:automata_simulator/domain/geometry/point.dart';
import 'package:flutter/material.dart';

class Node {
  final LocalKey key;
  Size size;
  Point position;
  String label;
  final Color color;

  Node({
    required this.key,
    required this.position,
    required this.label,
    this.color = Colors.blueAccent,
    this.size = const Size.fromRadius(kNodeRadius),
  });

  String get id => key.toString();
  Rect get rect => position.toOffset() & size;
  Point get center => Point.fromOffset(rect.center);

  double get x => center.x;
  double get y => center.y;

  Node translate({double dx = 0, double dy = 0}) {
    position = position.translate(dx: dx, dy: dy);
    return this;
  }
}
