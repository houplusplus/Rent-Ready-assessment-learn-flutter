import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import './Utilities.dart';

class StateOrProvinceFilter extends StatelessWidget {
  String stateOrProvinceFilterChoice;
  List<String> stateOrProvinceListFilterChoices;
  ValueSetter<String> setSelectedStateOrProvinceFilterValue;

  StateOrProvinceFilter(
    this.stateOrProvinceFilterChoice,
    this.stateOrProvinceListFilterChoices,
    this.setSelectedStateOrProvinceFilterValue,
  );
  @override
  Widget build(BuildContext context) {
    String chosenValue = stateOrProvinceFilterChoice;
    print('drop down value here is $chosenValue');

    var items = stateOrProvinceListFilterChoices;

    // List of items in our dropdown menu

    return Center(
      child: DropdownButton(
        // Initial Value
        value: chosenValue,
        isExpanded: true,
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          print('did change and try to notify parent $newValue');

          setSelectedStateOrProvinceFilterValue(newValue ?? 'all');
          print('did change and did notify parent with exact value $newValue');
        },
      ),
    );
  }
}
