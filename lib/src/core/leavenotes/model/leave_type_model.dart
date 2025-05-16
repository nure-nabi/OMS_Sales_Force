class LeaveTypeModel {
  LeaveTypeModel({
    required this.statusCode,
    required this.status,
    required this.data,
  });

  final int statusCode;
  final bool status;
  final List<LeaveTypeDataModel> data;

  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) {
    return LeaveTypeModel(
      statusCode: json["status_code"] ?? 0,
      status: json["status"] ?? false,
      data: json["data"] == null
          ? []
          : List<LeaveTypeDataModel>.from(
              json["data"]!.map((x) => LeaveTypeDataModel.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class LeaveTypeDataModel {
  LeaveTypeDataModel({
    required this.leaveDesc,
    required this.leaveid,
    required this.leaveDay,
    required this.takenleave,
    required this.balanceLeave,
  });

  final String leaveDesc;
  final int leaveid;
  final String leaveDay;
  final String takenleave;
  final String balanceLeave;

  factory LeaveTypeDataModel.fromJson(Map<String, dynamic> json) {
    return LeaveTypeDataModel(
      leaveDesc: json["LeaveDesc"] ?? "",
      leaveid: json["Leaveid"] ?? 0,
      leaveDay: json["LeaveDay"] ?? "",
      takenleave: json["Takenleave"] ?? "",
      balanceLeave: json["BalanceLeave"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "LeaveDesc": leaveDesc,
        "Leaveid": leaveid,
        "LeaveDay": leaveDay,
        "Takenleave": takenleave,
        "BalanceLeave": balanceLeave,
      };
}

/*
{
	"status_code": 200,
	"status": true,
	"data": [
		{
			"LeaveDesc": "Sick Leave",
			"Leaveid": 1,
			"LeaveDay": "11",
			"Takenleave": "0",
			"BalanceLeave": "11"
		}
	]
}*/