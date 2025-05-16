import 'package:oms_salesforce/src/service/database/database.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

import '../pendingverify.dart';

class PendingVerifyDatabase {
  Database? db;

  PendingVerifyDatabase._privateConstructor();

  static final PendingVerifyDatabase instance =
      PendingVerifyDatabase._privateConstructor();

  Future<int> insertData(PendingVerifyDataModel data) async {
    db = await DatabaseHelper.instance.database;

    CustomLog.actionLog(value: "Product Added => ${data.toJson()} ");
    return await db!.insert(
      DatabaseDetails.pendingVerifyTable,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future deleteData() async {
    db = await DatabaseHelper.instance.database;
    return await db!
        .rawQuery(''' DELETE FROM ${DatabaseDetails.pendingVerifyTable} ''');
  }

  Future<List<PendingVerifyDataModel>> getAllProductList() async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT ${DatabaseDetails.pCode}, ${DatabaseDetails.outletDesc}, ${DatabaseDetails.alias},${DatabaseDetails.quantity},${DatabaseDetails.rate},${DatabaseDetails.totalAmount}  FROM ${DatabaseDetails.pendingVerifyTable} LEFT JOIN ${DatabaseDetails.outletTable} ON  ${DatabaseDetails.outletTable}.${DatabaseDetails.outletCode} = ${DatabaseDetails.pendingVerifyTable}.${DatabaseDetails.outletCode} ''');

    CustomLog.successLog(
      value: "QUERY =>  SELECT * FROM ${DatabaseDetails.pendingVerifyTable} ",
    );
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return PendingVerifyDataModel.fromJson(mapData[i]);
    });
  }

  Future<List<PendingVerifyDataModel>> getOutletInfo() async {
    String myQuery =
        " SELECT DISTINCT ${DatabaseDetails.glCode}, ${DatabaseDetails.glDesc} from ${DatabaseDetails.pendingVerifyTable} ";
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);

    CustomLog.actionLog(value: "QUERY => $myQuery");
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return PendingVerifyDataModel.fromJson(mapData[i]);
    });
  }

  Future<List<PendingVerifyDataModel>> getProductListByGlCode(
      {required String glCode}) async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT * FROM ${DatabaseDetails.pendingVerifyTable} WHERE ${DatabaseDetails.glCode} = "$glCode" ''');

    CustomLog.successLog(
      value: "QUERY =>  SELECT * FROM ${DatabaseDetails.pendingVerifyTable} ",
    );
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return PendingVerifyDataModel.fromJson(mapData[i]);
    });
  }

  Future<double> getTotal({required String glCode}) async {
    String query =
        ''' SELECT SUM(${DatabaseDetails.qty} * ${DatabaseDetails.rate}) AS totalsum FROM ${DatabaseDetails.pendingVerifyTable} where GlCode ="$glCode" ''';

    db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> mapData = await db!.rawQuery(query);

    CustomLog.successLog(
      value: "QUERY =>  SELECT * FROM ${DatabaseDetails.pendingVerifyTable} ",
    );
    CustomLog.successLog(value: "MapData => $mapData");

    return mapData[0]['totalsum'];
  }

  Future<int> getBrandCount({required String glCode}) async {
    String query =
        ''' SELECT COUNT(DISTINCT ${DatabaseDetails.brandCode}) AS brandCount FROM ${DatabaseDetails.pendingVerifyTable} WHERE ${DatabaseDetails.glCode} = "$glCode" ''';

    db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> mapData = await db!.rawQuery(query);

    CustomLog.successLog(
      value: "QUERY =>  SELECT * FROM ${DatabaseDetails.pendingVerifyTable} ",
    );
    CustomLog.successLog(value: "MapData => $mapData");

    return mapData[0]['brandCount'];
  }
}
