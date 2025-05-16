import 'package:oms_salesforce/src/service/api/apiprovider.dart';

import '../model/sales_history_model.dart';

class SalesHistoryAPI {
  static Future apiCall(
      {required String databaseName,
      required String agentCode,
      required String glcode}) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "MasterList/MobileSalesHistory?DbName=$databaseName&GlCode=$glcode",
    );

    return SalesHistoryModel.fromJson(jsonData);
  }
}
