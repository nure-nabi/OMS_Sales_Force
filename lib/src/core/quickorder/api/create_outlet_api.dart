import 'dart:convert';

import 'package:oms_salesforce/model/model.dart';
import 'package:oms_salesforce/src/service/api/api.dart';
import 'package:oms_salesforce/src/utils/utils.dart';

class CreateOutletAPI {
  static createOutlet({
    required String dbName,
    required String agentCode,
    required String longitude,
    required String outletName,
    required String panNo,
    required String phoneNo,
    required String route,
    required String address,
    required String mobileNo,
    required String email,
    required String latitude,
    required String outletCode,
    required String contactPerson,
    required String priceTag,
    required String tag,
  }) async {
    var body = jsonEncode({
      "objLedgerDetails": [
        {
          "Longitude": longitude,
          "Latitude": latitude,
          "OutletName": outletName,
          "PanNo": panNo,
          "Tag": tag,
          "PhoneNo": phoneNo,
          "Route": route,
          "AgentCode": agentCode,
          "Address": address,
          "MobileNo": mobileNo,
          "Email": email,
          "OutletCode": outletCode,
          "ContactPerson": contactPerson,
          "PriceTag": priceTag,
          "DbName": dbName
        }
      ]
    });

    CustomLog.actionLog(value: "\n\n BODY => $body \n\n");

    //
    var jsonData = await APIProvider.postAPI(
      endPoint: "GeneralLedger/SaveOutlet",
      body: body,
    );
    return BasicModel.fromJson(jsonData);
  }
}
