import 'package:automata_simulator/presentation/widgets/inline_painter.dart';
import 'package:flutter/material.dart';

class Marquee extends StatelessWidget {
  const Marquee({
    super.key,
    required this.start,
    required this.end,
  });

  final Offset start, end;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return CustomPaint(painter: InlinePainter(
      builder: (canvas, rect) {
        final paint = Paint()
          ..color = colors.secondary.withOpacity(0.3)
          ..style = PaintingStyle.fill;

        final marqueeRect = Rect.fromPoints(start, end);
        canvas.drawRect(marqueeRect, paint);
      },
    ));
  }
}
