import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/canvas_cubit/canvas_cubit.dart';
import 'core/inline_painter.dart';

class Marquee extends StatelessWidget {
  const Marquee({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final canvas = context.read<CanvasCubit>();

    return BlocBuilder<CanvasCubit, CanvasState>(
      buildWhen: (p, c) => p.marqueeEnd != c.marqueeEnd,
      builder: (context, state) {
        if (canvas.state.isMarqueeActive) {
          final start = canvas.toScene(state.marqueeStart!);
          final end = canvas.toScene(state.marqueeEnd!);

          return CustomPaint(
            painter: InlinePainter(
              builder: (canvas, rect) {
                final paint = Paint()
                  ..color = colors.secondary.withOpacity(0.3)
                  ..style = PaintingStyle.fill;

                final marqueeRect = Rect.fromPoints(start, end);
                canvas.drawRect(marqueeRect, paint);
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
