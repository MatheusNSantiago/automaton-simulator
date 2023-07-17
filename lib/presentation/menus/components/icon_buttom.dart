import 'package:automata_simulator/constants.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

enum IconPosition { left, right }

class CustomIconButton extends StatelessWidget {
  final Function() onPressed;
  final String icon;
  final double iconSize;
  final bool disabled;
  final String? label;
  final TextStyle? textStyle;
  final IconPosition iconPosition;
  final double padding;

  const CustomIconButton({
    required this.onPressed,
    required this.icon,
    this.iconSize = 20,
    this.disabled = false,
    this.label,
    this.textStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    this.iconPosition = IconPosition.right,
    this.padding = 5,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: (label != null)
          ? Row(
              children: [
                if (iconPosition == IconPosition.right)
                  Padding(
                    padding: EdgeInsets.only(right: padding),
                    child: Text(label!, style: textStyle),
                  ),
                Iconify(
                  icon,
                  size: iconSize,
                  color: disabled ? kFaintTextColor : Colors.white,
                ),
                if (iconPosition == IconPosition.left)
                  Padding(
                    padding: EdgeInsets.only(left: padding),
                    child: Text(label!, style: textStyle),
                  ),
              ],
            )
          : Iconify(
              icon,
              size: iconSize,
              color: disabled ? kFaintTextColor : Colors.white,
            ),
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
