import 'package:automata_simulator/application/canvas_cubit/canvas_cubit.dart';
import 'package:automata_simulator/domain/geometry/quadratic_bezier.dart';
import 'package:automata_simulator/presentation/widgets/inline_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/arrow.dart';
import 'components/control_point.dart';
import 'components/transition.dart';

class LinkRenderer extends StatelessWidget {
  const LinkRenderer({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<CanvasCubit, CanvasState>(
      builder: (context, state) {
        return Stack(
          children: [
            CustomPaint(
              painter: InlinePainter(
                builder: (canvas, rect) {
                  final edgePaint = Paint()
                    ..color = colors.outlineVariant
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2;

                  for (final link in state.linkList) {
                    // Desenha a linha
                    final edgePath = Path()
                      ..moveTo(link.from.x, link.from.y)
                      ..quadraticBezierTo(
                          link.cp.x, link.cp.y, link.to.x, link.to.y);
                    canvas.drawPath(edgePath, edgePaint);

                    drawArrow(canvas, link.path);
                  }

                  if (state.isTemporaryLinkActive) {
                    // Desenha o link temporário
                    final temporaryEdgePath = Path()
                      ..moveTo(state.linkStart!.x, state.linkStart!.y)
                      ..lineTo(state.linkEnd!.x, state.linkEnd!.y);

                    canvas.drawPath(temporaryEdgePath, edgePaint);
                    drawArrow(
                      canvas,
                      QuadraticBezier.fromTwoPoints(
                        state.linkStart!.center,
                        state.linkEnd!,
                      ),
                      isTemporary: true,
                    );
                  }
                },
              ),
            ),
            for (final link in state.linkList) ...[
              TransitionText(link),
              if (link == state.selectedLink) ControlPoint(link: link),
            ]
          ],
        );
      },
    );
  }
}
