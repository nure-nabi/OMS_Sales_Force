class PendingVerifyModel {
  PendingVerifyModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  final String message;
  final int statusCode;
  final List<PendingVerifyDataModel> data;

  factory PendingVerifyModel.fromJson(Map<String, dynamic> json) {
    return PendingVerifyModel(
      message: json["message"] ?? "",
      statusCode: json["status_code"] ?? 0,
      data: json["data"] == null
          ? []
          : List<PendingVerifyDataModel>.from(
              json["data"]!.map((x) => PendingVerifyDataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class PendingVerifyDataModel {
  PendingVerifyDataModel({
    required this.itemName,
    required this.qty,
    required this.rate,
    required this.netAmt,
    required this.brandCode,
    required this.glCode,
    required this.glDesc,
  });

  final String itemName;
  final String qty;
  final String rate;
  final String netAmt;
  final String brandCode;
  final String glCode;
  final String glDesc;

  factory PendingVerifyDataModel.fromJson(Map<String, dynamic> json) {
    return PendingVerifyDataModel(
      itemName: json["ItemName"] ?? "",
      qty: json["Qty"] == null
          ? "0"
          : double.parse("${json["Qty"]}").toStringAsFixed(0),
      rate: json["Rate"] == null
          ? "0.00"
          : double.parse("${json["Rate"]}").toStringAsFixed(2),
      netAmt: json["NetAmt"] == null
          ? "0.00"
          : double.parse("${json["NetAmt"]}").toStringAsFixed(2),
      brandCode: json["BrandCode"] ?? "",
      glCode: json["GlCode"] ?? "",
      glDesc: json["GlDesc"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "ItemName": itemName,
        "Qty": qty,
        "Rate": rate,
        "NetAmt": netAmt,
        "BrandCode": brandCode,
        "GlCode": glCode,
        "GlDesc": glDesc,
      };
}

/*
{
	"message": "Succesfully",
	"status_code": 200,
	"data": [
		{
			"ItemName": "Iphone 10 s",
			"Qty": "15.00000000",
			"Rate": "300000.00000000",
			"NetAmt": "1694999.990000",
			"BrandCode": "3",
			"GlCode": "10",
			"GlDesc": "Auto International "
		},
		{
			"ItemName": "Iphone 12s",
			"Qty": "26.00000000",
			"Rate": "150000.00000000",
			"NetAmt": "1468999.990000",
			"BrandCode": "3",
			"GlCode": "10",
			"GlDesc": "Auto International "
		},
		{
			"ItemName": "Dell x202 inspiran",
			"Qty": "5.00000000",
			"Rate": "20000.00000000",
			"NetAmt": "100000.000000",
			"BrandCode": "1",
			"GlCode": "14",
			"GlDesc": "GTL Nepal"
		},
		{
			"ItemName": "Iphone 10 s",
			"Qty": "20.00000000",
			"Rate": "100000.00000000",
			"NetAmt": "2000000.000000",
			"BrandCode": "1",
			"GlCode": "14",
			"GlDesc": "GTL Nepal"
		},
		{
			"ItemName": "Iphone 12s",
			"Qty": "30.00000000",
			"Rate": "50000.00000000",
			"NetAmt": "1500000.000000",
			"BrandCode": "1",
			"GlCode": "14",
			"GlDesc": "GTL Nepal"
		}
	]
}*/