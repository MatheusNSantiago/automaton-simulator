import 'package:automata_simulator/constants.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class CustomIconButton extends StatelessWidget {
  final Function() onPressed;
  final String icon;
  final double iconSize;
  final bool disabled;

  const CustomIconButton({
    required this.onPressed,
    required this.icon,
    this.iconSize = 20,
    this.disabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Iconify(icon, size: iconSize, color: disabled ? kFaintTextColor : Colors.white),
      color: disabled ? kFaintTextColor : Colors.white,
      iconSize: iconSize,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 12.5),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
