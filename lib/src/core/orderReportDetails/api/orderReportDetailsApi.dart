import '../../../service/api/api.dart';
import '../../../utils/custom_log.dart';
import '../model/orderReportDetailsModel.dart';

class OrderReportDetailsApi {
  static Future getOrderBillReport({
    required String databaseName,
    required String vNo,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "MasterList/ListSalesOrderPrint?DbName=$databaseName&Vno=$vNo",
    );
    CustomLog.successLog(value: jsonData);
    return OrderReportDetailModel.fromJson(jsonData);
  }
}

//http://myomsapi.globaltechsolution.com.np:802/api/MasterList/ListSalesOrderPrint?DbName=ERPDEMO101&Vno=1