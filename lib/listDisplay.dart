import 'package:flutter/material.dart';
import 'Account.dart';
import 'AccountDetail.dart';

class ListDisplay extends StatelessWidget {
  final List<Account> accounts;
  final String searchTerm;

  const ListDisplay(
    this.accounts,
    this.searchTerm,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 650.0,
      child: ListView(
        children: List.generate(
          accounts.length,
          (index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: accounts[index].entityImage.isNotEmpty
                      ? Image.network(accounts[index].entityImage).image
                      : const AssetImage('placeholder.jpeg'),
                ),
                title: Text(accounts[index].name),
                subtitle: Text('Payload JSON: ${accounts[index].payload}'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AccountDetail(accounts[index])));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
