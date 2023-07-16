import 'package:automata_simulator/domain/model/node.dart';
import 'package:flutter/material.dart';

class NodeWidget extends StatelessWidget {
  final Node node;

  const NodeWidget({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final fonts = Theme.of(context).textTheme;

    return MouseRegion(
      cursor: SystemMouseCursors.allScroll,
      child: Container(
        decoration: BoxDecoration(
          color: node.color,
          shape: BoxShape.circle,
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
