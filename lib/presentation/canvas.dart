import 'package:automata_simulator/application/canvas_cubit/canvas_cubit.dart';
import 'package:automata_simulator/application/keyboard_cubit/keyboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/mouse_cubit/mouse_cubit.dart';
import 'link/link_renderer.dart';
import 'listeners/keyboard_listener.dart';
import 'listeners/mouse_listener.dart';
import 'marquee.dart';
import 'node/node_renderer.dart';

class Canvas extends StatelessWidget {
  const Canvas({super.key});

  @override
  Widget build(BuildContext context) {
    return CanvasKeyboardListener(
      child: CanvasMouseListener(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final zoomInitialPosition = context
                .select<MouseCubit, Offset>((m) => m.state.zoomInitialPosition);
            final mouse = context.watch<MouseCubit>();

            final keyboard = context.watch<KeyboardCubit>();
            final canvas = context.read<CanvasCubit>();

            final canvasMoveEnabled =
                mouse.state.isUp && !keyboard.state.controlPressed;

            return BlocBuilder<CanvasCubit, CanvasState>(
              buildWhen: (previous, current) {
                final zoomChanged = previous.zoom != current.zoom;
                return zoomChanged;
              },
              builder: (context, state) {
                final isSpacePressed = keyboard.state.spacePressed;
                final isGrabbingCanvas =
                    mouse.state.isPrimaryDown && isSpacePressed;

                return MouseRegion(
                  hitTestBehavior: HitTestBehavior.opaque,
                  cursor: isGrabbingCanvas
                      ? SystemMouseCursors.grabbing
                      : isSpacePressed
                          ? SystemMouseCursors.grab
                          : MouseCursor.defer,
                  child: InteractiveViewer(
                    transformationController:
                        canvas.getTransformationController(),
                    constrained: false,
                    panEnabled: false,
                    scaleEnabled: false,
                    onInteractionStart: (details) {
                      if (keyboard.state.controlPressed) {
                        mouse.setZoomInitialPosition(details.focalPoint);
                      }
                    },
                    onInteractionUpdate: (details) {
                      if (keyboard.state.spacePressed) {
                        return canvas.pan(details.focalPointDelta);
                      }

                      if (keyboard.state.controlPressed) {
                        const double zoomSensitivity = 0.001;
                        final dy = details.focalPointDelta.dy;
                        final scale = 1 + dy * zoomSensitivity;
                        return canvas.zoom(scale, zoomInitialPosition);
                      }

                      if (canvasMoveEnabled) {
                        return canvas.pan(details.focalPointDelta);
                      }

                      canvas.moveSelection(details.focalPointDelta);
                    },
                    child: SizedBox(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: const Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          LinkRenderer(),
                          NodeRenderer(),
                          Marquee(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
