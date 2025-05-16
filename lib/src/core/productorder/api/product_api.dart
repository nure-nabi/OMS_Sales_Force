import 'dart:convert';

import 'package:oms_salesforce/model/model.dart';
import 'package:oms_salesforce/src/service/api/api.dart';
import 'package:oms_salesforce/src/utils/custom_log.dart';

import '../../login/branch/model/branch_model.dart';

class OrderProductAPI {
  static postOrder({
    required String dbName,
    required String branchCode,
    required String salesManId,
    required orderDetails,
  }) async {
    var body = jsonEncode({
      "DbName": dbName,
      "BranchCode": branchCode,
      "SalesmanId": salesManId,
      "OrderDetails": orderDetails
    });

    CustomLog.warningLog(value: "\n\n\n\n\n\n BODY of Sales Order =>  $body");

    var jsonData = await APIProvider.postAPI(
      endPoint: "Order/SaveOrder",
      body: body,
    );
    // return ProductModel.fromJson(jsonData);
    return BasicModel.fromJson(jsonData);
    // CustomLog.actionLog(value: "\n\n\n TEST TTTTTT =>  $jsonData");

    // return jsonData;
  }

  static Future branch({
    required String dbName,
    required String usercode,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "User/GetCompanyUnits?DbName=$dbName&Usercode=$usercode",
    );

    //http://myomsapi.globaltechsolution.com.np:802/api/masterList/ListBranchLedger?dbname=Erpdemo101&AgentDesc=Bivan Shrestha
    return BranchModel.fromJson(jsonData);
  }
}
