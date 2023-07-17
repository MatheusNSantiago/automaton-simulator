import 'package:automata_simulator/application/keyboard_cubit/keyboard_cubit.dart';
import 'package:automata_simulator/domain/model/node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NodeWidget extends StatelessWidget {
  final Node node;

  const NodeWidget({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final fonts = Theme.of(context).textTheme;
    final spacePressed = context
        .select<KeyboardCubit, bool>((cubit) => cubit.state.spacePressed);

    return MouseRegion(
      cursor: spacePressed ? MouseCursor.defer : SystemMouseCursors.allScroll,
      child: Container(
        decoration: BoxDecoration(
          color: node.color,
          shape: BoxShape.circle,
          border: Border.all(
            color: colors.onSurface.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0.8, 0.8),
              blurRadius: 13,
              color: node.color.withOpacity(0.3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            node.label,
            style: fonts.bodyMedium?.copyWith(
              color: colors.onSurface,
              shadows: [
                Shadow(
                  offset: const Offset(0.8, 0.8),
                  blurRadius: 3,
                  color: colors.surface,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
