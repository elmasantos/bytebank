import 'package:bytebank/models/transfer.dart';
import 'package:bytebank/screens/transfer/form.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';


class TransfersList extends StatefulWidget {
  final List<Transfer> _transfers = List();

  @override
  State<StatefulWidget> createState() {
    return TransfersListState();
  }
}

class TransfersListState extends State<TransfersList> {
  @override
  Widget build(BuildContext context) {
    const _appBarTitle = 'Transfers';

    return Scaffold(
      body: ListView.builder(
        itemCount: widget._transfers.length,
        itemBuilder: (context, index) {
          final transfer = widget._transfers[index];
          return TransferItem(transfer);
        },
      ),
      appBar: AppBar(
        title: Text(_appBarTitle),
        actions: <Widget>[
          ScopedModelDescendant<DarkModeModel>(
            builder: (context, snapshot, model) {
              return IconButton(
                icon: Icon(Icons.lightbulb_outline),
                onPressed: () {
                   model.toggle();
                },
              );
            }
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future future = Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TransferForm();
          }));
          future.then((transferReceived) {
            debugPrint('arrived at then of the future');
            debugPrint('$transferReceived');
            if (transferReceived != null) {
              setState(() {
                widget._transfers.add(transferReceived);
              });
            }
          });
        },
      ),
    );
  }
}

class TransferItem extends StatelessWidget {

  final Transfer _transfer;

  TransferItem(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transfer.value.toString()),
        subtitle: Text(_transfer.accountNumber.toString()),
      ),
    );
  }
}