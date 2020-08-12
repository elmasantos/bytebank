import 'package:http/http.dart';

void findAll() async {
  final Response response = await get('http://10.0.2.2:8080/transactions');
  print(response);
}
