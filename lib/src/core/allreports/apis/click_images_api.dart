import 'dart:convert';

import 'package:oms_salesforce/model/model.dart';
import 'package:oms_salesforce/src/service/api/api.dart';
import 'package:oms_salesforce/src/utils/custom_log.dart';

class ClickImageAPI {
  //  await MyLocation().lat(),
  static Future postData({
    required String databaseName,
    required String salesmanId,
    required String routeCode,
    required String outletCode,
    required String remarks,
    required String lat,
    required String long,
    required String image,
    required String timeStamp,
  }) async {
    var body = jsonEncode({
      "OutletStatusDModels": [
        {
          "DbName": databaseName,
          "SalesmanId": salesmanId,
          "RouteCode": routeCode,
          "OutletCode": outletCode,
          "OutletStatus": remarks,
          "Lat": lat,
          "Lng": long,
          "Timestamp": timeStamp,
          "OutletImage": image
        }
      ]
    });

    CustomLog.warningLog(value: "BODY => $body");
    //
    var jsonData = await APIProvider.postAPI(
      endPoint: "Order/SaveOutletStatus",
      body: body,
    );

    // CustomLog.warningLog(value: "JSON => ${jsonEncode(json)}");
    return BasicModel.fromJson(jsonData);
  }
}
