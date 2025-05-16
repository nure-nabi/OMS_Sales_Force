import 'package:oms_salesforce/src/core/allreports/save_product_availability/model/save_product_availability_model.dart';
import 'package:oms_salesforce/src/service/database/database.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

import '../model/product_avalability_report_model.dart';



class ProductAvailabilityReportDatabase {
  Database? db;

  ProductAvailabilityReportDatabase._privateConstructor();

  static final ProductAvailabilityReportDatabase instance =
  ProductAvailabilityReportDatabase._privateConstructor();

  Future<int> insertData(ProductAvailabilityReportModel data) async {
    db = await DatabaseHelper.instance.database;

    CustomLog.actionLog(value: "Product Added => ${data.toJson()} ");
    return await db!.insert(
      DatabaseDetails.productAvailabilityTable,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future deleteData() async {
    db = await DatabaseHelper.instance.database;
    return await db!
        .rawQuery(''' DELETE FROM ${DatabaseDetails.productAvailabilityTable} ''');
  }

  Future<List<ProductAvailabilityReportModel>> getProduct({required glCode}) async {
    String myQuery =
        " SELECT DISTINCT ${DatabaseDetails.pDesc},${DatabaseDetails.pCode},${DatabaseDetails.pADate},${DatabaseDetails.qty} from ${DatabaseDetails.productAvailabilityTable} Where ${DatabaseDetails.glCode} =$glCode";
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);
    CustomLog.actionLog(value: "QUERY => $myQuery");
    CustomLog.successLog(value: "MapData => $mapData");
    return List.generate(mapData.length, (i) {
      return ProductAvailabilityReportModel.fromJson(mapData[i]);
    });
  }

  Future<List<ProductAvailabilityReportModel>> getGlDescInfo() async {
    String myQuery =
        " SELECT DISTINCT ${DatabaseDetails.glCode},${DatabaseDetails.glDesc} from ${DatabaseDetails.productAvailabilityTable} ";
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);

    CustomLog.actionLog(value: "QUERY => $myQuery");
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return ProductAvailabilityReportModel.fromJson(mapData[i]);
    });
  }

  Future<List<ProductAvailabilityReportModel>> getProductListByPCode(
      {required String pCode}) async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' 
        SELECT ${DatabaseDetails.qty}, ${DatabaseDetails.pADate},${DatabaseDetails.pDesc} FROM ${DatabaseDetails.productAvailabilityTable} WHERE ${DatabaseDetails.pCode} = "$pCode" GROUP BY ${DatabaseDetails.pADate},${DatabaseDetails.pDesc}
           ORDER BY
           substr(${DatabaseDetails.pADate}, 7) || '-' ||
           substr(${DatabaseDetails.pADate}, 4, 2) || '-' ||
           substr(${DatabaseDetails.pADate}, 1, 2) ASC
        
        ''');

    CustomLog.successLog(value: "QUERY =>  SELECT * FROM ${DatabaseDetails.productAvailabilityTable} ");
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return ProductAvailabilityReportModel.fromJson(mapData[i]);
    });
  }

  Future<List<ProductAvailabilityReportModel>> getProductListByGlCode(
      {required String pCode}) async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' 
        SELECT SUM(${DatabaseDetails.qty}), ${DatabaseDetails.pADate},${DatabaseDetails.pDesc} FROM ${DatabaseDetails.productAvailabilityTable} WHERE ${DatabaseDetails.pCode} = "$pCode" GROUP BY ${DatabaseDetails.pADate},${DatabaseDetails.pDesc}
        
        ''');

    CustomLog.successLog(value: "QUERY =>  SELECT * FROM ${DatabaseDetails.productAvailabilityTable} ");
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return ProductAvailabilityReportModel.fromJson(mapData[i]);
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
