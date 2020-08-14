import 'package:bytebank/models/transaction.dart';

class Contact {
  int id;
  final String name;
  final int accountNumber;

  Contact(this.id, this.name, this.accountNumber);

  Contact.create(this.name, this.accountNumber);

  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        accountNumber = json['accountNumber'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'accountNumber': accountNumber,
      };

  @override
  String toString() {
    return 'Contact id $id; name: $name; and account number: $accountNumber';
  }
}
