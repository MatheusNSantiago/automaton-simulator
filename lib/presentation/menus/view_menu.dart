import 'package:flutter/material.dart';

import 'menu_entry.dart';

class ViewMenu extends StatelessWidget {
  const ViewMenu({super.key});

  @override
  Widget build(BuildContext context) {
  return MenuEntry(
    label: 'View',
    menuChildren: [
      MenuEntry(
        label: 'Zoom In',
        // onPressed: widget.controller.canvas.zoomIn,
          shortcut: const SingleActivator(
        onPressed: () {},
          LogicalKeyboardKey.equal,
        ),
      ),
      // MenuEntry(
      //   label: 'Zoom Out',
      //   onPressed: widget.controller.canvas.zoomOut,
      //   shortcut: const SingleActivator(
      //     LogicalKeyboardKey.minus,
      //   ),
      // ),
      // MenuEntry(
      //   label: 'Move Up',
      //   onPressed: widget.controller.canvas.panUp,
      //   shortcut: const SingleActivator(
      //     LogicalKeyboardKey.arrowUp,
      //   ),
      // ),
      // MenuEntry(
      //   label: 'Move Down',
      //   onPressed: widget.controller.canvas.panDown,
      //   shortcut: const SingleActivator(
      //     LogicalKeyboardKey.arrowDown,
      //   ),
      // ),
      // MenuEntry(
      //   label: 'Move Left',
      //   onPressed: widget.controller.canvas.panLeft,
      //   shortcut: const SingleActivator(
      //     LogicalKeyboardKey.arrowLeft,
      //   ),
      // ),
      // MenuEntry(
      //   label: 'Move Right',
      //   onPressed: widget.controller.canvas.panRight,
      //   shortcut: const SingleActivator(
      //     LogicalKeyboardKey.arrowRight,
      //   ),
      // ),
      // MenuEntry(
      //   label: 'Reset',
      //   onPressed: widget.controller.canvas.zoomReset,
      // ),
    ],
  );
  }
}
