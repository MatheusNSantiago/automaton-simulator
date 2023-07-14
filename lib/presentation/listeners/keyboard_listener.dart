import 'package:automata_simulator/application/keyboard_cubit/keyboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CanvasKeyboardListener extends StatelessWidget {
  final Widget child;
  final FocusNode focusNode;

  const CanvasKeyboardListener({
    super.key,
    required this.focusNode,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    KeyboardCubit keyboardCubit = context.read<KeyboardCubit>();

    return KeyboardListener(
      focusNode: focusNode,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          switch (event.logicalKey) {
            case LogicalKeyboardKey.shift:
              keyboardCubit.shiftPressed(true);
            case LogicalKeyboardKey.control:
              keyboardCubit.controlPressed(true);
            case LogicalKeyboardKey.meta:
              keyboardCubit.metaPressed(true);
            case LogicalKeyboardKey.space:
              keyboardCubit.spacePressed(true);
            default:
              break;
          }
        }
        if (event is KeyUpEvent) {
          switch (event.logicalKey) {
            case LogicalKeyboardKey.shift:
              keyboardCubit.shiftPressed(false);
            case LogicalKeyboardKey.control:
              keyboardCubit.controlPressed(false);
            case LogicalKeyboardKey.meta:
              keyboardCubit.metaPressed(false);
            case LogicalKeyboardKey.space:
              keyboardCubit.spacePressed(false);
            default:
              break;
          }
        }
      },
      child: child,
    );
  }
}
