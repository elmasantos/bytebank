import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'diplomat/webclient.dart';

void main() {
  runApp(BytebankApp());
//  save(Transaction(7651, Contact(0, 'Name', 9876))).then((transaction) {
//    debugPrint('transaction');
//    debugPrint('$transaction');
//  });
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurple[400],
        accentColor: Colors.deepPurpleAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.deepPurpleAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Dashboard(),
    );
  }
}
