import 'package:automata_simulator/application/canvas_cubit/canvas_cubit.dart';
import 'package:automata_simulator/presentation/menus/components/icon_buttom.dart';
import 'package:automata_simulator/presentation/menus/components/menu_container.dart';
import 'package:automata_simulator/presentation/menus/components/vertical_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ZoomMenu extends StatefulWidget {
  const ZoomMenu({super.key});

  @override
  State<ZoomMenu> createState() => _ZoomMenuState();
}

class _ZoomMenuState extends State<ZoomMenu> {
  @override
  Widget build(BuildContext context) {
    final canvas = context.read<CanvasCubit>();

    return MenuContainer(
      children: [
        CustomIconButton(
          onPressed: () {
            canvas.zoomOut();
            setState(() {});
          },
          icon: Icons.remove_rounded,
        ),
        const CustomVerticalDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: 40,
            child: Center(child: Text("${canvas.getZoom()}%")),
          ),
        ),
        const CustomVerticalDivider(),
        CustomIconButton(
          onPressed: () {
            canvas.zoomIn();
            setState(() {});
          },
          icon: Icons.add_rounded,
        ),
      ],
    );
  }
}
