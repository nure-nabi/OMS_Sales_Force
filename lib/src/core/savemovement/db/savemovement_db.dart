import 'package:oms_salesforce/src/service/database/database.dart';
import 'package:sqflite/sqflite.dart';

import '../model/savemovement_model.dart';

class MovementDatabase {
  Database? db;

  MovementDatabase._privateConstructor();

  static final MovementDatabase instance =
      MovementDatabase._privateConstructor();

  Future<int> insertData(SaveMovementModel data) async {
    db = await DatabaseHelper.instance.database;
    return await db!.insert(
      DatabaseDetails.localMovementTableInfo,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future deleteData() async {
    String myQuery = '''  DELETE FROM ${DatabaseDetails.localMovementTableInfo} ''';
    db = await DatabaseHelper.instance.database;
    return await db!.rawQuery(myQuery);
  }

  Future<List<SaveMovementModel>> getLocalMovementData() async {
    String myQuery =
        '''  SELECT * FROM ${DatabaseDetails.localMovementTableInfo} ''';
    db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);

    return List.generate(mapData.length, (i) {
      return SaveMovementModel.fromJson(mapData[i]);
    });
  }
}
