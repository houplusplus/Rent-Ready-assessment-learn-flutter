import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rent_ready_task/listDisplay.dart';

import './Account.dart';
import './listDisplay.dart';
import './gridDisplay.dart';
import 'Utilities.dart';
import './dataStructures.dart';

class AccountList extends StatelessWidget {
  final ViewType chosenViewType;
  String searchTerm;
  StateCodeFilterType selectedStateCode;
  String selectedStateOrProvince;
  List<Account> allAccounts = [];
  List<Account> displayedFilteredAccounts = [];
  ValueSetter<List<Account>> setAllAccounts;
  ValueSetter<List<Account>> setDisplayedFilteredAccounts;

  AccountList(
    this.chosenViewType,
    this.searchTerm,
    this.selectedStateCode,
    this.selectedStateOrProvince,
    this.allAccounts,
    this.displayedFilteredAccounts,
    this.setAllAccounts,
    this.setDisplayedFilteredAccounts,
  );

  @override
  Widget build(BuildContext context) {
    final suggestions = allAccounts.where((account) {
      final accountName = account.name.toLowerCase();
      final accountNumber = account.accountNumber.toLowerCase();
      final input = searchTerm;
      // query.toLowerCase();

      return accountName.contains(input) || accountNumber.contains(input);
    }).toList();

    final filteredByStateCode = suggestions.where((account) {
      final stateCode = account.stateCode;

      // filtering by state or province

      // Filtering by state code
      switch (selectedStateCode) {
        case StateCodeFilterType.all:
          {
            return true;
          }
        case StateCodeFilterType.active:
          {
            return stateCode == 1;
          }
        case StateCodeFilterType.inactive:
          {
            return stateCode == 0;
          }
      }
    }).toList();
    final filteredByStateOrProvince = filteredByStateCode.where((account) {
      final stateOrProvince = account.stateOrProvince;

      // filtering by state or province

      if (selectedStateOrProvince == 'all') {
        return true;
      } else {
        return stateOrProvince.toUpperCase() ==
            selectedStateOrProvince.toUpperCase();
      }
    }).toList();

    displayedFilteredAccounts = filteredByStateOrProvince;
    // Shows the real data with the data retrieved.
    print('allaccounts' + displayedFilteredAccounts.length.toString());
    if (chosenViewType == ViewType.grid) {
      return GridDisplay(displayedFilteredAccounts, '');
    } else {
      return ListDisplay(displayedFilteredAccounts, '');
    }
  }
}

/// Method to get accounts from the backend
Future<List<Account>> getAccounts() async {
  final response =
      await http.get(Uri.parse('https://usdtoegp.com/accounts.php/'));
  List<Account> _returnlist = [];
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print('_state');
    var _list = (jsonDecode(response.body))['value'];
    for (int i = 0; i < _list.length; i++) {
      var element = _list[i];

      _returnlist.add(
        Account(
          element['name'] ?? '',
          element['accountid'] ?? '',
          element['accountnumber'] ?? '',
          element['entityimage'] ?? '',
          element['description'] ?? '',
          element['address1_composite'] ?? '',
          element['address1_city'] ?? '',
          element['address1_country'] ?? '',
          element['address1_postalCode'] ?? '',
          element['address1_stateorprovince'] ?? '',
          element['statecode'] ?? 0,
          element['emailaddress1'] ?? '',
          element['telephone1'] ?? '',
          element['websiteurl'] ?? '',
          element.toString(),
        ),
      );
    }
    print('found' + _returnlist.length.toString() + ' accounts');

    return _returnlist;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
