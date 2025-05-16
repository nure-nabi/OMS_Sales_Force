import 'package:oms_salesforce/src/service/database/database.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

import '../model/order_report_model.dart';


class OrderReportDatabase {
  Database? db;

  OrderReportDatabase._privateConstructor();

  static final OrderReportDatabase instance =
  OrderReportDatabase._privateConstructor();

  Future<int> insertData(OrderReportDataModel data) async {
    db = await DatabaseHelper.instance.database;

    CustomLog.actionLog(value: "Order data => ${data.toJson()} ");
    return await db!.insert(
      DatabaseDetails.saveOrderReportTable,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future deleteData() async {
    db = await DatabaseHelper.instance.database;
    return await db!.rawQuery(''' DELETE FROM ${DatabaseDetails.saveOrderReportTable} ''');
  }

  Future<List<OrderReportDataModel>> getDateList() async {
    String myQuery =
        ''' SELECT * from ${DatabaseDetails.saveOrderReportTable} ''';
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);

    CustomLog.actionLog(value: "QUERY => $myQuery");
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return OrderReportDataModel.fromJson(mapData[i]);
    });
  }

  Future<List<OrderReportDataModel>> getDateWiseList({
    required String fromDate,
    required String toDate,
  }) async {
    String myQuery="";

    //2024-08/02
    //02/05/2024
    // if(fromDate != ""){
    //   myQuery =   '''SELECT * FROM ${DatabaseDetails.saveOrderReportTable}
    //     where
    //       substr(${DatabaseDetails.vDate}, 7) || '-' ||
    //       substr(${DatabaseDetails.vDate}, 4, 2) || '-' ||
    //       substr(${DatabaseDetails.vDate}, 1, 2)  >= DATE("$fromDate")
    //     AND
    //       substr(${DatabaseDetails.vDate}, 7) || '-' ||
    //       substr(${DatabaseDetails.vDate}, 4, 2) || '-' ||
    //       substr(${DatabaseDetails.vDate}, 1, 2) <= DATE("$toDate")
    //
    //    ORDER BY
    //        substr(${DatabaseDetails.vDate}, 7) || '-' ||
    //        substr(${DatabaseDetails.vDate}, 4, 2) || '-' ||
    //        substr(${DatabaseDetails.vDate}, 1, 2) ASC ''';
    // }
    // else{
    //   myQuery = ''' select * from PurchaseReportTable ''';
    // }

    myQuery = ''' 
    SELECT * FROM ${DatabaseDetails.saveOrderReportTable} Where ${DatabaseDetails.vDate} >= "$fromDate" 
    AND ${DatabaseDetails.vDate} <= "$toDate"  ORDER BY ${DatabaseDetails.vDate} desc
    ''';

    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);

    CustomLog.successLog(value: "MY Query Ledger => $myQuery");
    CustomLog.successLog(value: "MapData Ledger => $mapData");

    return List.generate(mapData.length, (i) {
      return OrderReportDataModel.fromJson(mapData[i]);
    });
  }

}
