import 'package:oms_salesforce/src/service/database/database.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

import '../model/delivery_model.dart';

class DeliveryReportDatabase {
  Database? db;

  DeliveryReportDatabase._privateConstructor();

  static final DeliveryReportDatabase instance =
      DeliveryReportDatabase._privateConstructor();

  Future<int> insertData(DeliveryReportDataModel data) async {
    db = await DatabaseHelper.instance.database;

    CustomLog.actionLog(value: "DELIVERY Added => ${data.toJson()} ");
    return await db!.insert(
      DatabaseDetails.deliveryTableInfo,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future deleteData() async {
    db = await DatabaseHelper.instance.database;
    return await db!
        .rawQuery(''' DELETE FROM ${DatabaseDetails.deliveryTableInfo} ''');
  }

  Future<List<DeliveryReportDataModel>> getAllProductList() async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT ${DatabaseDetails.pCode}, ${DatabaseDetails.outletDesc}, ${DatabaseDetails.alias},${DatabaseDetails.quantity},${DatabaseDetails.rate},${DatabaseDetails.totalAmount}  FROM ${DatabaseDetails.deliveryTableInfo} LEFT JOIN ${DatabaseDetails.outletTable} ON  ${DatabaseDetails.outletTable}.${DatabaseDetails.outletCode} = ${DatabaseDetails.deliveryTableInfo}.${DatabaseDetails.outletCode} ''');

    CustomLog.successLog(
      value: "QUERY =>  SELECT * FROM ${DatabaseDetails.deliveryTableInfo} ",
    );
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return DeliveryReportDataModel.fromJson(mapData[i]);
    });
  }

  Future<List<DeliveryReportDataModel>> getDateList() async {
   //  String myQuery =
    //     " SELECT  SUM(${DatabaseDetails.netAmount}) as NetAmount, ${DatabaseDetails.vDate}, ${DatabaseDetails.vMiti} from ${DatabaseDetails.deliveryTableInfo}  GROUP BY  ${DatabaseDetails.vDate}, ${DatabaseDetails.vMiti} ORDER BY ${DatabaseDetails.vDate} DESC";

     String  myQuery = ''' SELECT  SUM(${DatabaseDetails.netAmount}) as NetAmount, ${DatabaseDetails.vDate}, ${DatabaseDetails.vMiti} from ${DatabaseDetails.deliveryTableInfo}  GROUP BY  ${DatabaseDetails.vDate}  ORDER BY
           substr(${DatabaseDetails.vDate}, 7) || '-' ||
           substr(${DatabaseDetails.vDate}, 4, 2) || '-' ||
           substr(${DatabaseDetails.vDate}, 1, 2) DESC ''';

    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);

    CustomLog.actionLog(value: "QUERY => $myQuery");
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return DeliveryReportDataModel.fromJson(mapData[i]);
    });
  }

  Future<List<DeliveryReportDataModel>> getOutletListFilterByDate(
      {required String englishDate}) async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT * FROM ${DatabaseDetails.deliveryTableInfo} WHERE ${DatabaseDetails.vDate} = "$englishDate" ''');

    CustomLog.successLog(
      value: "QUERY =>  SELECT * FROM ${DatabaseDetails.deliveryTableInfo} WHERE ${DatabaseDetails.vDate} = $englishDate"
    );
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return DeliveryReportDataModel.fromJson(mapData[i]);
    });
  }

  Future<List<DeliveryReportDataModel>> getDateWiseList({
    required String fromDate,
    required String toDate,
  }) async {
    String myQuery="";

    if(fromDate != ""){
      myQuery =   '''SELECT SUM(${DatabaseDetails.netAmount}) as NetAmount, ${DatabaseDetails.vDate}, ${DatabaseDetails.vMiti}  FROM ${DatabaseDetails.deliveryTableInfo}
        where
          substr(${DatabaseDetails.vDate}, 7) || '-' ||
          substr(${DatabaseDetails.vDate}, 4, 2) || '-' ||
          substr(${DatabaseDetails.vDate}, 1, 2)  >= DATE("$fromDate")
        AND
          substr(${DatabaseDetails.vDate}, 7) || '-' ||
          substr(${DatabaseDetails.vDate}, 4, 2) || '-' ||
          substr(${DatabaseDetails.vDate}, 1, 2) <= DATE("$toDate")

          GROUP BY  ${DatabaseDetails.vDate}, ${DatabaseDetails.vMiti}

       ORDER BY
           substr(${DatabaseDetails.vDate}, 7) || '-' ||
           substr(${DatabaseDetails.vDate}, 4, 2) || '-' ||
           substr(${DatabaseDetails.vDate}, 1, 2) DESC ''';
    }
    else{
      myQuery = ''' SELECT  SUM(${DatabaseDetails.netAmount}) as NetAmount, ${DatabaseDetails.vDate}, ${DatabaseDetails.vMiti} from ${DatabaseDetails.deliveryTableInfo}  GROUP BY  ${DatabaseDetails.vDate}  ORDER BY
           substr(${DatabaseDetails.vDate}, 7) || '-' ||
           substr(${DatabaseDetails.vDate}, 4, 2) || '-' ||
           substr(${DatabaseDetails.vDate}, 1, 2) DESC ''';
    }


    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);

    CustomLog.successLog(value: "MY Query Ledger => $myQuery");
    CustomLog.successLog(value: "MapData Ledger => $mapData");

    return List.generate(mapData.length, (i) {
      return DeliveryReportDataModel.fromJson(mapData[i]);
    });
  }

  Future<double> getTotal({required String glCode}) async {
    String query =
        ''' SELECT SUM(${DatabaseDetails.qty} * ${DatabaseDetails.rate}) AS totalsum FROM ${DatabaseDetails.deliveryTableInfo} where GlCode ="$glCode" ''';

    db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> mapData = await db!.rawQuery(query);

    CustomLog.successLog(
      value: "QUERY =>  SELECT * FROM ${DatabaseDetails.deliveryTableInfo} ",
    );
    CustomLog.successLog(value: "MapData => $mapData");

    return mapData[0]['totalsum'];
  }

  Future<int> getBrandCount({required String glCode}) async {
    String query =
        ''' SELECT COUNT(DISTINCT ${DatabaseDetails.brandCode}) AS brandCount FROM ${DatabaseDetails.deliveryTableInfo} WHERE ${DatabaseDetails.glCode} = "$glCode" ''';

    db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> mapData = await db!.rawQuery(query);

    CustomLog.successLog(
      value: "QUERY =>  SELECT * FROM ${DatabaseDetails.deliveryTableInfo} ",
    );
    CustomLog.successLog(value: "MapData => $mapData");

    return mapData[0]['brandCount'];
  }
}
