import 'package:flutter/material.dart';

import 'undo_redo.dart';
import 'zoom_menu.dart';

class BottomMenus extends StatelessWidget {
  const BottomMenus({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      bottom: 15,
      left: 15,
      right: 15,
      child: Row(
        children: [
          ZoomMenu(),
          SizedBox(width: 20),
          UndoRedoMenu(),
          Spacer(),
        ],
      ),
    );
  }
}
