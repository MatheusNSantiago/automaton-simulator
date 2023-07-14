import 'package:flutter/material.dart';

class FileName extends StatelessWidget {
  const FileName({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      onChanged: (value) {},
      underline: const SizedBox(),
      borderRadius: BorderRadius.circular(10),
      padding: const EdgeInsets.symmetric(horizontal: 13),
      items: const [
        DropdownMenuItem(
          child: Text("Exercício 2", style: TextStyle(fontSize: 15),),
        ),
      ],
    );
  }
}
