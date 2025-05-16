import 'dart:convert';

import 'package:oms_salesforce/model/basic_model.dart';
import 'package:oms_salesforce/src/service/api/api.dart';

class SalesReturnAPI {
  static Future productSalesReturnSave({
    required String databaseName,
    required String userName,
    required String remarks,
    required String glCode,
    required String productList,
  }) async {
    var body = jsonEncode({
      "DbName": databaseName,
      "UserCode": userName,
      "Remarks": remarks,
      "GLCode": glCode,
      "Lat": "0",
      "Lng": "0",
      "BToBorderDetails": json.decode(productList),
    });
    var jsonData = await APIProvider.postAPI(
      endPoint: "Order/SalesReturnSave",
      body: body,
    );

    return BasicModel.fromJson(jsonData);
  }
}
