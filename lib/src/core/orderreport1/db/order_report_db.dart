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
    return await db!.insert(
      DatabaseDetails.orderProductTableGroup,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future deleteData() async {
    db = await DatabaseHelper.instance.database;
    return await db!.rawQuery(
        ''' DELETE FROM ${DatabaseDetails.orderProductTableGroup} ''');
  }

  Future<List<OrderReportDataModel>> getDateList() async {
    String myQuery =
        "  SELECT DISTINCT ${DatabaseDetails.vDate}, SUM(${DatabaseDetails.netAmt}) as NetAmt  from ${DatabaseDetails.orderProductTableGroup}  GROUP BY ${DatabaseDetails.vDate}  ORDER BY ${DatabaseDetails.vDate} DESC";
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);

    CustomLog.actionLog(value: "QUERY => $myQuery");
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return OrderReportDataModel.fromJson(mapData[i]);
    });
  }

  Future<List<OrderReportDataModel>> getOutletListFilterByDate(
      {required String englishDate}) async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT * FROM ${DatabaseDetails.orderProductTableGroup} WHERE ${DatabaseDetails.vDate} = "$englishDate" ''');

    CustomLog.successLog(
      value:
      "QUERY =>  SELECT * FROM ${DatabaseDetails.orderProductTableGroup} ",
    );
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return OrderReportDataModel.fromJson(mapData[i]);
    });
  }

  Future<List<OrderReportDataModel>> getFilterBillList(
      {required String vno}) async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT * FROM ${DatabaseDetails.orderProductTableGroup} WHERE  ${DatabaseDetails.vNo}="$vno" ''');

    return List.generate(mapData.length, (i) {
      return OrderReportDataModel.fromJson(mapData[i]);
    });
  }

  //TO get the List of the date between the two different data of the interval of the time
  Future<List<OrderReportDataModel>> getDateWiseList({
    required String fromDate,
    required String toDate,
  }) async {
    String myQuery = "";

    //if we select the date then this query will run otherwise the else part would run
    if (fromDate.isNotEmpty) {
      myQuery = '''   WITH AggregatedData AS (
    SELECT 
        DATE(substr(${DatabaseDetails.vDate}, 1, 4) || '-' || 
             substr(${DatabaseDetails.vDate}, 6, 2) || '-' || 
             substr(${DatabaseDetails.vDate}, 9, 2)) as formattedDate,
        SUM(${DatabaseDetails.netAmt}) as NetAmt
    FROM 
        ${DatabaseDetails.orderProductTableGroup}
    WHERE 
        DATE(substr(${DatabaseDetails.vDate}, 1, 4) || '-' || 
             substr(${DatabaseDetails.vDate}, 6, 2) || '-' ||
             substr(${DatabaseDetails.vDate}, 9, 2)) >= DATE("$fromDate")
    AND 
        DATE(substr(${DatabaseDetails.vDate}, 1, 4) || '-' || 
             substr(${DatabaseDetails.vDate}, 6, 2) || '-' || 
             substr(${DatabaseDetails.vDate}, 9, 2)) <= DATE("$toDate")
    GROUP BY 
        formattedDate
)
SELECT 
    main.*, 
    sub.${DatabaseDetails.netAmt}
FROM 
    (SELECT *, 
        DATE(substr(${DatabaseDetails.vDate}, 1, 4) || '-' || 
             substr(${DatabaseDetails.vDate}, 6, 2) || '-' || 
             substr(${DatabaseDetails.vDate}, 9, 2)) as formattedDate
    FROM ${DatabaseDetails.orderProductTableGroup}) main
JOIN AggregatedData sub
ON main.formattedDate = sub.formattedDate
GROUP BY 
    main.formattedDate
ORDER BY 
    main.formattedDate DESC    ''';
    } else {
      //This query run as the default when the beginning of the screen and after then we can run the search query
      myQuery = '''   SELECT ${DatabaseDetails.vDate}, 
       SUM(${DatabaseDetails.netAmt}) AS NetAmt  
       FROM ${DatabaseDetails.orderProductTableGroup}  
       WHERE ${DatabaseDetails.vDate} >= DATE('now', '-7 days')
       GROUP BY ${DatabaseDetails.vDate}  
       ORDER BY ${DatabaseDetails.vDate} DESC   ''';
    }
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);

    CustomLog.successLog(value: "MY Query Ledger => $myQuery");
    CustomLog.successLog(value: "MapData Ledger => $mapData");

    return List.generate(mapData.length, (i) {
      return OrderReportDataModel.fromJson(mapData[i]);
    });
  }
}
