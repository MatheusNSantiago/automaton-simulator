import 'dart:math';

import 'package:automata_simulator/constants.dart';
import 'package:automata_simulator/domain/geometry/point.dart';
import 'package:automata_simulator/domain/geometry/quadratic_bezier.dart';
import 'package:flutter/material.dart';

void drawArrow(
    Canvas canvas,
    QuadraticBezier linkCurve, {
    isTemporary = false,
  }) {
    const arrowLength = 15.0;
    const arrowWidth = 7.0;

    double t = isTemporary
        ? 1
        : linkCurve.getTApproximation(linkCurve.pf, offset: -kNodeRadius);

    double angle = linkCurve.getAngle(t) + pi / 2;
    Point position = linkCurve.getPoint(t);

    // ╭──────────────────────────────────────────────────────────╮
    // │                         Desenha                          │
    // ╰──────────────────────────────────────────────────────────╯
    canvas.save();

    canvas.translate(position.x, position.y);
    canvas.rotate(angle);
    // ╾──────────────────────────────────────────────────────────╼
    final arrowPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    final path = Path()
      ..lineTo(arrowWidth, arrowLength)
      ..lineTo(-arrowWidth, arrowLength)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, arrowPaint);
    // ╾──────────────────────────────────────────────────────────╼
    canvas.restore();
  }
