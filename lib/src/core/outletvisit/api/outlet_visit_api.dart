import '../../../service/api/api.dart';
import '../outletvisit.dart';

class OutletVisitAPI {
  static getData({
    required String dbName,
    required String agentCode,
    required String glCode,
    required String areaCode,
    required String fromDate,
    required String toDate,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "MasterList/OutletVisit?DbName=$dbName&AgentCode=$agentCode&Glcode=$glCode&AreaCode=$areaCode&Fromdate=$fromDate&Todate=$toDate",
    );
    return OutletVisitModel.fromJson(jsonData);
  }

  static viewMoreOutletVisit({
    required String dbName,
    required String agentCode,
    required String glCode,
    required String areaCode,
    required String fromDate,
    required String toDate,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "MasterList/OutletVisitCountdetails?DbName=$dbName&AgentCode=$agentCode&Glcode=$glCode&AreaCode=$areaCode&Fromdate=$fromDate&Todate=$toDate",
    );
    return OutletVisitModel.fromJson(jsonData);
  }
}
