import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/database/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
              ),
              style: TextStyle(fontSize: 24.0),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _accountNumberController,
                decoration: InputDecoration(
                  labelText: 'Account Number',
                ),
                style: TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: CreateButton(_nameController, _accountNumberController, _dao),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CreateButton extends StatelessWidget {
  final TextEditingController _nameController;
  final TextEditingController _accountNumberController;
  final ContactDao _dao;

  CreateButton(this._nameController, this._accountNumberController, this._dao);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Create'),
      onPressed: () {
        final String name = _nameController.text;
        final int accountNumber = int.tryParse(_accountNumberController.text);

        if(name != null && name.length != 0 && accountNumber != null) {
          final Contact newContact = Contact.create(name, accountNumber);
          _dao.save(newContact).then((id) => Navigator.pop(context));
        } else {
          final snackBar = SnackBar(content: Text('Please fill in all the fields.'));
          Scaffold.of(context).showSnackBar(snackBar);
        }
      },
    );
  }
}
