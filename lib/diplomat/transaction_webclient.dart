import 'dart:convert';

import 'package:bytebank/diplomat/webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

const String baseURL = 'http://10.0.2.2:8080/transactions';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseURL).timeout(Duration(seconds: 5));
    return _toTransactions(response);
  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson.map((dynamic json) => Transaction.fromJson(json)).toList();
  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(
      baseURL,
      headers: {'Content-type': 'application/json', 'password': '1000'},
      body: transactionJson,
    );

    return Transaction.fromJson(jsonDecode(response.body));
  }
}
