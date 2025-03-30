import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DecoratedDropDown extends StatefulWidget {
  final List<String> list;
  final String dropDownHint;
  const DecoratedDropDown({
    super.key,
    required this.list,
    required this.dropDownHint,
  });

  @override
  State<DecoratedDropDown> createState() => _DecoratedDropDownState();
}

class _DecoratedDropDownState extends State<DecoratedDropDown> {
  String? _selectedValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            SizedBox(width: 4),
            Expanded(
              child: Text(
                widget.dropDownHint,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Get.theme.colorScheme.onSurface,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items:
            widget.list
                .map(
                  (String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                .toList(),
        value: _selectedValue,
        onChanged: (String? value) {
          setState(() {
            _selectedValue = value!;
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 160,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.black26),
            color: Get.theme.colorScheme.surface,
          ),
          elevation: 2,
        ),
        iconStyleData: IconStyleData(
          icon: Icon(Icons.arrow_forward_ios_outlined),
          iconSize: 14,
          iconEnabledColor: Get.theme.colorScheme.primary,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Get.theme.colorScheme.surface,
          ),
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(radius: const Radius.circular(40)),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
