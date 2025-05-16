class CompanyModel {
  CompanyModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  final String message;
  final int statusCode;
  final List<CompanyDetailsModel> data;

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      message: json["message"] ?? "",
      statusCode: json["status_code"] ?? 0,
      data: json["data"] == null
          ? []
          : List<CompanyDetailsModel>.from(
              json["data"]!.map((x) => CompanyDetailsModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class CompanyDetailsModel {
  CompanyDetailsModel({
    required this.userCode,
    required this.loginName,
    required this.password,
    required this.userName,
    required this.createDateTime,
    required this.isEnabled,
    required this.databaseName,
    required this.companyName,
    required this.panNo,
    required this.deviceId,
    required this.agentCode,
    required this.userType,
    required this.createdBy,
    required this.createdDate,
  });

  final String userCode;
  final String loginName;
  final String password;
  final String userName;
  final String createDateTime;
  final String isEnabled;
  final String databaseName;
  final String companyName;
  final String panNo;
  final String deviceId;
  late final String agentCode;
  final String userType;
  final String createdBy;
  final String createdDate;

  factory CompanyDetailsModel.fromJson(Map<String, dynamic> json) {
    return CompanyDetailsModel(
      userCode: json["UserCode"] ?? "",
      loginName: json["LoginName"] ?? "",
      password: json["Password"] ?? "",
      userName: json["UserName"] ?? "",
      createDateTime: json["CreateDateTime"] ?? "",
      isEnabled:
          json["IsEnabled"] == null ? "false" : json["IsEnabled"].toString(),
      databaseName: json["DatabaseName"] ?? "",
      companyName: json["CompanyName"] ?? "",
      panNo: json["PanNo"] ?? "",
      deviceId: json["DeviceId"] ?? "",
      agentCode: json["AgentCode"] ?? "",
      userType: json["UserType"] ?? "",
      createdBy: json["CreatedBy"] ?? "",
      createdDate: json["CreatedDate"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "UserCode": userCode,
        "LoginName": loginName,
        "Password": password,
        "UserName": userName,
        "CreateDateTime": createDateTime,
        "IsEnabled": isEnabled,
        "DatabaseName": databaseName,
        "CompanyName": companyName,
        "PanNo": panNo,
        "DeviceId": deviceId,
        "AgentCode": agentCode,
        "UserType": userType,
        "CreatedBy": createdBy,
        "CreatedDate": createdDate,
      };
}
