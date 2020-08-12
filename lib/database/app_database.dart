import 'package:bytebank/models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:bytebank/database/contact_dao.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'bytebank.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDao.tableSQL);
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete,
  );
}
