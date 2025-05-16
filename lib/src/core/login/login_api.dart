import 'package:oms_salesforce/model/model.dart';
import 'package:oms_salesforce/src/service/api/apiprovider.dart';

import 'company_model.dart';

class LoginAPI {
  static Future login({
    required String username,
    required String password,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "User/Login?username=$username&password=$password",
    );

    return CompanyModel.fromJson(jsonData);
  }

  static Future updateAgentCode({
    required String username,
    required String dbName,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "User/getMobileAgentCode?username=$username&DbName=$dbName",
    );

    return CompanyModel.fromJson(jsonData);
  }

  static Future updateMobileNumber({
    required String username,
    required String deviceId,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "User/UpdateDeviceId?username=$username&deviceid=$deviceId",
    );

    return BasicModel.fromJson(jsonData);
  }
}
