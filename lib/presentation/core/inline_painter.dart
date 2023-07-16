import 'package:flutter/material.dart';

class InlinePainter extends CustomPainter {
  final void Function(Canvas canvas, Rect rect) builder;

  const InlinePainter({required this.builder});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    canvas.save();
    builder(canvas, rect);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
