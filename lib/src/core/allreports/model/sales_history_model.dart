class SalesHistoryModel {
  SalesHistoryModel({
    required this.message,
    required this.statusCode,
    required this.dataList,
  });

  final String message;
  final int statusCode;
  final List<SalesHistoryDataModel> dataList;

  factory SalesHistoryModel.fromJson(Map<String, dynamic> json) {
    return SalesHistoryModel(
      message: json["MESSAGE"] ?? "",
      statusCode: json["STATUS_CODE"] ?? 0,
      dataList: json["data"] == null
          ? []
          : List<SalesHistoryDataModel>.from(json["data"]!.map(
              (x) => SalesHistoryDataModel.fromJson(x),
            )),
    );
  }

  Map<String, dynamic> toJson() => {
        "MESSAGE": message,
        "STATUS_CODE": statusCode,
        "data": dataList.map((x) => x.toJson()).toList(),
      };
}

class SalesHistoryDataModel {
  SalesHistoryDataModel({
    required this.glcode,
    required this.glShortName,
    required this.glDesc,
    required this.pcode,
    required this.pShortName,
    required this.pDesc,
    required this.grpCode,
    required this.grpShortName,
    required this.grpDesc,
    required this.qty,
  });

  final String glcode;
  final String glShortName;
  final String glDesc;
  final String pcode;
  final String pShortName;
  final String pDesc;
  final String grpCode;
  final String grpShortName;
  final String grpDesc;
  final String qty;

  factory SalesHistoryDataModel.fromJson(Map<String, dynamic> json) {
    return SalesHistoryDataModel(
      glcode: json["Glcode"] ?? "",
      glShortName: json["GlShortName"] ?? "",
      glDesc: json["GlDesc"] ?? "",
      pcode: json["Pcode"] ?? "",
      pShortName: json["PShortName"] ?? "",
      pDesc: json["PDesc"] ?? "",
      grpCode: json["GrpCode"] ?? "",
      grpShortName: json["GrpShortName"] ?? "",
      grpDesc: json["GrpDesc"] ?? "",
      qty: json["Qty"] == null
          ? "0"
          : double.parse(json["Qty"].toString()).toStringAsFixed(0),
    );
  }

  Map<String, dynamic> toJson() => {
        "Glcode": glcode,
        "GlShortName": glShortName,
        "GlDesc": glDesc,
        "Pcode": pcode,
        "PShortName": pShortName,
        "PDesc": pDesc,
        "GrpCode": grpCode,
        "GrpShortName": grpShortName,
        "GrpDesc": grpDesc,
        "Qty": qty,
      };
}

/*
{
	"MESSAGE": "Succesfully",
	"STATUS_CODE": 200,
	"data": [
		{
			"Glcode": "10",
			"GlShortName": "10",
			"GlDesc": "Auto International ",
			"Pcode": "3",
			"PShortName": "3",
			"PDesc": "Iphone 10 s",
			"GrpCode": "1",
			"GrpShortName": "1",
			"GrpDesc": "Samartphone",
			"Qty": 55
		},
		{
			"Glcode": "10",
			"GlShortName": "10",
			"GlDesc": "Auto International ",
			"Pcode": "5",
			"PShortName": "5",
			"PDesc": "Iphone 12s",
			"GrpCode": "1",
			"GrpShortName": "1",
			"GrpDesc": "Samartphone",
			"Qty": 83
		}
	]
}*/