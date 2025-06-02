import '../../../../service/api/api.dart';
import '../model/branch_model.dart';

class BranchAPI {
  static Future getAgentBranchList({
    required String databaseName,
    required String agentCode,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "User/GetAgentUnitList?DbName=$databaseName&AgentCode=$agentCode",
    );

    return BranchModel.fromJson(jsonData);
  }

  static Future getCompanyBranch({
    required String databaseName,
   // required String agentCode,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
      "User/GetCompanyUnits?DbName=$databaseName&Usercode=",
      // //http://myomsapi.globaltechsolution.com.np:802/api/User/GetCompanyUnits?DbName=BRANCH0101&Usercode=
    );

    print("/User/GetCompanyUnits?DbName=$databaseName&Usercode=");
    return BranchModel.fromJson(jsonData);
  }

  static Future branch({
    required String databaseName,
    required String agentDesc,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
      "masterList/ListBranchAgent?DbName=$databaseName&AgentDesc=$agentDesc",
    );
    print("masterList/ListBranchAgent?DbName=$databaseName&AgentDesc=$agentDesc");
    return BranchResponse.fromJson(jsonData);
  }
}
