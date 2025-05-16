import 'package:oms_salesforce/src/service/api/apiprovider.dart';

import '../model/ageing_model.dart';

class AgingReportAPI {
  static Future apiCall(
      {required String databaseName,
      required String agentCode,
      required String glcode}) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "MasterList/AgeingReportAgentwise?DbName=$databaseName&AgentCode=$agentCode&GlCode=$glcode",
    );

    return AgeingModel.fromJson(jsonData);
  }
}
