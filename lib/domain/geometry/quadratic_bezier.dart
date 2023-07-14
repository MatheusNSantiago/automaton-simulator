import 'dart:math' as math;

import 'point.dart';

class QuadraticBezier {
  Point pi;
  Point cp;
  Point pf;
  List<Point> samplePoints = [];

  QuadraticBezier(this.pi, this.cp, this.pf);
  // B'(t) = 2(1 - t)(P1 - P0) + 2t(P2 - P1)
  double getAngle(double t) {
    final tangentX = 2 * (1 - t) * (cp.x - pi.x) + 2 * t * (pf.x - cp.x);
    final tangentY = 2 * (1 - t) * (cp.y - pi.y) + 2 * t * (pf.y - cp.y);

    return math.atan2(tangentY, tangentX);
  }

  // B(t) = (1 - t)^2P0 + 2(1 - t)tP1 + t^2P2
  Point getPoint(double t) {
    final x = math.pow(1 - t, 2) * pi.x +
        2 * (1 - t) * t * cp.x +
        math.pow(t, 2) * pf.x;

    final y = math.pow(1 - t, 2) * pi.y +
        2 * (1 - t) * t * cp.y +
        math.pow(t, 2) * pf.y;

    return Point(x, y);
  }

  /// Retorna o valor de t que aproxima o ponto [Point] da curva
  /// Código cagado e porcamente otimizado (mas funciona :D )
  double getTApproximation(
    Point point, {
    double offset = 0,
    stepSize = 0.1,
    int maxIterations = 90,
    errorThreshold = 0.1,
    double reductionFactor = 0.75,
    double initialT = 0.75,
  }) {
    // chute inicial
    var t = initialT;

    var distanceError = double.infinity;
    for (var i = 0; distanceError > errorThreshold && i < maxIterations; i++) {
      double newDistanceError = getPoint(t).distanceTo(point) + offset;

      if (offset != 0) {
        // Hack pra fazer funcionar casos em que o offset != 0 (não sei pq funciona)
        t += newDistanceError > 0
            ? stepSize
            : -stepSize; // o erro pode ficar negativo por conta do offset
      } else {
        if (newDistanceError < distanceError) {
          distanceError = newDistanceError;
        } else {
          stepSize = -stepSize;
        }
        t += stepSize;
      }

      // reduz o step size em [1 - reductionFactor] a cada iteração
      stepSize = stepSize * reductionFactor.clamp(0.0001, double.infinity);
    }

    return t;
  }

  /// Binary search para verificar se um ponto está a uma distância mínima da curva
  bool isPointInDistance(Point point, [double minimumDistance = 3]) {
    double t = 0.5;

    for (var i = 0; i < 10; i++) {
      Point pointOnPath = getPoint(t);

      if (pointOnPath.distanceTo(point) < minimumDistance) {
        return true;
      }
      if (pointOnPath.x > point.x) {
        t = t / 2;
      } else {
        t = (1 + t) / 2;
      }
    }

    return false;
  }

  static QuadraticBezier fromTwoPoints(Point p1, Point p2) {
    final cp = Point.middle(p1, p2);
    return QuadraticBezier(p1, cp, p2);
  }
}
