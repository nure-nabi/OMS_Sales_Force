import 'dart:convert';

import 'package:oms_salesforce/model/model.dart';
import 'package:oms_salesforce/src/service/api/api.dart';

class SaveCashBankAPI {
  static Future saveCashBank({
    required String databaseName,
    required String branchCode,
    required String userName,
    required String remark,
    required String timeStamp,
    required String recAmount,
    required String payAmount,
    required String glCode,
  }) async {
    List<Map<String, dynamic>> cashBankDetails = [];
    cashBankDetails = [
      {"GlCode": glCode, "RecAmtount": recAmount, "PayAmount": payAmount}
    ];

    var body = jsonEncode({
      "DbName": databaseName,
      "BranchCode": branchCode,
      "UserCode": userName,
      "Remarks": remark,
      "Timestamp": timeStamp,
      "CashBankDetails": cashBankDetails,
    });

    //
    var jsonData = await APIProvider.postAPI(
      endPoint: "Order/SaveCashBank",
      body: body,
    );
    return BasicModel.fromJson(jsonData);
  }
}
