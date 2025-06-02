import 'package:oms_salesforce/src/service/database/database.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

import '../model/delivery_customer_model.dart';

class DeliveryReportCustomerDatabase {
  Database? db;

  DeliveryReportCustomerDatabase._privateConstructor();

  static final DeliveryReportCustomerDatabase instance =
  DeliveryReportCustomerDatabase._privateConstructor();

  Future<int> insertData(DeliveryReportCustomerDataModel data) async {
    db = await DatabaseHelper.instance.database;

   // CustomLog.actionLog(value: "DELIVERY Added => ${data.toJson()} ");
    return await db!.insert(
      DatabaseDetails.deliveryReportByCustomerTableInfo,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future deleteData() async {
    db = await DatabaseHelper.instance.database;
    return await db!
        .rawQuery(''' DELETE FROM ${DatabaseDetails.deliveryReportByCustomerTableInfo} ''');
  }

  Future<List<DeliveryReportCustomerDataModel>> getAllProductList() async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT ${DatabaseDetails.pCode}, ${DatabaseDetails.outletDesc}, ${DatabaseDetails.alias},${DatabaseDetails.quantity},${DatabaseDetails.rate},${DatabaseDetails.totalAmount}  FROM ${DatabaseDetails.deliveryReportByCustomerTableInfo} LEFT JOIN ${DatabaseDetails.outletTable} ON  ${DatabaseDetails.outletTable}.${DatabaseDetails.outletCode} = ${DatabaseDetails.deliveryReportByCustomerTableInfo}.${DatabaseDetails.outletCode} ''');

    CustomLog.successLog(
      value: "QUERY =>  SELECT * FROM ${DatabaseDetails.deliveryReportByCustomerTableInfo} ",
    );
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return DeliveryReportCustomerDataModel.fromJson(mapData[i]);
    });
  }

  Future<List<DeliveryReportCustomerDataModel>> getDateList() async {
   //  String myQuery =
    //     " SELECT  SUM(${DatabaseDetails.netAmount}) as NetAmount, ${DatabaseDetails.vDate}, ${DatabaseDetails.vMiti} from ${DatabaseDetails.deliveryTableInfo}  GROUP BY  ${DatabaseDetails.vDate}, ${DatabaseDetails.vMiti} ORDER BY ${DatabaseDetails.vDate} DESC";

     String  myQuery = ''' SELECT  SUM(${DatabaseDetails.netAmount}) as NetAmount, ${DatabaseDetails.vDate}, ${DatabaseDetails.vMiti} from ${DatabaseDetails.deliveryReportByCustomerTableInfo}  GROUP BY  ${DatabaseDetails.vDate}  ORDER BY
           substr(${DatabaseDetails.vDate}, 7) || '-' ||
           substr(${DatabaseDetails.vDate}, 4, 2) || '-' ||
           substr(${DatabaseDetails.vDate}, 1, 2) DESC ''';

    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);

    CustomLog.actionLog(value: "QUERY => $myQuery");
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return DeliveryReportCustomerDataModel.fromJson(mapData[i]);
    });
  }

  Future<List<DeliveryReportCustomerDataModel>> getOutletListFilterByDate(
      {required String englishDate}) async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT * FROM ${DatabaseDetails.deliveryReportByCustomerTableInfo} WHERE ${DatabaseDetails.vDate} = "$englishDate" ''');

    CustomLog.successLog(
      value: "QUERY =>  SELECT * FROM ${DatabaseDetails.deliveryReportByCustomerTableInfo} WHERE ${DatabaseDetails.vDate} = $englishDate"
    );
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return DeliveryReportCustomerDataModel.fromJson(mapData[i]);
    });
  }

  Future<List<DeliveryReportCustomerDataModel>> getDateWiseList({
    required String fromDate,
    required String toDate,
  }) async {
    String myQuery="";

    if(fromDate != ""){
      myQuery =   '''SELECT SUM(${DatabaseDetails.netAmount}) as NetAmount, ${DatabaseDetails.vDate}, ${DatabaseDetails.vMiti}  FROM ${DatabaseDetails.deliveryReportByCustomerTableInfo}
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
      myQuery = ''' SELECT  SUM(${DatabaseDetails.netAmount}) as NetAmount, ${DatabaseDetails.vDate}, ${DatabaseDetails.vMiti} from ${DatabaseDetails.deliveryReportByCustomerTableInfo}  GROUP BY  ${DatabaseDetails.vDate}  ORDER BY
           substr(${DatabaseDetails.vDate}, 7) || '-' ||
           substr(${DatabaseDetails.vDate}, 4, 2) || '-' ||
           substr(${DatabaseDetails.vDate}, 1, 2) DESC ''';
    }


    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);

    CustomLog.successLog(value: "MY Query Ledger => $myQuery");
    CustomLog.successLog(value: "MapData Ledger => $mapData");

    return List.generate(mapData.length, (i) {
      return DeliveryReportCustomerDataModel.fromJson(mapData[i]);
    });
  }

  Future<double> getTotal({required String glCode}) async {
    String query =
        ''' SELECT SUM(${DatabaseDetails.qty} * ${DatabaseDetails.rate}) AS totalsum FROM ${DatabaseDetails.deliveryReportByCustomerTableInfo} where GlCode ="$glCode" ''';

    db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> mapData = await db!.rawQuery(query);

    CustomLog.successLog(
      value: "QUERY =>  SELECT * FROM ${DatabaseDetails.deliveryReportByCustomerTableInfo} ",
    );
    CustomLog.successLog(value: "MapData => $mapData");

    return mapData[0]['totalsum'];
  }

  Future<int> getBrandCount({required String glCode}) async {
    String query =
        ''' SELECT COUNT(DISTINCT ${DatabaseDetails.brandCode}) AS brandCount FROM ${DatabaseDetails.deliveryReportByCustomerTableInfo} WHERE ${DatabaseDetails.glCode} = "$glCode" ''';

    db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> mapData = await db!.rawQuery(query);

    CustomLog.successLog(
      value: "QUERY =>  SELECT * FROM ${DatabaseDetails.deliveryReportByCustomerTableInfo} ",
    );
    CustomLog.successLog(value: "MapData => $mapData");

    return mapData[0]['brandCount'];
  }
}
