import 'package:automata_simulator/constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fe.dart';


class FileDropdown extends StatefulWidget {
  const FileDropdown({super.key});

  @override
  State<FileDropdown> createState() => _FileDropdownState();
}

class _FileDropdownState extends State<FileDropdown> {
  final Map<String, bool> items = {
    'Exercício 1': true,
    'Exercício 2': true,
    'Exercício 3': false,
    'Exercício 4': false,
    'Exercício 5': false,
    'Exercício 6': false,
    'Exercício 7': false,
  };

  String selectedItem = 'Exercício 1';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: DropdownButtonPreClick(selectedItem: selectedItem),
        items: items.keys.map((item) {
          final isSelected = selectedItem == item;
          final wasSubmitted = items[item]!;

          return DropdownMenuItem(
              enabled: !isSelected,
              onTap: () => setState(() => selectedItem = item),
              value: item,
              child: InkWell(
                child: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  decoration: BoxDecoration(
                    border: isSelected
                        ? const Border(
                            left: BorderSide(color: kNodeColor, width: 2))
                        : null,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 15,
                            color: (wasSubmitted || isSelected)
                                ? Colors.white
                                : kFaintTextColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        wasSubmitted
                            ? Icons.check_circle_rounded
                            : Icons.query_builder,
                        color: wasSubmitted ? Colors.green : kFaintTextColor,
                        size: 17,
                      )
                    ],
                  ),
                ),
              ));
        }).toList(),
        value: selectedItem,
        onChanged: (value) {},
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.zero,
        ),
        dropdownStyleData: DropdownStyleData(
          width: 137,
          isOverButton: true,
          offset: const Offset(0, 8),
          padding: const EdgeInsets.only(bottom: 2),
          decoration: BoxDecoration(
            color: kButtonColor,
            border: Border.all(color: kButtonBorderColor, width: 0.2),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}

class DropdownButtonPreClick extends StatelessWidget {
  const DropdownButtonPreClick({
    super.key,
    required this.selectedItem,
  });

  final String selectedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0),
      child: SizedBox(
        width: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedItem,
              style: const TextStyle(fontSize: 14.5),
            ),
            const Iconify(Fe.arrow_down, color: Colors.white, size: 14,),
          ],
        ),
      ),
    );
  }
}
