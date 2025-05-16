import 'dart:convert';

import 'package:oms_salesforce/model/model.dart';
import 'package:oms_salesforce/src/service/api/apiprovider.dart';

import 'model/ledger_model.dart';

class SaveJournalAPI {
  static Future getLedger({
    required String databaseName,
    required String glCode,
    required String groupCode,
    required String category,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "MasterList/ListLedger?DbName=$databaseName&Grpcode=$groupCode&Glcode=$glCode&Catagory=$category",
    );

    return JournalLedgerModel.fromJson(jsonData);
  }

  static Future saveJournal({
    required String databaseName,
    required String glCode,
    required String remarks,
    required String timeStamp,
    required String glCode1,
    required String debit,
    required String credit,
    required String userCode,
  }) async {
    var body = jsonEncode({
      "DbName": databaseName,
      "UserCode": userCode,
      "Remarks": remarks,
      "Timestamp": timeStamp,
      "CashBankDetails": [
        {
          "GlCode": glCode,
          "RecAmtount": debit,
          "PayAmount": credit,
          "GlCode1": glCode1,
          "RecAmtount1": credit,
          "PayAmount1": debit
        }
      ]
    });

    var jsonData = await APIProvider.postAPI(
      endPoint: "Order/SaveJournal",
      body: body,
    );

    return BasicModel.fromJson(jsonData);
  }
}
