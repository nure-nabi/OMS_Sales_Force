import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'create_table.dart';
import 'database_const.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initiateDatabase();
    return _database;
  }

  late String path;

  initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    path = join(directory.path, DatabaseDetails.databaseName);
    return await openDatabase(
      path,
      version: DatabaseDetails.dbVersion,
      onCreate: onCreate,
    );
  }

  Future<void> onDropDatabase() async {
    Database? db = await instance.database;
    await db!.delete(DatabaseDetails.clientListTable);
    await db.delete(DatabaseDetails.outletTable);
    await db.delete(DatabaseDetails.productTable);
    await db.delete(DatabaseDetails.orderProductTable);
    await db.delete(DatabaseDetails.salesReturnTable);
    await db.delete(DatabaseDetails.pendingVerifyTable);
    await db.delete(DatabaseDetails.deliveryTableInfo);
    await db.delete(DatabaseDetails.localMovementTableInfo);
    await db.delete(DatabaseDetails.ledgerDetailTable);
    await db.delete(DatabaseDetails.saveProductAvailability);
    await db.delete(DatabaseDetails.productAvailabilityTable);
  }




  Future<void> onCreate(Database db, int version) async {
    ///
    await CreateTable(db).companyListTable();

    await CreateTable(db).outletTable();

    await CreateTable(db).productTable();

    await CreateTable(db).tempOrderProductTable();

    await CreateTable(db).orderProductTable();

    await CreateTable(db).salesReturnTable();

    await CreateTable(db).pendingVerifyTable();

    await CreateTable(db).deliveryReportTable();

    await CreateTable(db).localMovementTable();

    await CreateTable(db).ledgerReportTable();

    await CreateTable(db).saveProductAvailabilityTable();
    await CreateTable(db).saveOrderReport();
    await CreateTable(db).productAvailability();

    ///
  }
}
