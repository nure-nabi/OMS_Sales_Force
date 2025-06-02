import 'dart:core';

class DeliveryReportReqModel {
  DeliveryReportReqModel({
    required this.statusCode,
    required this.status,
    required this.data,
  });



  final int statusCode;
  final bool status;
  final List<DeliveryReportCustomerDataModel> data;

  factory DeliveryReportReqModel.fromJson(Map<String, dynamic> json) {
    return DeliveryReportReqModel(
      statusCode: json["status_code"] ?? 0,
      status: json["status"] ?? false,
      data: json["data"] == null
          ? []
          : List<DeliveryReportCustomerDataModel>.from(
          json["data"]!.map((x) => DeliveryReportCustomerDataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status": status,
    "data": data.map((x) => x.toJson()).toList(),
  };
}

class DeliveryReportCustomerDataModel {
  DeliveryReportCustomerDataModel({
    required this.vNo,
    required this.vDate,
    required this.vTime,
    required this.vMiti,
    required this.glCode,
    required this.glDesc,
    required this.glShortName,
    required this.netAmount,
    required this.agentDesc,
    required this.poNo,
    required this.subledgerDesc,
  });

  final String vNo;
  final String vDate;
  final String vTime;
  final String vMiti;
  final String glCode;
  final String glDesc;
  final String glShortName;
  final String netAmount;
  final String agentDesc;
  final String poNo;
  final String subledgerDesc;

  factory DeliveryReportCustomerDataModel.fromJson(Map<String, dynamic> json) {
    return DeliveryReportCustomerDataModel(
      vNo: json["VNo"] ?? "",
      vDate: json["VDate"] ?? "",
      vTime: json["VTime"] ?? "",
      vMiti: json["VMiti"] ?? "",
      glCode: json["GlCode"] ?? "",
      glDesc: json["GlDesc"] ?? "",
      glShortName: json["GlShortName"] ?? "",
      netAmount: json["NetAmount"] == null ? "0.00" : double.parse("${json["NetAmount"]}").toStringAsFixed(2),
      agentDesc: json["AgentDesc"] ?? "",
      poNo: json["PONo"] ?? "",
      subledgerDesc: json["SubledgerDesc"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "VNo": vNo,
    "VDate": vDate,
    "VTime": vTime,
    "VMiti": vMiti,
    "GlCode": glCode,
    "GlDesc": glDesc,
    "GlShortName": glShortName,
    "NetAmount": netAmount,
    "AgentDesc": agentDesc,
    "PONo": poNo,
    "SubledgerDesc": subledgerDesc,
  };
}

/*
{
	"status_code": 200,
	"status": true,
	"data": [
		{
			"VNo": "01",
			"VDate": "",
			"VTime": "",
			"VMiti": "",
			"GlCode": "",
			"GlDesc": "Cash In Hand",
			"GlShortName": "",
			"NetAmount": 21300,
			"AgentDesc": "",
			"PONo": "",
			"SubledgerDesc": ""
		}
	]
}*/
