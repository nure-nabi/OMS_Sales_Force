import 'package:oms_salesforce/src/service/api/apiprovider.dart';

import 'model/activity_model.dart';

class ActivityGPSAPI {
  static Future apiCall({
    required String databaseName,
    required String agentCode,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "User/ListSalesmanActivityGPSReport?DbName=$databaseName&AgentCode=$agentCode",
    );

    return SalesmanActivityModel.fromJson(jsonData);
  }
}
