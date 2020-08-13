import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/diplomat/webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatefulWidget {
  @override
  _TransactionsListState createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
          future:
              Future.delayed(Duration(seconds: 1)).then((value) => findAll()),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress();
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                List<Transaction> transactions = snapshot.data;
                if(transactions != null && transactions.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      Transaction transaction = transactions[index];
                      return _TransactionItem(transaction);
                    },
                    itemCount: transactions.length,
                  );
                }
                return CenteredMessage(
                  'No transactions found',
                  icon: Icons.warning,
                );
                break;
            }
            return Text('Unknown error');
          }),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final Transaction transaction;

  _TransactionItem(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(
          transaction.value.toString(),
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          transaction.contact.accountNumber.toString(),
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
