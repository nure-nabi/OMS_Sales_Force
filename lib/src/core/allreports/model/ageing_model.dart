class AgeingModel {
  AgeingModel({
    required this.message,
    required this.statusCode,
    required this.dataList,
  });

  final String message;
  final int statusCode;
  final List<AgeingDataModel> dataList;

  factory AgeingModel.fromJson(Map<String, dynamic> json) {
    return AgeingModel(
      message: json["MESSAGE"] ?? "",
      statusCode: json["STATUS_CODE"] ?? 0,
      dataList: json["data"] == null
          ? []
          : List<AgeingDataModel>.from(
              json["data"]!.map(
                (x) => AgeingDataModel.fromJson(x),
              ),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
        "MESSAGE": message,
        "STATUS_CODE": statusCode,
        "data": dataList.map((x) => x.toJson()).toList(),
      };
}

class AgeingDataModel {
  AgeingDataModel({
    required this.glCode,
    required this.agentCode,
    required this.description,
    required this.catagory,
    required this.netAmount,
    required this.the30Days,
    required this.the60Days,
    required this.the90Days,
    required this.over90Days,
  });

  final String glCode;
  final String agentCode;
  final String description;
  final String catagory;
  final String netAmount;
  final String the30Days;
  final String the60Days;
  final String the90Days;
  final String over90Days;

  factory AgeingDataModel.fromJson(Map<String, dynamic> json) {
    return AgeingDataModel(
      glCode: json["GlCode"] ?? "",
      agentCode: json["AgentCode"] ?? "",
      description: json["Description"] ?? "",
      catagory: json["Catagory"] ?? "",
      netAmount:
          json["NetAmount"] == null ? "0.00" : json["NetAmount"].toString(),
      the30Days: json["30Days"] == null ? "0.00" : json["30Days"].toString(),
      the60Days: json["60Days"] == null ? "0.00" : json["60Days"].toString(),
      the90Days: json["90Days"] == null ? "0.00" : json["90Days"].toString(),
      over90Days:
          json["Over90Days"] == null ? "0.00" : json["Over90Days"].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "GlCode": glCode,
        "AgentCode": agentCode,
        "Description": description,
        "Catagory": catagory,
        "NetAmount": netAmount,
        "30Days": the30Days,
        "60Days": the60Days,
        "90Days": the90Days,
        "Over90Days": over90Days,
      };
}

/*
{
	"MESSAGE": "Succesfully",
	"STATUS_CODE": 200,
	"data": [
		{
			"GlCode": "10",
			"AgentCode": "",
			"Description": "Auto International ",
			"Catagory": "Customer",
			"NetAmount": 9650000,
			"30Days": 5950000,
			"60Days": 3700000,
			"90Days": 0,
			"Over90Days": 0
		}
	]
}*/