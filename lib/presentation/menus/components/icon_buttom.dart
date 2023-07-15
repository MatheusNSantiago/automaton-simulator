import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
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
      icon: Icon(icon),
      color: disabled ? const Color(0XFF828282) : Colors.white,
      iconSize: iconSize,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 12.5)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}