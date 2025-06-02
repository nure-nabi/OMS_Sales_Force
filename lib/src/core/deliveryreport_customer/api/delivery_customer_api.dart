import 'package:oms_salesforce/src/service/api/apiprovider.dart';

import '../model/delivery_customer_model.dart';

class DeliveryReportCustomerAPI {
  static Future apiCall({
    required String dbName,
    required String brCode,
    required String unitCode,
    required String module,
    required String userCode,
    required String glCode,
    required String agentCode,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "MasterList/ListSalesInvoice?DbName=$dbName&BrCode=$brCode&UnitCode=$unitCode&Module=$module&UserCode=$userCode&GlCode=$glCode&Agentcode=$agentCode",
    );
    print( "MasterList/ListSalesInvoice?DbName=$dbName&BrCode=$brCode&UnitCode=$unitCode&Module=$module&UserCode=$userCode&GlCode=$glCode&Agentcode=$agentCode");
    return DeliveryReportReqModel.fromJson(jsonData);
  }
}
