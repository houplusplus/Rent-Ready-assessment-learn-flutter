import 'package:flutter/material.dart';
import 'Account.dart';
import 'AccountDetail.dart';

class GridDisplay extends StatelessWidget {
  List<Account> accounts;
  String searchTerm;

  GridDisplay(this.accounts, this.searchTerm);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 644.0,
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        physics: const AlwaysScrollableScrollPhysics(),
        children: List.generate(accounts.length, (index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AccountDetail(accounts[index])));
            },
            child: Container(
              height: 390,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.all(2),
              child: Card(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 3,
                          child: accounts[index].entityImage.isNotEmpty
                              ? Image.network(
                                  accounts[index].entityImage,
                                  fit: BoxFit.fill,
                                )
                              : Image.asset('placeholder.jpeg'),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            accounts[index].name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            'Payload JSON: ${accounts[index].payload}',
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /*Card(
                  color: Colors.transparent,
                  child: Text(widget.accounts[index].name),
                ),*/
            ),
          );
        }),
      ),
    );
  }
}
