import 'package:automata_simulator/presentation/menus/components/icon_buttom.dart';
import 'package:automata_simulator/presentation/menus/components/menu_container.dart';
import 'package:automata_simulator/presentation/menus/components/vertical_divider.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/ci.dart';

import 'components/file_dropdown.dart';
import 'components/hamburger_menu.dart';

class TopMenus extends StatefulWidget {
  const TopMenus({super.key});

  @override
  State<TopMenus> createState() => _TopMenusState();
}

class _TopMenusState extends State<TopMenus> {
  bool _isMenuOpen = false;

  void toggleMenu() => setState(() => _isMenuOpen = !_isMenuOpen);
  void closeMenu() => setState(() => _isMenuOpen = false);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 15,
      left: 15,
      right: 15,
      child: Stack(
        children: [
          Row(
            children: [
              MenuContainer(
                children: [
                  CustomIconButton(icon: Ci.hamburger, onPressed: toggleMenu),
                  const CustomVerticalDivider(),
                  const FileDropdown(),
                ],
              ),
              const Spacer(),
              MenuContainer(children: [
                CustomIconButton(
                  icon: Carbon.send_filled,
                  iconSize: 15,
                  label: "Enviar",
                  onPressed: () {},
                ),
              ]),
            ],
          ),
          if (_isMenuOpen) HamburgerMenu(onTapOutside: closeMenu),
        ],
      ),
    );
  }
}

