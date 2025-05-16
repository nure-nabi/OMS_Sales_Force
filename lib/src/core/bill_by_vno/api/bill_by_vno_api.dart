import 'package:oms_salesforce/src/core/bill_by_vno/bill_by_vno.dart';
import 'package:oms_salesforce/src/service/api/api.dart';
import 'package:oms_salesforce/src/utils/utils.dart';

class BillByVNoAPI {
  static Future billPrint({
    required String databaseName,
    required String vNo,
    required String apiMethodName,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "MasterList/$apiMethodName?DbName=$databaseName&Vno=$vNo",
    );

    CustomLog.successLog(value: "RESPONSE => $jsonData");

    return ListBillModel.fromJson(jsonData);
  }
}
