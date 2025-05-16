class TargetAndAchivementModel {
  TargetAndAchivementModel({
    required this.statusCode,
    required this.status,
    required this.data,
  });

  final int statusCode;
  final bool status;
  final List<TargetAndAchivementDataModel> data;

  factory TargetAndAchivementModel.fromJson(Map<String, dynamic> json) {
    return TargetAndAchivementModel(
      statusCode: json["status_code"] ?? 0,
      status: json["status"] ?? false,
      data: json["data"] == null
          ? []
          : List<TargetAndAchivementDataModel>.from(json["data"]!.map((x) => TargetAndAchivementDataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class TargetAndAchivementDataModel {
  TargetAndAchivementDataModel({
    required this.customerCode,
    required this.customerName,
    required this.agentCode,
    required this.salesmanName,
    required this.nepaliMonth,
    required this.targetQty,
    required this.targetAmount,
    required this.achieveQty,
    required this.achieveAmount,
  });

  final String customerCode;
  final String customerName;
  final String agentCode;
  final String salesmanName;
  final String nepaliMonth;
  final String targetQty;
  final String targetAmount;
  final String achieveQty;
  final String achieveAmount;

  factory TargetAndAchivementDataModel.fromJson(Map<String, dynamic> json) {
    return TargetAndAchivementDataModel(
      customerCode: json["CustomerCode"] ?? "",
      customerName: json["CustomerName"] ?? "",
      agentCode: json["AgentCode"] ?? "",
      salesmanName: json["SalesmanName"] ?? "",
      nepaliMonth: json["NepaliMonth"] ?? "",
      targetQty: json["TargetQty"] ?? "",
      targetAmount: json["TargetAmount"] ?? "",
      achieveQty: json["AchieveQty"] ?? "",
      achieveAmount: json["AchieveAmount"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "CustomerCode": customerCode,
        "CustomerName": customerName,
        "AgentCode": agentCode,
        "SalesmanName": salesmanName,
        "NepaliMonth": nepaliMonth,
        "TargetQty": targetQty,
        "TargetAmount": targetAmount,
        "AchieveQty": achieveQty,
        "AchieveAmount": achieveAmount,
      };
}

/*
{
	"status_code": 200,
	"status": true,
	"data": [
		{
			"CustomerCode": "",
			"CustomerName": "",
			"AgentCode": "6",
			"SalesmanName": "Sabin New test",
			"NepaliMonth": "Shrawan",
			"TargetQty": "100.00",
			"TargetAmount": "100000.00",
			"AchieveQty": "0.00",
			"AchieveAmount": "0.00"
		},
		{
			"CustomerCode": "",
			"CustomerName": "",
			"AgentCode": "6",
			"SalesmanName": "Sabin New test",
			"NepaliMonth": "Bhadra",
			"TargetQty": "100.00",
			"TargetAmount": "100000.00",
			"AchieveQty": "0.00",
			"AchieveAmount": "0.00"
		}
	]
}*/