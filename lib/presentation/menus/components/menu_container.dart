import 'package:automata_simulator/constants.dart';
import 'package:flutter/material.dart';

class MenuContainer extends StatelessWidget {
  final List<Widget> children;

  const MenuContainer({ required this.children, super.key, });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: kButtonColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0XFF828282), width: 0.2),
      ),
      child: Row(
        children: children,
        ),
    );
  }
}
