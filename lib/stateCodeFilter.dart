import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import './Utilities.dart';
import './dataStructures.dart';

class StateCodeFilter extends StatelessWidget {
  StateCodeFilterType stateCodeFilterChoice;
  List<StateCodeFilterType> stateCodeListFilterChoices;
  ValueSetter<StateCodeFilterType> setSelectedStateCodeFilterValue;

  StateCodeFilter(
    this.stateCodeFilterChoice,
    this.stateCodeListFilterChoices,
    this.setSelectedStateCodeFilterValue,
  );
  @override
  Widget build(BuildContext context) {
    String chosenValue = stateCodeFilterChoice.toString().split('.').last;
    print('drop down value here is $chosenValue');

    var items = <String>[];
    for (int i = 0; i < stateCodeListFilterChoices.length; i++) {
      items.add(stateCodeListFilterChoices[i].toString().split('.').last);
    }

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

          StateCodeFilterType value = StateCodeFilterType.values
              .firstWhere((e) => e.toString().split('.').last == newValue);
          print('did change and try to notify parent with exact value $value');

          setSelectedStateCodeFilterValue(value);
          print('did change and did notify parent with exact value $value');
        },
      ),
    );
  }
}
