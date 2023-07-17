import 'package:automata_simulator/application/canvas_cubit/canvas_cubit.dart';
import 'package:automata_simulator/presentation/menus/components/icon_buttom.dart';
import 'package:automata_simulator/presentation/menus/components/menu_container.dart';
import 'package:automata_simulator/presentation/menus/components/vertical_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/icons/ant_design.dart';


class ZoomMenu extends StatelessWidget {
  const ZoomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CanvasCubit, CanvasState>(
      buildWhen: (previous, current) => previous.zoom != current.zoom,
      builder: (context, state) {
        final canvas = context.read<CanvasCubit>();

        return MenuContainer(
          children: [
            CustomIconButton(
              onPressed: canvas.zoomOut,
              icon: AntDesign.minus,
              iconSize: 18,
            ),
            const CustomVerticalDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: 40,
                child: Center(child: Text("${(state.zoom * 100).round()}%")),
              ),
            ),
            const CustomVerticalDivider(),
            CustomIconButton(
              onPressed: canvas.zoomIn,
              icon: AntDesign.plus,
              iconSize: 18,
            ),
          ],
        );
      },
    );
  }
}
