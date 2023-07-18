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
  late FocusScopeNode focusNode;

  @override
  void initState() {
    focusNode = FocusScopeNode();
    super.initState();
  }

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
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            focusNode.unfocus(disposition: UnfocusDisposition.previouslyFocusedChild);
          }
        },
        focusNode: focusNode,
        customButton: DropdownButtonPreClick(selectedItem: selectedItem),
        items: items.keys.map((item) {
          final isSelected = selectedItem == item;
          final wasSubmitted = items[item]!;

          return DropdownMenuItem(
              onTap: () => setState(() => selectedItem = item),
              value: item,
              child: InkWell(
                mouseCursor: isSelected
                    ? SystemMouseCursors.basic
                    : SystemMouseCursors.click,
                child: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF2f2f2f)
                        : Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
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

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
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
            const Iconify(
              Fe.arrow_down,
              color: Colors.white,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
