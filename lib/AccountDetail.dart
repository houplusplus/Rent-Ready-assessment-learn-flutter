import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './Account.dart';

class AccountDetail extends StatelessWidget {
  // Account object to handle.
  Account account;

  // Constructor for the class.
  AccountDetail(this.account);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(account.name),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 600,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: account.entityImage.isNotEmpty
                    ? Image.network(
                        account.entityImage,
                        fit: BoxFit.fill,
                      )
                    : Image.asset('placeholder.jpeg'),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Code to create the view for name.
                    Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "Name: " + account.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Code to create the view for release date.
                    Text(
                      "Payload: " + account.payload,
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
