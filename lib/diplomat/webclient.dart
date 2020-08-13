import 'dart:convert';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

import 'package:http_interceptor/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

Future<List<Transaction>> findAll() async {
  Client client =
      HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
  final Response response =
      await client.get('http://10.0.2.2:8080/transactions').timeout(Duration(seconds: 5));
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = List();

  for (Map<String, dynamic> element in decodedJson) {
    final Transaction transaction = Transaction(
      element['value'],
      Contact.create(
        element['contact']['name'],
        element['contact']['accountNumber'],
      ),
    );

    transactions.add(transaction);
  }
  return transactions;
}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('>>> sending request');
    print('url: ${data.url}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('>>> receiving response');
    print('status code: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }
}
