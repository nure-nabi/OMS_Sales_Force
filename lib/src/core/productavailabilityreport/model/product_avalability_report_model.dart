import '../../pendingverify/model/pending_verify_model.dart';

class ProductAvailabilityResponse {
  ProductAvailabilityResponse({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  final String message;
  final int statusCode;
  final List<ProductAvailabilityReportModel> data;

  factory ProductAvailabilityResponse.fromJson(Map<String, dynamic> json) {
    return ProductAvailabilityResponse(
      message: json["MESSAGE"] ?? "",
      statusCode: json["STATUS_CODE"] ?? 0,
      data: json["data"] == null
          ? []
          : List<ProductAvailabilityReportModel>.from(
              json["data"]!.map((x) => ProductAvailabilityReportModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "MESSAGE": message,
        "STATUS_CODE": statusCode,
        "data": data.map((x) => x.toJson()).toList(),
      };
}




class ProductAvailabilityReportModel {
  ProductAvailabilityReportModel({
    required this.agentCode,
    required this.agentShortName,
    required this.agentDesc,
    required this.mobile,
    required this.areaCode,
    required this.areaShortName,
    required this.areaDesc,
    required this.glCode,
    required this.glShortName,
    required this.glDesc,
    required this.pCode,
    required this.pShortname,
    required this.pDesc,
    required this.qty,
    required this.price,
    required this.pADate,
  });

  final String agentCode;
  final String agentShortName;
  final String agentDesc;
  final String mobile;
  final String areaCode;
  final String areaShortName;
  final String areaDesc;
  final String glCode;
  final String glShortName;
  final String glDesc;
  final String pCode;
  final String pShortname;
  final String pDesc;
  final String qty;
  final String price;
  final String pADate;

  factory ProductAvailabilityReportModel.fromJson(Map<String, dynamic> json) {
    return ProductAvailabilityReportModel(
      agentCode: json["AgentCode"] ?? "",
      agentShortName: json["AgentShortName"] ?? "",
      agentDesc: json["AgentDesc"] ?? "",
      mobile: json["Mobile"] ?? "",
      areaCode: json["AreaCode"] ?? "",
      areaShortName: json["AreaShortName"] ?? "",
      areaDesc: json["AreaDesc"] ?? "",
      glCode: json["GlCode"] ?? "",
      glShortName: json["GlShortName"] ?? "",
      glDesc: json["GlDesc"] ?? "",
      pCode: json["PCode"] ?? "",
      pShortname: json["Pshortname"] ?? "",
      pDesc: json["PDesc"] ?? "",
      //qty: json["Qty"] ,
      qty: json["Qty"] == null ? "0.00" : json["Qty"].toString(),
      //qty: json["Qty"] == null ? "0" : double.parse("${json["Qty"]}").toStringAsFixed(0),
      //price: json["Price"],
      price: json["Price"] == null ? "0.00" : json["Price"].toString(),
      pADate: json["PADate"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "AgentCode": agentCode,
        "AgentShortName": agentShortName,
        "AgentDesc": agentDesc,
        "Mobile": mobile,
        "AreaCode": areaCode,
        "AreaShortName": areaShortName,
        "AreaDesc": areaDesc,
        "GlCode": glCode,
        "GlShortName": glShortName,
        "GlDesc": glDesc,
        "PCode": pCode,
        "Pshortname": pShortname,
        "PDesc": pDesc,
        "Qty": qty,
        "Price": price,
        "PADate": pADate,
      };
}

