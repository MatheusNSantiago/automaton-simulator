import 'package:automata_simulator/application/keyboard_cubit/keyboard_cubit.dart';
import 'package:automata_simulator/domain/geometry/point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/canvas_cubit/canvas_cubit.dart';
import '../../../application/mouse_cubit/mouse_cubit.dart';

class CanvasMouseListener extends StatelessWidget {
  final Widget child;

  const CanvasMouseListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final mouse = context.read<MouseCubit>();
    final keyboard = context.read<KeyboardCubit>();
    final canvas = context.read<CanvasCubit>();

    return Listener(
      onPointerDown: (details) {
        mouse.down(details.buttons);

        final isPanning = keyboard.state.spacePressed;
        if (isPanning) return;

        if (mouse.state.isPrimaryDown) {
          canvas.checkSelection(details.localPosition);

          /* Seleciona um link  */
          final selectedLink = canvas.getLinkCloseToPoint(
            details.localPosition,
            minimumDistance: 10,
          );
          final oldSelectedLink = canvas.state.selectedLink;
          if (selectedLink != oldSelectedLink) {
            final clickWasNotOnALinkPath = selectedLink == null;

            if (clickWasNotOnALinkPath) {
              // Ao clicar fora de um linkpath, quer dizer que ele quer:
              //   1. deselecionar o link atual
              //   2. mover o control point do link atual

              final isTheControlPoint = oldSelectedLink!.cp
                  .isCloseTo(details.localPosition.toPoint());
              if (!isTheControlPoint) canvas.setSelectedLink(selectedLink);
            } else {
              canvas.setSelectedLink(selectedLink);
            }
          }

          /* Começar Seleção */
          if (canvas.state.selected.isEmpty) {
            canvas.setMarquee(
              start: details.position,
              end: details.position,
            );
          }
        } else if (mouse.state.isSecondaryDown) {
          // Começar um novo link temporário
          canvas.deselectAll();
          final linkStart = canvas.getNodeOnPosition(details.localPosition);

          if (linkStart != null) {
            canvas.startTemporaryLink(startAt: linkStart);
          }
        }
      },
      onPointerUp: (details) {
        mouse.up();

        if (canvas.state.isMarqueeActive) {
          canvas.checkMarqueeSelection();
        }

        if (canvas.state.isTemporaryLinkActive) {
          final linkEnd = canvas.getNodeOnPosition(details.localPosition);
          if (linkEnd != null) {
            canvas.addLink(canvas.state.linkStart!, linkEnd);
          }
        }

        canvas.deselectAll(true);
        canvas.clearMarquee();
        canvas.clearTemporaryLink();
      },
      onPointerCancel: (details) => mouse.up(),
      onPointerHover: (details) {
        mouse.setMousePosition(details.localPosition);
      },
      onPointerMove: (details) {
        if (canvas.state.isTemporaryLinkActive) {
          canvas.updateTemporaryLink(end: details.localPosition);
          return;
        }

        canvas.checkSelection(mouse.state.position, true);
        canvas.setMarquee(
          start: canvas.state.marqueeStart,
          end: details.localPosition,
        );

        if (canvas.state.isMarqueeActive) {
          canvas.checkMarqueeSelection(true);
        }
      },
      child: GestureDetector(
        onDoubleTapDown: (details) => canvas.addNode(details.localPosition),
        child: child,
      ),
    );
  }
}
