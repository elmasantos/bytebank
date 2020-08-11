class Contact {
  int id;
  final String name;
  final int accountNumber;

  Contact(this.id, this.name, this.accountNumber);

  Contact.create(this.name, this.accountNumber);

  @override
  String toString() {
    return 'Contact id $id; name: $name; and account number: $accountNumber';
  }
}