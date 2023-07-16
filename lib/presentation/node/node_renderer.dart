import 'package:automata_simulator/application/canvas_cubit/canvas_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/canvas_node_delegate.dart';
import 'components/node_widget.dart';
import 'components/selection_box.dart';

class NodeRenderer extends StatelessWidget {
  const NodeRenderer({super.key});

  @override
  Widget build(BuildContext context) {
    final canvas = context.read<CanvasCubit>();

    return BlocBuilder<CanvasCubit, CanvasState>(
      buildWhen: (p, c) => p.nodesList != c.nodesList,
      builder: (context, state) {
        return CustomMultiChildLayout(
          delegate: CanvasNodesDelegate(state.nodesList),
          children: state.nodesList
              .map((node) {
                final isSelected = canvas.isNodeSelected(node);
                final isHovered = canvas.isNodeHovered(node);

                return LayoutId(
                  key: ValueKey(node.label),
                  id: node,
                  child: SizedBox.fromSize(
                    size: node.size,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        if (isSelected || isHovered)
                          SelectionBox(node: node, isSelected: isSelected),
                        NodeWidget(node: node)
                      ],
                    ),
                  ));
              })
              .toList(),
        );
      },
    );
    // return SizedBox.fromSize(
    //   size: node.size,
    //   child: Stack(
    //     clipBehavior: Clip.none,
    //     children: [
    //       if (isSelected || isHovered)
    //         SelectionBox(node: node, isSelected: isSelected),
    //       NodeWidget(node: node)
    //     ],
    //   ),
    // );
  }
}
