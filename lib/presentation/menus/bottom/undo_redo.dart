import 'package:automata_simulator/presentation/menus/components/icon_buttom.dart';
import 'package:automata_simulator/presentation/menus/components/menu_container.dart';
import 'package:automata_simulator/presentation/menus/components/vertical_divider.dart';
import 'package:flutter/material.dart';

class UndoRedoMenu extends StatelessWidget {
  const UndoRedoMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuContainer(
      children: [
        CustomIconButton(
          onPressed: () {},
          icon: Icons.undo_rounded,
          disabled: true,
        ),
        const CustomVerticalDivider(),
        CustomIconButton(
          onPressed: () {},
          icon: Icons.redo_rounded,
        ),
      ],
    );
  }
}
