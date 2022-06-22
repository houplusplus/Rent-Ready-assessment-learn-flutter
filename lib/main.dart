import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rent_ready_task/accountList.dart';
import './Account.dart';
import './accountList.dart';
import './topBar.dart';
import 'package:http/http.dart' as http;
import './Utilities.dart';
import './dataStructures.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent Ready Assessment Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<String> getStateOrProvinceFilterList(List<Account> accounts) {
  List<String> returnList = ['all'];
  for (int i = 0; i < accounts.length; i++) {
    Account a = accounts[i];
    String stateOrProvinceCode = a.stateOrProvince;
    if (!returnList.contains(stateOrProvinceCode)) {
      returnList.add(stateOrProvinceCode);
    }
  }
  return returnList;
}

class _MyHomePageState extends State<MyHomePage> {
  ViewType _chosenViewType = ViewType.list; // list or grid
  String? _searchTerm;
  StateCodeFilterType _stateCodeFilterChoice = StateCodeFilterType.all;
  String _stateOrProvinceFilterChoice = 'all';
  List<String> _stateOrProvinceListFilterChoices = ['all'];
  List<Account> _allAccounts = [];
  List<Account> _displayedFilteredAccounts = [];

  void _setAllAccounts(List<Account> accounts) {
    setState(() {
      _allAccounts = accounts;
      _stateOrProvinceListFilterChoices =
          getStateOrProvinceFilterList(accounts);
      print('_stateOrProvinceListFilterChoices are' +
          _stateOrProvinceListFilterChoices.toString());
    });
  }

  void _setDisplayedFilteredAccounts(List<Account> accounts) {
    setState(() {
      _displayedFilteredAccounts = accounts;
    });
  }

  void _setSelectedStateOrProvinceFilterList(List<String> list) {
    setState(() {
      _stateOrProvinceListFilterChoices = list;
      print('_stateOrProvinceListFilterChoices' +
          _stateOrProvinceListFilterChoices.toString());
    });
  }

  void _setSelectedStateOrProvinceFilterValue(String s) {
    setState(() {
      _stateOrProvinceFilterChoice = s;
      print('toggle filter was called' + _isFilterActive.toString());
    });
  }

  bool _isFilterActive = false;
  final List<StateCodeFilterType> _stateCodeListFilterChoices = [
    StateCodeFilterType.all,
    StateCodeFilterType.active,
    StateCodeFilterType.inactive,
  ];
  void _toggleFilter() {
    setState(() {
      _isFilterActive = !_isFilterActive;
      print('toggle filter was called' + _isFilterActive.toString());
    });
  }

  void _setStateCodeFilterChoice(StateCodeFilterType stateCodeFilterChoice) {
    setState(() {
      print('did change and  notify parent $stateCodeFilterChoice');

      _stateCodeFilterChoice = stateCodeFilterChoice;
    });
  }

  void _changeDisplayType(ViewType chosenViewType) {
    print('chosen display type is $chosenViewType');
    setState(() {
      _chosenViewType = chosenViewType;
    });
  }

  void _searchAccount(String searchString) {
    print('Searching for String $searchString');

    setState(() {
      _searchTerm = searchString;
    });
  }

  void _showTable() {
    setState(() {
      _chosenViewType = ViewType.list;
    });
  }

  void _showGrid() {
    setState(() {
      _chosenViewType = ViewType.grid;
    });
  }

  Future<List<Account>> getAccounts() async {
    final response =
        await http.get(Uri.parse('https://androididea.com/accounts.php/'));
    List<Account> _returnlist = [];
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('_state');
      var list = (jsonDecode(response.body))['value'];
      for (int i = 0; i < list.length; i++) {
        var element = list[i];

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

  @override
  Widget build(BuildContext context) {
    print('did change and notify and build with ' +
        _stateCodeFilterChoice.toString());
    return FutureBuilder(
        future: getAccounts(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            _allAccounts = snapshot.data as List<Account>;
            _stateOrProvinceListFilterChoices =
                getStateOrProvinceFilterList(_allAccounts);
            print('_stateOrProvinceListFilterChoices are' +
                _stateOrProvinceListFilterChoices.toString());
            return MaterialApp(
              title: 'Rent Ready Assessment Task',
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  scaffoldBackgroundColor: Colors.white10),
              debugShowCheckedModeBanner: false, // Remove the debug banner
              home: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.grey[200],
                  body: Center(
                    child: SizedBox(
                      width: 600,
                      height: 800,
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            TopBar(
                              _searchTerm != null ? _searchTerm! : '',
                              _chosenViewType,
                              _changeDisplayType,
                              _searchAccount,
                              _stateCodeFilterChoice,
                              _stateCodeListFilterChoices,
                              _setStateCodeFilterChoice,
                              _stateOrProvinceFilterChoice,
                              _stateOrProvinceListFilterChoices,
                              _setSelectedStateOrProvinceFilterValue,
                              _toggleFilter,
                              _isFilterActive,
                            ),
                            Column(
                              children: [
                                ...[
                                  AccountList(
                                    _chosenViewType,
                                    _searchTerm != null ? _searchTerm! : '',
                                    _stateCodeFilterChoice,
                                    _stateOrProvinceFilterChoice,
                                    _allAccounts,
                                    _displayedFilteredAccounts,
                                    _setAllAccounts,
                                    _setDisplayedFilteredAccounts,
                                  )
                                  // listWidget(context),
                                ],
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
