import 'package:oms_salesforce/src/service/database/database.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../utils/utils.dart';
import '../model/save_product_availability_model.dart';

class SaveProductAvailabilityDatabase {
  Database? db;

  SaveProductAvailabilityDatabase._privateConstructor();

  static final SaveProductAvailabilityDatabase instance =
      SaveProductAvailabilityDatabase._privateConstructor();

  Future<int> insertData(SaveProductAvailabilityModel data) async {
    db = await DatabaseHelper.instance.database;
    return await db!.insert(
      DatabaseDetails.saveProductAvailability,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> isProductExist({
    required String pCode,
    required String routeCode,
    required String outletCode,
  }) async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT * FROM ${DatabaseDetails.saveProductAvailability} WHERE ${DatabaseDetails.itemCode} = "$pCode" AND ${DatabaseDetails.sRouteCode} ="$routeCode" AND ${DatabaseDetails.sOutletCode} = "$outletCode" ''');

    if (mapData.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getQtyByProductId(
      {required String pCode,
      required String routeCode,
      required String outletCode}) async {
    db = await DatabaseHelper.instance.database;
    var mapData = await db!.rawQuery(
        ''' SELECT  ${DatabaseDetails.qty} as QTY FROM ${DatabaseDetails.saveProductAvailability} WHERE ${DatabaseDetails.itemCode} = "$pCode" AND ${DatabaseDetails.sRouteCode} ="$routeCode" AND ${DatabaseDetails.sOutletCode} = "$outletCode" ''');

    String value =
        ((mapData[0]["QTY"] == null) ? 0 : mapData[0]["QTY"]).toString();
    return double.parse(value).toStringAsFixed(0);
  }

  Future deleteDataByRouteAndOutletCode(
      {required String routeCode, required String outletCode}) async {
    String myQuery =
        '''  DELETE FROM ${DatabaseDetails.saveProductAvailability}   where ${DatabaseDetails.sRouteCode} = "$routeCode" AND ${DatabaseDetails.sOutletCode} = "$outletCode" ''';
    db = await DatabaseHelper.instance.database;
    return await db!.rawQuery(myQuery);
  }

  Future deleteAllData() async {
    String myQuery =
        '''  DELETE FROM ${DatabaseDetails.saveProductAvailability} ''';
    db = await DatabaseHelper.instance.database;
    return await db!.rawQuery(myQuery);
  }

  Future<List<SaveProductAvailabilityModel>> updateQtyById({
    required String itemCode,
    required String qty,
  }) async {
    db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' UPDATE ${DatabaseDetails.saveProductAvailability} SET  ${DatabaseDetails.qty}  = "$qty" WHERE ${DatabaseDetails.itemCode} = "$itemCode"  ''');

    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return SaveProductAvailabilityModel.fromJson(mapData[i]);
    });
  }

  Future<List<SaveProductAvailabilityModel>> getAllProductByRouteOutletCode({
    required String routeCode,
    required String outletCode,
  }) async {
    String myQuery =
        ''' SELECT * FROM ${DatabaseDetails.saveProductAvailability} 
        where ${DatabaseDetails.sRouteCode} = "$routeCode" AND ${DatabaseDetails.sOutletCode} = "$outletCode" ''';

    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);

    return List.generate(mapData.length, (i) {
      return SaveProductAvailabilityModel.fromJson(mapData[i]);
    });
  }
}
