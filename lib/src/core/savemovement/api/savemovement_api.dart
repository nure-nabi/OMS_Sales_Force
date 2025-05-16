import 'dart:convert';

import 'package:oms_salesforce/model/model.dart';
import 'package:oms_salesforce/src/service/api/api.dart';
import 'package:oms_salesforce/src/utils/utils.dart';

class SaveMovementAPI {
  static saveMovement({required bodyData}) async {
    var body = jsonEncode({"objMovementDetails": bodyData});

    CustomLog.actionLog(value: "\n\n BODY => $body \n\n");

    //
    var jsonData = await APIProvider.postAPI(
      endPoint: "User/SaveMovementNew",
      body: body,
    );
    return BasicModel.fromJson(jsonData);
  }
}
