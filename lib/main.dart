import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
      home: Scaffold(
        body: Card(
          child: Column(
            children: <Widget>[
              Text('test'),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Transfers'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
        ),
      )
  ),
);
