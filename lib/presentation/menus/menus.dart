import 'package:automata_simulator/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'menu_entry.dart';

class Menus extends StatefulWidget {
  const Menus({
    super.key,
    required this.child,
    this.renameLabel,
    this.visible = true,
  });

  final String Function(String)? renameLabel;
  final bool visible;
  final Widget child;

  @override
  State<Menus> createState() => _MenusState();
}

class _MenusState extends State<Menus> {
  ShortcutRegistryEntry? _shortcutsEntry;

  // @override
  // void initState() {
  //   super.initState();
  //   widget.controller.addListener(onUpdate);
  // }
  //
  // void onUpdate() {
  //   if (mounted) setState(() {});
  // }
  //
  // @override
  // void dispose() {
  //   _shortcutsEntry?.dispose();
  //   widget.controller.removeListener(onUpdate);
  //   super.dispose();
  // }
  //
  // @override
  // void didUpdateWidget(covariant Menus oldWidget) {
  //   if (oldWidget.visible != widget.visible) {
  //     if (mounted) setState(() {});
  //   }
  //   if (oldWidget.menus != widget.menus) {
  //     if (mounted) setState(() {});
  //   }
  //   super.didUpdateWidget(oldWidget);
  // }

  MenuEntry buildEdit(BuildContext context) {
    return const MenuEntry(
      label: 'Edit',
      menuChildren: [
        // const MenuEntry(
        //   label: 'Select All',
        //   // onPressed: widget.controller.selection.length ==
        //   //         widget.controller.nodes.length
        //   //     ? null
        //   //     : widget.controller.selectAll,
        //   shortcut: SingleActivator(
        //     LogicalKeyboardKey.keyA,
        //     control: true,
        //   ),
        // ),
        // const MenuEntry(
        //   label: 'Deselect All',
        //   // onPressed: widget.controller.selection.isEmpty
        //   //     ? null
        //   //     : widget.controller.deselectAll,
        //   shortcut: SingleActivator(
        //     LogicalKeyboardKey.keyA,
        //     control: true,
        //     shift: true,
        //   ),
        // ),
        // const MenuEntry(
        //   label: 'Send to back',
        //   // onPressed: widget.controller.sendToBack,
        //   shortcut: SingleActivator(
        //     LogicalKeyboardKey.bracketLeft,
        //   ),
        // ),
        // const MenuEntry(
        //   label: 'Send backward',
        //   // onPressed: widget.controller.selection.length == 1
        //       // ? widget.controller.sendBackward
        //       // : null,
        //   shortcut: SingleActivator(
        //     LogicalKeyboardKey.bracketLeft,
        //     meta: true,
        //   ),
        // ),
        // const MenuEntry(
        //   label: 'Bring forward',
        //   // onPressed: widget.controller.selection.length == 1
        //   //     ? widget.controller.sendForward
        //   //     : null,
        //   shortcut: SingleActivator(
        //     LogicalKeyboardKey.bracketRight,
        //     meta: true,
        //   ),
        // ),
        // const MenuEntry(
        //   label: 'Bring to front',
        //   // onPressed: widget.controller.bringToFront,
        //   shortcut: SingleActivator(
        //     LogicalKeyboardKey.bracketRight,
        //   ),
        // ),
        // const MenuEntry(
        //   label: 'Rename',
        //   // onPressed: widget.controller.selection.length == 1
        //   //     ? () {
        //   //         final item = widget.controller.selection.first;
        //   //         widget.controller.focusNode.unfocus();
        //   //         prompt(
        //   //           context,
        //   //           title: 'Rename child',
        //   //           value: item.label,
        //   //         ).then((value) {
        //   //           widget.controller.focusNode.requestFocus();
        //   //           if (value == null) return;
        //   //           item.update(label: value);
        //   //           widget.controller.edit(item);
        //   //         });
        //   //       }
        //   //     : null,
        //   shortcut: SingleActivator(
        //     LogicalKeyboardKey.keyR,
        //   ),
        // ),
        // MenuEntry(
        //   label: 'Delete',
        //   shortcut: const SingleActivator(
        //     LogicalKeyboardKey.keyD,
        //   ),
        //   onPressed: () {
        //     // confirm(
        //     //   context,
        //     //   title: 'Delete Selection',
        //     //   content: 'Do you want to delete the current selection?',
        //     // ).then(
        //     //   (value) {
        //     //     if (!value) return;
        //     //     widget.controller.deleteSelection();
        //     //   },
        //     // );
        //   }
        // ),
      ],
    );
  }

  // List<MenuEntry> merge(BuildContext context) {
  //   final menus = <MenuEntry>[];
  //   // menus.addAll(widget.menus);
  //   if (!menus.map((e) => e.label).contains('View')) {
  //     menus.add(buildView(context));
  //   } else {
  //     final idx = menus.indexWhere((e) => e.label == 'View');
  //     final value = menus[idx];
  //     final children = value.menuChildren ?? [];
  //     final merged = buildView(context).merge(children);
  //     menus.removeAt(idx);
  //     menus.insert(idx, merged);
  //   }
  //   if (!menus.map((e) => e.label).contains('Edit')) {
  //     menus.add(buildEdit(context));
  //   } else {
  //     final idx = menus.indexWhere((e) => e.label == 'Edit');
  //     final value = menus[idx];
  //     final children = value.menuChildren ?? [];
  //     final merged = buildEdit(context).merge(children);
  //     menus.removeAt(idx);
  //     menus.insert(idx, merged);
  //   }
  //   if (widget.renameLabel != null) {
  //     for (var i = 0; i < menus.length; i++) {
  //       final label = widget.renameLabel!(menus[i].label);
  //       menus[i] = menus[i].rename(label);
  //     }
  //   }
  //   return menus;
  // }

  // List<MenuEntry> createMenus(BuildContext context) {
  //   final result = merge(context);
  //   _shortcutsEntry?.dispose();
  //   final registry = ShortcutRegistry.of(context);
  //   final items = MenuEntry.shortcuts(result);
  //   if (items.isNotEmpty) {
  //     _shortcutsEntry = registry.addAll(items);
  //   } else {
  //     _shortcutsEntry = null;
  //   }
  //   return result;
  // }

  @override
  Widget build(BuildContext context) {
    if (!widget.visible) return widget.child;

    // final result = createMenus(context);
    return Column(
      children: <Widget>[
        if (widget.visible)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: MenuBar(
                  style: MenuStyle(
                    backgroundColor: MaterialStateProperty.all(kDarkBackground),
                  ),
                  children: const [Text("asodasi")],
                  // children: MenuEntry.build(result),
                  // children: result.map((selection) {
                  //   if (selection.menuChildren != null) {
                  //     return SubmenuButton(
                  //       menuChildren: MenuEntry.build(selection.menuChildren!),
                  //       child: Text(selection.label,
                  //           style: const TextStyle(color: Colors.white)),
                  //     );
                  //   } else {
                  //     return MenuItemButton(
                  //       shortcut: selection.shortcut,
                  //       onPressed: selection.onPressed,
                  //       child: Text(selection.label),
                  //     );
                  //   }
                  // }).toList(),
                ),
              ),
            ],
          ),
        Expanded(child: widget.child),
      ],
    );
  }
}
