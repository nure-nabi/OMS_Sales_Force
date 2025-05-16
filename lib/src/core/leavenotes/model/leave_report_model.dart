class LeaveReportModel {
  LeaveReportModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  final String message;
  final int statusCode;
  final List<LeaveReportDataModel> data;

  factory LeaveReportModel.fromJson(Map<String, dynamic> json) {
    return LeaveReportModel(
      message: json["MESSAGE"] ?? "",
      statusCode: json["STATUS_CODE"] ?? 0,
      data: json["data"] == null
          ? []
          : List<LeaveReportDataModel>.from(
              json["data"]!.map((x) => LeaveReportDataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "MESSAGE": message,
        "STATUS_CODE": statusCode,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class LeaveReportDataModel {
  LeaveReportDataModel({
    required this.leaveId,
    required this.agentDesc,
    required this.agentCode,
    required this.dateFrom,
    required this.dateTo,
    required this.noofdays,
    required this.leaveDesc,
    required this.reason,
    required this.memo,
    required this.balanceLeave,
    required this.approved,
    required this.approvedBy,
    required this.approveRemarks,
  });

  final int leaveId;
  final String agentDesc;
  final String agentCode;
  final String dateFrom;
  final String dateTo;
  final int noofdays;
  final String leaveDesc;
  final String reason;
  final String memo;
  final int balanceLeave;
  final String approved;
  final String approvedBy;
  final String approveRemarks;

  factory LeaveReportDataModel.fromJson(Map<String, dynamic> json) {
    return LeaveReportDataModel(
      leaveId: json["LeaveId"] ?? 0,
      agentDesc: json["AgentDesc"] ?? "",
      agentCode: json["AgentCode"] ?? "",
      dateFrom: json["DateFrom"] ?? "",
      dateTo: json["DateTo"] ?? "",
      noofdays: json["Noofdays"] ?? 0,
      leaveDesc: json["LeaveDesc"] ?? "",
      reason: json["Reason"] ?? "",
      memo: json["Memo"] ?? "",
      balanceLeave: json["BalanceLeave"] ?? 0,
      approved: json["Approved"] ?? "",
      approvedBy: json["ApprovedBy"] ?? "",
      approveRemarks: json["ApproveRemarks"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "LeaveId": leaveId,
        "AgentDesc": agentDesc,
        "AgentCode": agentCode,
        "DateFrom": dateFrom,
        "DateTo": dateTo,
        "Noofdays": noofdays,
        "LeaveDesc": leaveDesc,
        "Reason": reason,
        "Memo": memo,
        "BalanceLeave": balanceLeave,
        "Approved": approved,
        "ApprovedBy": approvedBy,
        "ApproveRemarks": approveRemarks,
      };
}

/*
{
	"MESSAGE": "Succesfully",
	"STATUS_CODE": 200,
	"data": [
		{
			"LeaveId": 1,
			"AgentDesc": "SABIN",
			"AgentCode": "5",
			"DateFrom": "",
			"DateTo": "",
			"Noofdays": 10,
			"LeaveDesc": "Sick Leave",
			"Reason": "TEST",
			"Memo": "TEST",
			"BalanceLeave": 11,
			"Approved": "",
			"ApprovedBy": "",
			"ApproveRemarks": ""
		},
		{
			"LeaveId": 2,
			"AgentDesc": "SABIN",
			"AgentCode": "5",
			"DateFrom": "",
			"DateTo": "",
			"Noofdays": 10,
			"LeaveDesc": "Sick Leave",
			"Reason": "TEST",
			"Memo": "TEST",
			"BalanceLeave": 1,
			"Approved": "",
			"ApprovedBy": "",
			"ApproveRemarks": ""
		}
	]
}*/