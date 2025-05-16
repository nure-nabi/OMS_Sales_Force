import 'dart:convert';

import 'package:oms_salesforce/model/model.dart';
import 'package:oms_salesforce/src/service/api/api.dart';

class PDCEntriesAPI {
  static Future postData({
    required String databaseName,
    required String branchCode,
    required String glCode,
    required String remarks,
    required String amount,
    required String chequeNo,
    required String bankName,
    required String image,
    required String timeStamp,
  }) async {
    var body = jsonEncode({
      "OutletStatusDModels": [
        {
          "DbName": databaseName,
          "BranchCode": branchCode,
          "Glcode": glCode,
          "Remarks": remarks,
          "Amount": amount,
          "ChequeNo": chequeNo,
          "BankName": bankName,
          "Timestamp": timeStamp,
          "OutletImage": image,
        }
      ]
    });

    //
    var jsonData = await APIProvider.postAPI(
      endPoint: "Order/SavePDC1",
      body: body,
    );
    return BasicModel.fromJson(jsonData);
  }
}
