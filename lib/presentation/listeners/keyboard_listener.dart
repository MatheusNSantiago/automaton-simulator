import 'package:automata_simulator/application/keyboard_cubit/keyboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/canvas_cubit/canvas_cubit.dart';

class CanvasKeyboardListener extends StatefulWidget {
  final Widget child;

  const CanvasKeyboardListener({super.key, required this.child});

  @override
  State<CanvasKeyboardListener> createState() => _CanvasKeyboardListenerState();
}

class _CanvasKeyboardListenerState extends State<CanvasKeyboardListener> {
  late FocusScopeNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusScopeNode();
    focusNode.requestFocus();

    focusNode.addListener(() {
      // if (focusNode.hasFocus) {
      //   print("has focus");
      // } else {
      //   print("lost focus");
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    KeyboardCubit keyboard = context.read<KeyboardCubit>();
    final canvas = context.read<CanvasCubit>();

    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        const SingleActivator(LogicalKeyboardKey.equal, control: true):
            VoidCallbackIntent(canvas.zoomIn),
        const SingleActivator(LogicalKeyboardKey.minus, control: true):
            VoidCallbackIntent(canvas.zoomOut),
        const SingleActivator(LogicalKeyboardKey.digit0, control: true):
            VoidCallbackIntent(canvas.resetZoom),
      },
      child: KeyboardListener(
        focusNode: focusNode,
        onKeyEvent: (event) {
          if (event is KeyDownEvent) {
            switch (event.logicalKey) {
              case LogicalKeyboardKey.shiftLeft:
                keyboard.shiftPressed(true);
                break;
              case LogicalKeyboardKey.controlLeft:
                keyboard.controlPressed(true);
                break;
              case LogicalKeyboardKey.meta:
                keyboard.metaPressed(true);
                break;
              case LogicalKeyboardKey.space:
                keyboard.spacePressed(true);
                break;
              default:
                break;
            }
          }
          if (event is KeyUpEvent) {
            switch (event.logicalKey) {
              case LogicalKeyboardKey.shiftLeft:
                keyboard.shiftPressed(false);
                break;
              case LogicalKeyboardKey.controlLeft:
                keyboard.controlPressed(false);
                break;
              case LogicalKeyboardKey.meta:
                keyboard.metaPressed(false);
                break;
              case LogicalKeyboardKey.space:
                keyboard.spacePressed(false);
                break;
              default:
                break;
            }
          }
        },
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
