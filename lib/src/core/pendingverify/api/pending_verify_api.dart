import 'package:oms_salesforce/src/core/pendingverify/model/pending_verify_model.dart';
import 'package:oms_salesforce/src/service/api/api.dart';
import 'package:oms_salesforce/src/utils/utils.dart';

class PendingVeriyAPI {
  static getData({
    required String dbName,
    required String agentCode,
  }) async {
    //
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "Order/PendingOrderVerifyList?DbName=$dbName&SalesmanId=$agentCode",
      // "Order/PendingOrderVerifyList?DbName=$dbName&SalesmanId=4",
    );

    CustomLog.log(value: "JSON DATA : $jsonData");

    return PendingVerifyModel.fromJson(jsonData);
  }
}
