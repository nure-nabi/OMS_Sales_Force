class OutletVisitModel {
  OutletVisitModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  final String message;
  final int statusCode;
  final List<OutletVisitDataModel> data;

  factory OutletVisitModel.fromJson(Map<String, dynamic> json) {
    return OutletVisitModel(
      message: json["MESSAGE"] ?? "",
      statusCode: json["STATUS_CODE"] ?? 0,
      data: json["data"] == null
          ? []
          : List<OutletVisitDataModel>.from(
              json["data"]!.map((x) => OutletVisitDataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "MESSAGE": message,
        "STATUS_CODE": statusCode,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class OutletVisitDataModel {
  OutletVisitDataModel({
    required this.agentCode,
    required this.glCode,
    required this.areaCode,
    required this.agentDesc,
    required this.areaDesc,
    required this.glDesc,
    required this.qty,
    required this.amt,
    required this.visitTime,
    required this.lDate,
  });

  final String agentCode;
  final String glCode;
  final String areaCode;
  final String agentDesc;
  final String areaDesc;
  final String glDesc;
  final double qty;
  final double amt;
  final String visitTime;
  final String lDate;

  factory OutletVisitDataModel.fromJson(Map<String, dynamic> json) {
    return OutletVisitDataModel(
      agentCode: json["AgentCode"] ?? "",
      glCode: json["GLCode"] ?? "",
      areaCode: json["AreaCode"] ?? "",
      agentDesc: json["AgentDesc"] ?? "",
      areaDesc: json["AreaDesc"] ?? "",
      glDesc: json["GlDesc"] ?? "",
      qty: json["Qty"] ?? 0,
      amt: json["Amt"] ?? 0.0,
      visitTime: json["VisitTime"] == null ? "" : json["VisitTime"].toString(),
      lDate: json["LDate"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "AgentCode": agentCode,
        "GLCode": glCode,
        "AreaCode": areaCode,
        "AgentDesc": agentDesc,
        "AreaDesc": areaDesc,
        "GlDesc": glDesc,
        "Qty": qty,
        "Amt": amt,
        "VisitTime": visitTime,
        "LDate": lDate,
      };
}

/*
{
	"MESSAGE": "Succesfully",
	"STATUS_CODE": 200,
	"data": [
		{
			"AgentCode": "4",
			"GLCode": "10",
			"AreaCode": "1",
			"AgentDesc": "Bivan Shrestha",
			"AreaDesc": "Kathmandu Valley",
			"GlDesc": "Auto International",
			"Qty": 11645,
			"Amt": 605375438.64,
			"VisitTime": 34,
			"LDate": "202354"
		}
	]
}*/