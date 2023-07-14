import 'package:automata_simulator/application/canvas_cubit/canvas_cubit.dart';
import 'package:automata_simulator/domain/model/node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/node_widget.dart';
import 'components/selection_box.dart';

class NodeRenderer extends StatelessWidget {
  const NodeRenderer({super.key, required this.node});

  final Node node;

  @override
  Widget build(BuildContext context) {
    final canvas = context.read<CanvasCubit>();
    final isSelected = canvas.isSelected(node.id);
    final isHovered = canvas.isHovered(node.id);

    return SizedBox.fromSize(
      size: node.size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (isSelected || isHovered)
            SelectionBox(node: node, isSelected: isSelected),
          NodeWidget(node: node)
        ],
      ),
    );
  }
}
