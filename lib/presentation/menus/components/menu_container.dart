import 'package:automata_simulator/constants.dart';
import 'package:flutter/material.dart';

// define a type for the option if is a row or a column
enum MenuContainerType { row, column }

class MenuContainer extends StatelessWidget {
  final List<Widget> children;
  final double height;
  final double? width;
  final MenuContainerType type;
  final EdgeInsetsGeometry? padding;


  const MenuContainer({
    required this.children,
    this.height = 40,
    this.width,
    this.type = MenuContainerType.row,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: kButtonColor,
        borderRadius: BorderRadius.circular(kButtonBorderRadius),
        border: Border.all(color: kButtonBorderColor, width: 0.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: type == MenuContainerType.row
          ? Row(children: children)
          : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
    );
  }
}
