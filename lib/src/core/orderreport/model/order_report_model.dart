import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class OrderReportModel {
  OrderReportModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  final String message;
  final int statusCode;
  final List<OrderReportDataModel> data;

  factory OrderReportModel.fromJson(Map<String, dynamic> json) {
    return OrderReportModel(
      message: json["MESSAGE"] ?? "",
      statusCode: json["STATUS_CODE"] ?? 0,
      data: json["data"] == null
          ? []
          : List<OrderReportDataModel>.from(
              json["data"]!.map((x) => OrderReportDataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "MESSAGE": message,
        "STATUS_CODE": statusCode,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class OrderReportDataModel {
  OrderReportDataModel({
    required this.glcode,
    required this.vNo,
    required this.salesman,
    required this.glDesc,
    required this.route,
    required this.telNoI,
    required this.mobile,
    required this.creditLimite,
    required this.creditDay,
    required this.overdays,
    required this.overLimit,
    required this.currentBalance,
    required this.ageOfOrder,
    required this.qty,
    required this.vDate,
    required this.vTime,
    required this.netAmt,
    required this.remarks,
    required this.orderBy,
    required this.lat,
    required this.lng,
    required this.managerRemarks,
    required this.reconcileDate,
    required this.reconcileBy,
    required this.entryModule,
    required this.invType,
    required this.invDate,
  });

  final String glcode;
  final String vNo;
  final String salesman;
  final String glDesc;
  final String route;
  final String telNoI;
  final String mobile;
  final String creditLimite;
  final String creditDay;
  final String overdays;
  final String overLimit;
  final String currentBalance;
  final String ageOfOrder;
  final String qty;
  final String vDate;
  final String vTime;
  final String netAmt;
  final String remarks;
  final String orderBy;
  final String lat;
  final String lng;
  final String managerRemarks;
  final String reconcileDate;
  final String reconcileBy;
  final String entryModule;
  final String invType;
  final String invDate;

  factory OrderReportDataModel.fromJson(Map<String, dynamic> json) {
    double parsedNetAmt;
    try {
      parsedNetAmt = double.parse(json["CreditLimite"] ?? 0.0);
    } catch (e) {
      parsedNetAmt = 0.0;
      debugPrint("Error parsing net amount: $e");
    }

    String vdate = json["VDate"] ?? "";
    String dateTimeString = vdate.split("T").first;
    String dateString = dateTimeString.substring(0, 10);
   // DateTime originalDate = DateFormat('yyyy-MM-dd').parse(dateTimeString);
    // Convert to desired format
    //String formattedDateStr = DateFormat('dd-MM-yyyy').format(originalDate);

    return OrderReportDataModel(
      glcode: json["Glcode"] ?? "",
      vNo: json["VNo"] ?? "",
      salesman: json["Salesman"] ?? "",
      glDesc: json["GlDesc"] ?? "",
      route: json["Route"] ?? "",
      telNoI: json["TelNoI"] ?? "",
      mobile: json["Mobile"] ?? "",
      creditLimite: json["CreditLimite"] == null ? "0.00" : double.parse("${json["CreditLimite"]}").toStringAsFixed(2),
      creditDay: json["CreditDay"] == null ? "0" : double.parse("${json["CreditDay"]}").toString(),
      overdays: json["Overdays"] == null ? "0" : double.parse("${json["Overdays"]}").toString(),
      overLimit: json["OverLimit"] == null ? "0.0" : double.parse("${json["OverLimit"]}").toStringAsFixed(2),
      currentBalance: json["CurrentBalance"] == null ? "0.00" : double.parse("${json["CurrentBalance"]}").toStringAsFixed(2),
      ageOfOrder: json["AgeOfOrder"] == null ? "0" : double.parse("${json["AgeOfOrder"]}").toString(),
      qty: json["Qty"] == null ? "0.0" : double.parse("${json["Qty"]}").toStringAsFixed(2),
      //vDate: json["VDate"] ?? "",
      vDate: dateTimeString,
      vTime: json["VTime"] ?? "",
      netAmt: json["NetAmt"] == null ? "0.00" : double.parse("${json["NetAmt"]}").toStringAsFixed(2),
      remarks: json["Remarks"] ?? "",
      orderBy: json["OrderBy"] ?? "",
      lat: json["Lat"] ?? "",
      lng: json["Lng"] ?? "",
      managerRemarks: json["ManagerRemarks"] ?? "",
      reconcileDate: json["ReconcileDate"] ?? "",
      reconcileBy: json["ReconcileBy"] ?? "",
      entryModule: json["EntryModule"] ?? "",
      invType: json["InvType"] ?? "",
      invDate: json["InvDate"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "Glcode": glcode,
        "VNo": vNo,
        "Salesman": salesman,
        "GlDesc": glDesc,
        "Route": route,
        "TelNoI": telNoI,
        "Mobile": mobile,
        "CreditLimite": creditLimite,
        "CreditDay": creditDay,
       "Overdays": overdays,
       "OverLimit": overLimit,
        "CurrentBalance": currentBalance,
        "AgeOfOrder": ageOfOrder,
        "Qty": qty,
        "VDate": vDate,
        "VTime": vTime,
        "NetAmt": netAmt,
        "Remarks": remarks,
        "OrderBy": orderBy,
        "Lat": lat,
        "Lng": lng,
        "ManagerRemarks": managerRemarks,
        "ReconcileDate": reconcileDate,
        "ReconcileBy": reconcileBy,
        "EntryModule": entryModule,
        "InvType": invType,
       "InvDate": invDate,
      };
}

/*
{
	"MESSAGE": "Succesfully",
	"STATUS_CODE": 200,
	"data": [
		{
			"Glcode": "7",
			"VNo": "2",
			"Salesman": "temp",
			"GlDesc": "Global Tech Solution Pvt. Ltd",
			"Route": "Kathmandu Valley",
			"TelNoI": "",
			"Mobile": "9802069643",
			"CreditLimite": 0,
			"CreditDay": 0,
			"Overdays": 452,
			"OverLimit": -1129999.99,
			"CurrentBalance": 8324213.65,
			"AgeOfOrder": 452,
			"Qty": 10,
			"VDate": "2022-11-17T00:00:00",
			"VTime": "2022-11-17T18:07:48",
			"NetAmt": 1129999.99,
			"Remarks": "",
			"OrderBy": "By Visit",
			"Lat": "27.6974016",
			"Lng": "85.3048481",
			"ManagerRemarks": "",
			"ReconcileDate": "",
			"ReconcileBy": "",
			"EntryModule": "Order Tracking",
			"InvType": "General",
			"InvDate": ""
		}
	]
}*/