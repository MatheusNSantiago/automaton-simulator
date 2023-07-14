import 'package:flutter/material.dart';

import '../components/icon_buttom.dart';

class HamburguerButton extends StatelessWidget {
  const HamburguerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: () {},
      icon: Icons.menu,
      iconSize: 15,
    );
  }
}
