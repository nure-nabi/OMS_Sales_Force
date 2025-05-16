import 'dart:convert';

import 'package:oms_salesforce/model/basic_model.dart';
import 'package:oms_salesforce/src/core/allreports/model/ledger_notes_model.dart';
import 'package:oms_salesforce/src/service/api/apiprovider.dart';

class SaveLedgerNotesAPI {
  static Future saveNotes({
    required String databaseName,
    required String glCode,
    required String remarks,
    required String timeStamp,
    required String lat,
    required String long,
  }) async {
    var body = jsonEncode({
      "OutletStatusDModels": [
        {
          "DbName": databaseName,
          "Glcode": glCode,
          "Remarks": remarks,
          "Timestamp": timeStamp,
          "Lat": lat,
          "Lng": long
        }
      ]
    });

    var jsonData = await APIProvider.postAPI(
      endPoint: "Order/SaveLedgerNote",
      body: body,
    );

    return BasicModel.fromJson(jsonData);
  }

  static Future notesList({
    required String databaseName,
    required String glCode,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "MasterList/LedgerNoteList?DbName=$databaseName&Glcode=$glCode",
    );

    return LedgerNoteModel.fromJson(jsonData);
  }
}
