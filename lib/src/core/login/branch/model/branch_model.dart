class BranchModel {
  BranchModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  final String message;
  final int statusCode;
  final List<BranchDataModel> data;

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      message: json["message"] ?? "",
      statusCode: json["status_code"] ?? 0,
      data: json["data"] == null
          ? []
          : List<BranchDataModel>.from(
              json["data"]!.map((x) => BranchDataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class BranchDataModel {
  BranchDataModel({
    required this.unitCode,
    required this.unitDesc,
    required this.unitShortName,
  });

  final String unitCode;
  final String unitDesc;
  final String unitShortName;

  factory BranchDataModel.fromJson(Map<String, dynamic> json) {
    return BranchDataModel(
      unitCode: json["UnitCode"] ?? "",
      unitDesc: json["UnitDesc"] ?? "",
      unitShortName: json["UnitShortName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "UnitCode": unitCode,
        "UnitDesc": unitDesc,
        "UnitShortName": unitShortName,
      };
}


class BranchResponse {
  BranchResponse({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  final String message;
  final int statusCode;
  final List<BranchModelAgent> data;

  factory BranchResponse.fromJson(Map<String, dynamic> json) {
    return BranchResponse(
      message: json["MESSAGE"] ?? "",
      statusCode: json["STATUS_CODE"] ?? 0,
      data: json["data"] == null
          ? []
          : List<BranchModelAgent>.from(
          json["data"]!.map((x) => BranchModelAgent.fromJson(x))),
    );
  }

  // Map<String, dynamic> toJson() => {
  //   "message": message,
  //   "status_code": statusCode,
  //   "data": data.map((x) => x.toJson()).toList(),
  // };
}



class BranchModelAgent {
  BranchModelAgent({
    required this.agentCode,
    required this.branchCode,
    required this.agentDesc,
    required this.agentShortName,
  });

  final String agentCode;
  final String branchCode;
  final String agentDesc;
  final String agentShortName;

  factory BranchModelAgent.fromJson(Map<String, dynamic> json) {
    return BranchModelAgent(
      agentCode: json["AgentCode"] ?? "",
      branchCode: json["BranchCode"] ?? "",
      agentDesc: json["AgentDesc"] ?? "",
      agentShortName: json["AgentShortName"] ?? "",
    );
  }

  // Map<String, dynamic> toJson() => {
  //   "UnitCode": unitCode,
  //   "UnitDesc": unitDesc,
  //   "UnitShortName": unitShortName,
  // };
}


