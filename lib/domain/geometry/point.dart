import 'dart:math';
import 'dart:ui';

class Point {
  double x;
  double y;

  Point(this.x, this.y);

  double distanceTo(Point point) => Point.distance(this, point);

  Point translate({double dx = 0, double dy = 0}) {
    return Point(x + dx, y + dy);
  }

  Offset toOffset() => Offset(x, y);

  bool isCloseTo(Point point, {double distance = 10}) {
    return distanceTo(point) < distance;
  }

  static fromOffset(Offset? offset) {
    if (offset == null) return null;
    return Point(offset.dx, offset.dy);
  }

  static double distance(Point pointA, Point pointB) {
    return sqrt(pow(pointA.x - pointB.x, 2) + pow(pointA.y - pointB.y, 2));
  }

  static Point middle(Point pointA, Point pointB) {
    return Point((pointB.x + pointA.x) / 2, (pointB.y + pointA.y) / 2);
  }

  Point operator +(Point point) => Point(x + point.x, y + point.y);
  Point operator -(Point point) => Point(x - point.x, y - point.y);

  @override
  String toString() => 'Point{x: ${x.round()}, y: ${y.round()}}';
}

extension OffsetExtension on Offset {
  Point toPoint() => Point(dx, dy);
}
