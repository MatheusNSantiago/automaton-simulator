import 'package:automata_simulator/application/canvas_cubit/canvas_cubit.dart';
import 'package:automata_simulator/application/keyboard_cubit/keyboard_cubit.dart';
import 'package:automata_simulator/presentation/widgets/delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/mouse_cubit/mouse_cubit.dart';
import 'link/link_renderer.dart';
import 'listeners/keyboard_listener.dart';
import 'listeners/mouse_listener.dart';
import 'marquee.dart';
import 'node/node_renderer.dart';

class Canvas extends StatefulWidget {
  final double minScale;
  final double maxScale;

  const Canvas({
    super.key,
    this.minScale = 0.1,
    this.maxScale = 4.0,
  });

  @override
  State<Canvas> createState() => _CanvasState();
}

class _CanvasState extends State<Canvas> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CanvasKeyboardListener(
      focusNode: focusNode,
      child: CanvasMouseListener(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mouse = context.watch<MouseCubit>();
            final keyboard = context.watch<KeyboardCubit>();
            final canvas = context.read<CanvasCubit>();

            final canvasMoveEnabled = mouse.state.isUp &&
                !keyboard.state.spacePressed &&
                !keyboard.state.controlPressed;

            return InteractiveViewer(
              transformationController: canvas.getTransformationController(),
              constrained: false,
              panEnabled: false,
              scaleEnabled: false,
              onInteractionStart: (details) {
                mouse.setMousePosition(details.focalPoint);

                if (keyboard.state.controlPressed) {
                  mouse.setZoomInitialPosition(details.focalPoint);
                }
              },
              onInteractionUpdate: (details) {
                mouse.setMousePosition(details.focalPoint);

                if (keyboard.state.spacePressed) {
                  return canvas.pan(details.focalPointDelta);
                }

                if (keyboard.state.controlPressed) {
                  const double zoomSensitivity = 0.001;
                  final dy = details.focalPointDelta.dy;
                  final scale = 1 + dy * zoomSensitivity;
                  return canvas.zoom(scale, mouse.state.zoomInitialPosition);
                }

                if (canvasMoveEnabled) {
                  return canvas.pan(details.focalPointDelta);
                }

                return canvas.moveSelection(details.focalPointDelta);
              },
              minScale: widget.minScale,
              maxScale: widget.maxScale,
              boundaryMargin: const EdgeInsets.all(double.infinity),
              child: BlocBuilder<CanvasCubit, CanvasState>(
                builder: (context, state) {
                  return SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned.fill(
                            child: LinkRenderer(links: state.linkList)),
                        Positioned.fill(
                          child: CustomMultiChildLayout(
                            delegate: CanvasNodesDelegate(state.nodesList),
                            children: state.nodesList
                                .map((e) => LayoutId(
                                      key: e.key,
                                      id: e,
                                      child: NodeRenderer(node: e),
                                    ))
                                .toList(),
                          ),
                        ),
                        if (state.isMarqueeActive)
                          Positioned(
                            child: Marquee(
                              start: canvas.toScene(state.marqueeStart!),
                              end: canvas.toScene(state.marqueeEnd!),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
