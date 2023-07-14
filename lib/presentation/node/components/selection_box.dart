import 'package:automata_simulator/domain/model/node.dart';
import 'package:flutter/material.dart';

class SelectionBox extends StatelessWidget {
  final Node node;
  final bool isSelected;
  final double borderInset = 2.0;

  const SelectionBox({
    super.key,
    required this.isSelected,
    required this.node,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Positioned(
      top: -borderInset,
      left: -borderInset,
      right: -borderInset,
      bottom: -borderInset,
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? colors.primary : colors.outline,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
