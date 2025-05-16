import 'package:oms_salesforce/src/service/api/apiprovider.dart';
import 'package:oms_salesforce/src/utils/custom_log.dart';

import 'coverageandproductivity.dart';

class CoverageProductivityAPI {
  static Future apiCall({
    required String databaseName,
    required String agentCode,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "MasterList/ProductivityTargetCoverage?DbName=$databaseName&SalesmanId=$agentCode",
    );

    CustomLog.actionLog(value: "JSON RESPONSE => $jsonData");

    return CoverageProductivityModel.fromJson(jsonData);
  }
}
