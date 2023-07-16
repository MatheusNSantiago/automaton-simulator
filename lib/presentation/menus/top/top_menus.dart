import 'package:automata_simulator/presentation/menus/components/menu_container.dart';
import 'package:automata_simulator/presentation/menus/components/vertical_divider.dart';
import 'package:automata_simulator/presentation/menus/top/file_name.dart';
import 'package:flutter/material.dart';

import 'hamburger_button.dart';

class TopMenus extends StatelessWidget {
  const TopMenus({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 15,
      left: 15,
      right: 15,
      child: Row(
        children: [
          MenuContainer(
            children: [
              HamburguerButton(),
              CustomVerticalDivider(),
              FileName(),
            ],
          ),
          Spacer(),
          // IconButton.filled(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.play_arrow,
          //     color: Colors.white,
          //   ),
          // )
        ],
      ),
    );
  }
}
