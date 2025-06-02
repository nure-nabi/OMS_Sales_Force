import 'package:oms_salesforce/model/basic_model.dart';
import 'package:oms_salesforce/src/utils/custom_log.dart';
import '../../../service/api/apiprovider.dart';
import '../model/order_report_model.dart';

class OrderReportAPI {
  static getOrderReport({
    required String dbName,
    required String agentcode,
  }) async {
    var jsonData = await APIProvider.getAPI(endPoint: "MasterList/PendingOrderVerifyList?DbName=$dbName&BrCode=&UnitCode=&Module=&UserCode=&Glcode=&Agentcode=$agentcode",);
       CustomLog.successLog(value: jsonData);

    return OrderReportModel.fromJson(jsonData);
  }

  static updatePendingOrder({
    required String dbName,
    required String vNo,
    required String userCode,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "MasterList/UpdatePendingOrderVerifyList?DbName=$dbName&Vno=$vNo&UserCode=$userCode",
    );
    CustomLog.successLog(value: jsonData);
    return BasicModel.fromJson(jsonData);
  }
}
