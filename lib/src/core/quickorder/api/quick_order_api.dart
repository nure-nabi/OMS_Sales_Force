import 'package:oms_salesforce/src/core/quickorder/model/quick_area_route_model.dart';
import 'package:oms_salesforce/src/service/api/api.dart';

class QuickOrderAPI {
  static getRouteAPI({
    required String dbName,
    required String agentCode,
    required String methodName,
    required String unit,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "Area/$methodName?dbName=$dbName&AgentCode=$agentCode&Unit=$unit",);
  print("Area/$methodName?dbName=$dbName&AgentCode=$agentCode&Unit=$unit");
    return QuickAreaRouteModel.fromJson(jsonData);
  }
}
