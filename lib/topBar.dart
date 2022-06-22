import 'package:flutter/material.dart';
import 'package:rent_ready_task/stateCodeFilter.dart';
import 'package:rent_ready_task/stateOrProvinceFilter.dart';
import './Utilities.dart';
import './stateCodeFilter.dart';
import './stateOrProvinceFilter.dart';
import './dataStructures.dart';

class TopBar extends StatelessWidget {
  final String searchTerm;
  final ViewType chosenViewType;
  ValueSetter<ViewType> updateDisplay;
  ValueSetter<String> searchForString;
  ValueSetter<StateCodeFilterType> setSelectedStateCodeFilterValue;
  VoidCallback toggleFilter;
  bool isFilterActive;
// for filter
  StateCodeFilterType stateCodeFilterChoice;
  List<StateCodeFilterType> stateCodeListFilterChoices;
  String stateOrProvinceFilterChoice;
  List<String> stateOrProvinceListFilterChoices;
  ValueSetter<String> setSelectedStateOrProvinceFilterValue;

  TopBar(
    this.searchTerm,
    this.chosenViewType,
    this.updateDisplay,
    this.searchForString,
    this.stateCodeFilterChoice,
    this.stateCodeListFilterChoices,
    this.setSelectedStateCodeFilterValue,
    this.stateOrProvinceFilterChoice,
    this.stateOrProvinceListFilterChoices,
    this.setSelectedStateOrProvinceFilterValue,
    this.toggleFilter,
    this.isFilterActive,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            //Search box
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: TextFormField(
                  onChanged: (text) {
                    searchForString(text);
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),

                    //border: OutlineInputBorder(
                    //borderSide: BorderSide(color: Colors.blueAccent, width: 0.0),
                    // borderRadius: BorderRadius.circular(25.0),
                    // ),
                    // focusedBorder: OutlineInputBorder(
                    //  borderSide: BorderSide(color: Colors.white, width: 32.0),
                    //  borderRadius: BorderRadius.circular(25.0),
                    // ),
                  ),
                ),
              ),
            ),

            //filter button
            Container(
              padding: const EdgeInsets.all(0),
              //color: Colors.yellow,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: isFilterActive ? Colors.green : Colors.grey.shade800,
                ),
                onPressed: toggleFilter,
                //color: Colors.orange,
                //padding: EdgeInsets.all(10.0),
                child: Row(
                  // Replace with a Row for horizontal icon + text
                  children: const <Widget>[
                    Icon(Icons.filter_alt),
                    Text("Filter")
                  ],
                ),
              ),
            ),

            /*TextButton(
            style: TextButton.styleFrom(
              primary: Colors.grey.shade800,
            ),
            onPressed: () => {},
            //color: Colors.orange,
            //padding: EdgeInsets.all(10.0),
            child: Row(
              // Replace with a Row for horizontal icon + text
              children: const <Widget>[Icon(Icons.filter_alt), Text("Filter")],
            ),
          ),*/
            //     MouseRegion(
            //   cursor: SystemMouseCursors.click,
            //   child: GestureDetector(
            //     onTap: toggleFilter,
            //     child: Center(
            //       //color: Colors.orange,
            //       //padding: EdgeInsets.all(10.0),
            //       child: Row(
            //         // Replace with a Row for horizontal icon + text
            //         children: const <Widget>[
            //           Icon(Icons.filter_alt),
            //           Text("Filter")
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

            //list button
            Container(
              padding: const EdgeInsets.all(0),
              //  color: Colors.blueAccent,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.grey.shade800,
                ),
                // onPressed: chosenViewType == ViewType.grid ? _showTable : null,
                onPressed: chosenViewType == ViewType.grid
                    ? () => updateDisplay(ViewType.list)
                    : null,
                //color: Colors.orange,
                //padding: EdgeInsets.all(10.0),
                child: Row(
                  // Replace with a Row for horizontal icon + text
                  children: const <Widget>[
                    Icon(Icons.format_list_bulleted),
                    Text("")
                  ],
                ),
              ),
            ),

            //grid button
            Container(
              padding: const EdgeInsets.all(0),
              //color: Colors.green,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.grey.shade800,
                ),
                // onPressed: chosenViewType == ViewType.list ? _showGrid : null,
                onPressed: chosenViewType == ViewType.list
                    ? () => updateDisplay(ViewType.grid)
                    : null,

                //color: Colors.orange,
                //padding: EdgeInsets.all(10.0),
                child: Row(
                  // Replace with a Row for horizontal icon + text
                  children: const <Widget>[
                    Icon(Icons.grid_view_rounded),
                    Text("")
                  ],
                ),
              ),
            ),
          ],
        ),
        isFilterActive
            ? Container(
                color: Colors.grey[200],
                child: Row(children: [
                  const Padding(
                    padding:
                        EdgeInsets.all(15), //apply padding to all four sides
                    child: Text("StateCode"),
                  ),
                  Expanded(
                    flex: 4,
                    child: StateCodeFilter(
                      stateCodeFilterChoice,
                      stateCodeListFilterChoices,
                      setSelectedStateCodeFilterValue,
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.all(15), //apply padding to all four sides
                    child: Text("StateOrProvince"),
                  ),
                  Expanded(
                    flex: 4,
                    child: StateOrProvinceFilter(
                      stateOrProvinceFilterChoice,
                      stateOrProvinceListFilterChoices,
                      setSelectedStateOrProvinceFilterValue,
                    ),
                  ),
                ]))
            : Divider()
      ],
    );
  }
}
