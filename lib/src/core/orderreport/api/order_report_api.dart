import 'package:oms_salesforce/model/basic_model.dart';
import '../../../service/api/apiprovider.dart';
import '../model/order_report_model.dart';

class OrderReportAPI {
  static getOrderReport({
    required String dbName,
    required String glCode,
    required String agentCode,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "MasterList/PendingOrderVerifyList?DbName=$dbName&Glcode=$glCode&Agentcode=$agentCode",
    );
    return OrderReportModel.fromJson(jsonData);
  }

  static updatePendingOrder({
    required String dbName,
    required String vNo,
    required String userCode,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "MasterList/UpdatePendingOrderVerifyList?DbName=$dbName&Vno=$vNo&UserCode=$userCode",
    );
    return BasicModel.fromJson(jsonData);
  }
}
