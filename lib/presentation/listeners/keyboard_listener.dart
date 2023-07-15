import 'package:automata_simulator/application/keyboard_cubit/keyboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CanvasKeyboardListener extends StatefulWidget {
  final Widget child;

  const CanvasKeyboardListener({
    super.key,
    required this.child,
  });

  @override
  State<CanvasKeyboardListener> createState() => _CanvasKeyboardListenerState();
}

class _CanvasKeyboardListenerState extends State<CanvasKeyboardListener> {
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
    KeyboardCubit keyboardCubit = context.read<KeyboardCubit>();

    return KeyboardListener(
      focusNode: focusNode,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          switch (event.logicalKey) {
            case LogicalKeyboardKey.shiftLeft:
              keyboardCubit.shiftPressed(true);
              break;
            case LogicalKeyboardKey.controlLeft:
              keyboardCubit.controlPressed(true);
              break;
            case LogicalKeyboardKey.meta:
              keyboardCubit.metaPressed(true);
              break;
            case LogicalKeyboardKey.space:
              keyboardCubit.spacePressed(true);
              break;
            default:
              break;
          }
        }
        if (event is KeyUpEvent) {
          switch (event.logicalKey) {
            case LogicalKeyboardKey.shiftLeft:
              keyboardCubit.shiftPressed(false);
              break;
            case LogicalKeyboardKey.controlLeft:
              keyboardCubit.controlPressed(false);
              break;
            case LogicalKeyboardKey.meta:
              keyboardCubit.metaPressed(false);
              break;
            case LogicalKeyboardKey.space:
              keyboardCubit.spacePressed(false);
              break;
            default:
              break;
          }
        }
      },
      child: widget.child,
    );
  }
}
