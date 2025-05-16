import 'package:oms_salesforce/src/service/api/api.dart';
import 'package:oms_salesforce/src/utils/utils.dart';

import 'model/target_achivement_model.dart';

class TargetAndAchivementAPI {
  static Future apiCall({
    required String databaseName,
    required String agentCode,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "MasterList/SalesmanTargetList?DbName=$databaseName&AgentCode=$agentCode",
    );

    CustomLog.actionLog(value: "JSON RESPONSE => $jsonData");

    return TargetAndAchivementModel.fromJson(jsonData);
  }
}
