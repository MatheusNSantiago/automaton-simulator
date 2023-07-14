import 'package:flutter/material.dart';

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const VerticalDivider(
      indent: 5,
      endIndent: 5,
      width: 0,
      color: Color(0XFF4F4F4F),
    );
  }
}
