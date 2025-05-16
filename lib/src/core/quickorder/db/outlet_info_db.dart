import 'package:oms_salesforce/src/core/quickorder/model/filter_outlet_model.dart';
import 'package:oms_salesforce/src/service/database/database.dart';
import 'package:oms_salesforce/src/utils/custom_log.dart';
import 'package:sqflite/sqflite.dart';

class OutLetInfoDatabase {
  Database? db;

  OutLetInfoDatabase._privateConstructor();

  static final OutLetInfoDatabase instance =
      OutLetInfoDatabase._privateConstructor();

  Future<int> insertData(FilterOutletInfoModel data) async {
    db = await DatabaseHelper.instance.database;
    return await db!.insert(
      DatabaseDetails.outletTable,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future deleteData() async {
    db = await DatabaseHelper.instance.database;
    return await db!
        .rawQuery(''' DELETE FROM ${DatabaseDetails.outletTable} ''');
  }


  Future updateTempCode(String tempPCode,String code) async{
    db = await DatabaseHelper.instance.database;
    CustomLog.successLog(
      value:
      "UPDATE =>  UPDATE  ${DatabaseDetails.outletTable} SET ${DatabaseDetails.tempPCode} = $code WHERE ${DatabaseDetails.routeCode} = '$tempPCode' ",
    );
    return await db!
        .rawQuery(''' UPDATE  ${DatabaseDetails.outletTable} SET ${DatabaseDetails.tempPCode} = $code WHERE ${DatabaseDetails.routeCode} = '$tempPCode' ''');
  }
// UPDATE  OutletInfo SET tempPCode = 2736 WHERE route_code = '104'
  Future<List<FilterOutletInfoModel>> getRouteData() async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT DISTINCT outlet.${DatabaseDetails.routeDesc},outlet.${DatabaseDetails.routeCode},outlet.${DatabaseDetails.tempPCode} , orderInfo.${DatabaseDetails.routeCode} as ${DatabaseDetails.routeStatus} FROM ${DatabaseDetails.outletTable} outlet left outer join  ${DatabaseDetails.orderProductTable} orderInfo on outlet.${DatabaseDetails.routeCode} = orderInfo.${DatabaseDetails.routeCode}  ORDER BY outlet.${DatabaseDetails.routeDesc} ''');

    CustomLog.successLog(value: "MapDatazsdfasdf => $mapData");
    return List.generate(mapData.length, (i) {
      return FilterOutletInfoModel.fromJson(mapData[i]);
    });
  }

  Future<List<FilterOutletInfoModel>> getOutletData({
    required String routeCode,
  }) async {
    db = await DatabaseHelper.instance.database;

    ///
    String sqlQuery =
        'SELECT DISTINCT outletInfo.*, orderInfo.${DatabaseDetails.outletCode} as ${DatabaseDetails.outletStatus} FROM ${DatabaseDetails.outletTable} outletInfo LEFT OUTER JOIN ${DatabaseDetails.orderProductTable} orderInfo ON outletInfo.${DatabaseDetails.outletCode} = orderInfo.${DatabaseDetails.outletCode}';

    if (routeCode.isNotEmpty) {
      sqlQuery =
          '$sqlQuery WHERE outletInfo.${DatabaseDetails.routeCode} = "$routeCode" ';
    }
    sqlQuery =
        '$sqlQuery ORDER BY  UPPER(outletInfo.${DatabaseDetails.outletDesc})';

    ///

    final List<Map<String, dynamic>> mapData =
        await db!.rawQuery(''' $sqlQuery ''');

    CustomLog.successLog(
      value:
          "QUERY =>  SELECT * FROM ${DatabaseDetails.outletTable} WHERE  ${DatabaseDetails.routeCode} = '$routeCode' ",
    );
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return FilterOutletInfoModel.fromJson(mapData[i]);
    });
  }
}
