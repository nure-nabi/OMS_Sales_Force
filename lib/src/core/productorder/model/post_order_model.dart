import 'dart:convert';

import 'package:oms_salesforce/src/utils/time_converter.dart';

class OrderPostModel {
  OrderPostModel({
    required this.routeCode,
    required this.outletCode,
    required this.orderBy,
    required this.comment,
    required this.lat,
    required this.lng,
    required this.timestamp,
    required this.itemDetails,
  });

  final String routeCode;
  final String outletCode;
  final String orderBy;
  final String comment;
  final String lat;
  final String lng;
  final String timestamp;
  final List<OrderPostItemDetailModel> itemDetails;

  factory OrderPostModel.fromJson({
    required Map<String, dynamic> json,
    required String lat,
    required String long,
  }) {
    return OrderPostModel(
      routeCode: json["RouteCode"] ?? "",
      outletCode: json["OutletCode"] ?? "",
      orderBy: json["OrderBy"] ?? "",
      comment: json["Comment"] ?? "",
      lat: json["Lat"] ?? lat,
      lng: json["Lng"] ?? long,
      timestamp: json["Timestamp"] ?? MyTimeConverter.getTimeStamp(),
      itemDetails: json["ItemDetails"] == null
          ? []
          : List<OrderPostItemDetailModel>.from(jsonDecode(json["ItemDetails"]!)
              .map((x) => OrderPostItemDetailModel.fromJson(x))),
    );
  }
  //Order/SaveOrder
  Map<String, dynamic> toJson() => {
        "RouteCode": routeCode,
        "OutletCode": outletCode,
        "OrderBy": orderBy,
        "Comment": comment,
        "Lat": lat,
        "Lng": lng,
        "Timestamp": timestamp,
        "ItemDetails": itemDetails.map((x) => x.toJson()).toList(),
      };
}

class OrderPostItemDetailModel {
  OrderPostItemDetailModel({
    required this.exciseAmount,
    required this.discountAmount,
    required this.totalAmt,
    required this.qty,
    required this.discountRate,
    required this.vatAmount,
    required this.vatRate,
    required this.exciseRate,
    required this.rate,
    required this.itemCode,
  });

  final String exciseAmount;
  final String discountAmount;
  final String totalAmt;
  final String qty;
  final String discountRate;
  final String vatAmount;
  final String vatRate;
  final String exciseRate;
  final String rate;
  final String itemCode;

  factory OrderPostItemDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderPostItemDetailModel(
      exciseAmount: json["ExciseAmount"] ?? "0",
      discountAmount: json["DiscountAmount"] ?? "0",
      totalAmt: json["TotalAmt"] ?? "0",
      qty: json["Qty"] ?? "0",
      discountRate: json["DiscountRate"] ?? "0",
      vatAmount: json["VatAmount"] ?? "0",
      vatRate: json["VatRate"] ?? "0",
      exciseRate: json["ExciseRate"] ?? "0",
      rate: json["Rate"] ?? "0",
      itemCode: json["ItemCode"] ?? "0",
    );
  }

  Map<String, dynamic> toJson() => {
        "ExciseAmount": exciseAmount,
        "DiscountAmount": discountAmount,
        "TotalAmt": totalAmt,
        "Qty": qty,
        "DiscountRate": discountRate,
        "VatAmount": vatAmount,
        "VatRate": vatRate,
        "ExciseRate": exciseRate,
        "Rate": rate,
        "ItemCode": itemCode,
      };
}

/*
[
	{
		"RouteCode": "1",
		"OutletCode": "10",
		"OrderBy": "By Visit",
		"Comment": "TEST FOR API",
		"Lat": "27.697337",
		"Lng": "85.305397",
		"Timestamp": "1682597303",
		"ItemDetails": [
			{
				"ExciseAmount": "0",
				"DiscountAmount": "0",
				"TotalAmt": "100",
				"Qty": "1",
				"DiscountRate": "0",
				"VatAmount": "0",
				"VatRate": "0",
				"ExciseRate": "0",
				"Rate": "100",
				"ItemCode": "3"
			}
		]
	}
]*/