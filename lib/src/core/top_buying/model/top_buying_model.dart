class TopBuyingModel {
  TopBuyingModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  final String message;
  final int statusCode;
  final List<TopBuyingDataModel> data;

  factory TopBuyingModel.fromJson(Map<String, dynamic> json) {
    return TopBuyingModel(
      message: json["MESSAGE"] ?? "",
      statusCode: json["STATUS_CODE"] ?? 0,
      data: json["data"] == null
          ? []
          : List<TopBuyingDataModel>.from(
              json["data"]!.map((x) => TopBuyingDataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "MESSAGE": message,
        "STATUS_CODE": statusCode,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class TopBuyingDataModel {
  TopBuyingDataModel({
    required this.pShortName,
    required this.pDesc,
    required this.grpShortName,
    required this.grpDesc,
    required this.qty,
    required this.netAmt,
  });

  final String pShortName;
  final String pDesc;
  final String grpShortName;
  final String grpDesc;
  final double qty;
  final double netAmt;

  factory TopBuyingDataModel.fromJson(Map<String, dynamic> json) {
    return TopBuyingDataModel(
      pShortName: json["PShortName"] ?? "-",
      pDesc: json["PDesc"] ?? "-",
      grpShortName: json["GrpShortName"] ?? "-",
      grpDesc: json["GrpDesc"] ?? "-",
      qty: json["Qty"] ?? 0,
      netAmt: json["NetAmt"] ?? 0.00,
    );
  }

  Map<String, dynamic> toJson() => {
        "PShortName": pShortName,
        "PDesc": pDesc,
        "GrpShortName": grpShortName,
        "GrpDesc": grpDesc,
        "Qty": qty,
        "NetAmt": netAmt,
      };
}

/*
{
	"MESSAGE": "Succesfully",
	"STATUS_CODE": 200,
	"data": [
		{
			"PShortName": "Ai00001",
			"PDesc": "Air Ticket",
			"GrpShortName": "",
			"GrpDesc": ""
		},
		{
			"PShortName": "Shikanji250ml",
			"PDesc": "Iphone 10 s",
			"GrpShortName": "3",
			"GrpDesc": "Laptop"
		},
		{
			"PShortName": "4",
			"PDesc": "Radmi 10s",
			"GrpShortName": "CE00001",
			"GrpDesc": "CEMENT"
		}
	]
}*/