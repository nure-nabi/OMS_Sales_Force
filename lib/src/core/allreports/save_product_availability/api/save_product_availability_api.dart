import 'dart:convert';
import 'package:oms_salesforce/src/service/api/apiprovider.dart';
import '../../../../../model/model.dart';
import '../model/save_product_availability_model.dart';

class SaveProductAvailabilityAPI {
  static Future apiCall({
    required String salesmanId,
    required String databaseName,
    required String routeCode,
    required String outletCode,
    required List<SaveProductAvailabilityModel> productDetails,
  }) async {
    var body = jsonEncode(
      {
        "CashBankDetails": productDetails.map((product) {
          return {
            "SalesmanId": salesmanId,
            "DbName": databaseName,
            "RouteCode": routeCode,
            "OutletCode": outletCode,
            "ItemCode": product.itemCode,
            "Qty": product.qty,
            "Price": product.price,
            "Lat": product.lat,
            "Lng": product.lng,
            "Timestamp": product.timestamp
          };
        }).toList()
      },
    );

    var jsonData = await APIProvider.postAPI(
      endPoint: "Order/SaveProductAvailability",
      body: body,
    );

    return BasicModel.fromJson(jsonData);
  }

  // static Future apiCall({
  //   required String salesmanId,
  //   required String databaseName,
  //   required String routeCode,
  //   required String outletCode,
  //   required String itemCode,
  //   required String qty,
  //   required String price,
  //   required String lat,
  //   required String lng,
  //   required String timeStamp,
  // }) async {
  //   var body = jsonEncode(
  //     {
  //       "CashBankDetails": [
  //         {
  //           "SalesmanId": salesmanId,
  //           "DbName": databaseName,
  //           "RouteCode": routeCode,
  //           "OutletCode": outletCode,
  //           "ItemCode": itemCode,
  //           "Qty": qty,
  //           "Price": price,
  //           "Lat": lat,
  //           "Lng": lng,
  //           "Timestamp": timeStamp
  //         }
  //       ]
  //     },
  //   );

  //   var jsonData = await APIProvider.postAPI(
  //     endPoint: "Order/SaveProductAvailability",
  //     body: body,
  //   );

  //   CustomLog.actionLog(value: "SaveProductAvailability $jsonData");

  //   return AgeingModel.fromJson(jsonData);
  // }
}
