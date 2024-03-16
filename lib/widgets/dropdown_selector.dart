import 'package:flutter/material.dart';

import '../constants.dart';

class DropdownSelector<T> extends StatelessWidget {
  const DropdownSelector({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  final List<T> items;
  final dynamic selectedValue;
  final void Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Constants.darkBlue,
        border: Border.all(
          color: Constants.goldColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: selectedValue,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Constants.goldColor, fontSize: 15),
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<T>>((T value) {
                // Determine display value based on type and value as this widget should work on String and Int types
                // by now it should display 'any' for 0 or 'any'
                String displayValue;
                if (value is int && value == 0) {
                  displayValue = 'Any';
                } else if (value is String && value.toLowerCase() == 'any') {
                  displayValue = 'Any';
                } else {
                  displayValue = value.toString();
                }
                if (value is String && value == "Action - Song") {
                  displayValue = 'Song';
                }
                return DropdownMenuItem<T>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(displayValue),
                  ),
                );
              }).toList(),
              isExpanded: true,
              iconEnabledColor: Constants.goldColor,
              dropdownColor: Constants.darkBlue,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),

    );
  }
}
