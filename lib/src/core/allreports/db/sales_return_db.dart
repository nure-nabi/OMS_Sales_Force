import 'package:oms_salesforce/src/core/productorder/model/product_order_model.dart';
import 'package:oms_salesforce/src/service/database/database.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

import '../../pendingsync/pendingsync.dart';

class SalesReturnDatabase {
  Database? db;

  SalesReturnDatabase._privateConstructor();

  static final SalesReturnDatabase instance =
      SalesReturnDatabase._privateConstructor();

  Future<int> insertData(ProductOrderModel data) async {
    db = await DatabaseHelper.instance.database;

    CustomLog.actionLog(value: "Product Added => ${data.toJson()} ");
    return await db!.insert(
      DatabaseDetails.salesReturnTable,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future deleteData() async {
    db = await DatabaseHelper.instance.database;
    return await db!
        .rawQuery(''' DELETE FROM ${DatabaseDetails.salesReturnTable} ''');
  }

  Future deleteById({required String pCode}) async {
    db = await DatabaseHelper.instance.database;
    return await db!.rawQuery(
        ''' DELETE FROM ${DatabaseDetails.salesReturnTable} WHERE ${DatabaseDetails.pCode} = "$pCode"  ''');
  }

  Future<List<ProductPendingSync>> editDataById(
      {required String productID,
      required String rate,
      required String quantity}) async {
    db = await DatabaseHelper.instance.database;
    String totalAmount =
        (double.parse(rate) * double.parse(quantity)).toStringAsFixed(2);
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' UPDATE ${DatabaseDetails.salesReturnTable} SET ${DatabaseDetails.rate} = "$rate", ${DatabaseDetails.quantity}  = "$quantity", ${DatabaseDetails.totalAmount} = "$totalAmount"  WHERE ${DatabaseDetails.pCode} = "$productID"  ''');

    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return ProductPendingSync.fromJson(mapData[i]);
    });
  }

  Future<List<ProductPendingSync>> getAllProductList() async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
        ''' SELECT ${DatabaseDetails.pCode}, ${DatabaseDetails.outletDesc}, ${DatabaseDetails.alias},${DatabaseDetails.quantity},${DatabaseDetails.rate},${DatabaseDetails.totalAmount}  FROM ${DatabaseDetails.salesReturnTable} LEFT JOIN ${DatabaseDetails.outletTable} ON  ${DatabaseDetails.outletTable}.${DatabaseDetails.outletCode} = ${DatabaseDetails.salesReturnTable}.${DatabaseDetails.outletCode} ''');

    CustomLog.successLog(
      value: "QUERY =>  SELECT * FROM ${DatabaseDetails.salesReturnTable} ",
    );
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return ProductPendingSync.fromJson(mapData[i]);
    });
  }

  Future<List<ProductOrderModel>> getSalesReturnDetails() async {
    String myQuery =
        " SELECT DISTINCT ${DatabaseDetails.routeCode}, ${DatabaseDetails.outletCode}, ${DatabaseDetails.orderBy}, ${DatabaseDetails.comment} from ${DatabaseDetails.salesReturnTable} ";
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);

    CustomLog.actionLog(value: "QUERY => $myQuery");
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return ProductOrderModel.fromJson(mapData[i]);
    });
  }

  Future<List<ProductOrderModel>> getSalesReturnByOutletAndRoute(
      {required String outletCode, required String routeCode}) async {
    String myQuery =
        " SELECT * FROM ${DatabaseDetails.salesReturnTable} WHERE ${DatabaseDetails.routeCode} = '$routeCode' AND ${DatabaseDetails.outletCode} = '$outletCode'  ";
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);

    CustomLog.actionLog(value: "QUERY => $myQuery");
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return ProductOrderModel.fromJson(mapData[i]);
    });
  }

  // /// [ THIS METHOD IS USED FOR DATA POST.
  // ///   THE SAVED ORDER IS RECEIVED AS NEEDED FORMAT  ]
  // Future<List<OrderPostModel>> getFormatPOSTDATA() async {
  //   String myQuery = ''' SELECT  ${DatabaseDetails.routeCode} AS RouteCode,
  //                   ${DatabaseDetails.outletCode} AS OutletCode,
  //                    ${DatabaseDetails.orderBy},
  //                    ${DatabaseDetails.comment},
  //            '[' || GROUP_CONCAT( '{
  //                     "TotalAmt":"' || TotalAmount || '",
  //                     "Qty":"' || Quantity || '",
  //                     "Rate":"' || Rate || '",
  //                     "ItemCode":"' || PCode || '"
  //                 }' ) || ']'
  //        AS ItemDetails
  //        FROM ${DatabaseDetails.salesReturnTable}
  //        GROUP BY ${DatabaseDetails.routeCode}, ${DatabaseDetails.outletCode}, ${DatabaseDetails.orderBy}, ${DatabaseDetails.comment} ''';
  //   db = await DatabaseHelper.instance.database;
  //   final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);

  //   CustomLog.actionLog(value: "QUERY => $myQuery");
  //   CustomLog.successLog(value: "MapData => $mapData");
  //   String long = await MyLocation().long();
  //   String lat = await MyLocation().lat();
  //   return List.generate(mapData.length, (i) {
  //     return OrderPostModel.fromJson(
  //       json: mapData[i],
  //       long: long,
  //       lat: lat,
  //     );
  //   });
  // }
}
