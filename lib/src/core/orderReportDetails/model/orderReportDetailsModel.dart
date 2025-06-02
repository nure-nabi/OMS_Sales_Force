class OrderReportDetailModel {
  OrderReportDetailModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  final String message;
  final int statusCode;
  final List<OrderReportDetailDataModel> data;

  factory OrderReportDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderReportDetailModel(
      message: json["MESSAGE"] ?? "",
      statusCode: json["STATUS_CODE"] ?? 0,
      data: json["data"] == null
          ? []
          : List<OrderReportDetailDataModel>.from(
              json["data"]!.map((x) => OrderReportDetailDataModel.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
        "MESSAGE": message,
        "STATUS_CODE": statusCode,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class OrderReportDetailDataModel {
  OrderReportDetailDataModel({
    required this.hVno,
    required this.hDate,
    required this.hMiti,
    required this.hGlDesc,
    required this.hGlCode,
    required this.hPanNo,
    required this.hMobileNo,
    required this.hAgent,
    required this.dSno,
    required this.dPDesc,
    required this.dQty,
    required this.dAltQty,
    required this.unitCode,
    required this.altUnitCode,
    required this.address,
    required this.dLocalRate,
    required this.dBasicAmt,
    required this.dTermAMt,
    required this.dNetAmt,
    required this.hTermAMt,
    required this.hNetAmt,
    required this.voucherNumber,
    required this.dISCOUNT,
    required this.deductedVAT,
    required this.balanceAmt,
  });

  final String hVno;
  final String hDate;
  final String hMiti;
  final String hGlDesc;
  final String hGlCode;
  final String hPanNo;
  final String hMobileNo;
  final String hAgent;
  final String dSno;
  final String dPDesc;
  final String dQty;
  final String dAltQty;
  final String unitCode;
  final String altUnitCode;
  final String address;
  final String dLocalRate;
  final String dBasicAmt;
  final String dTermAMt;
  final String dNetAmt;
  final String hTermAMt;
  final String hNetAmt;
  final String voucherNumber;
  final String dISCOUNT;
  final String deductedVAT;
  final String balanceAmt;

  factory OrderReportDetailDataModel.fromJson(Map<String, dynamic> json) {
    return OrderReportDetailDataModel(
      hVno: json["HVno"] ?? "",
      hDate: json["HDate"] ?? "",
      hMiti: json["HMiti"] ?? "",
      hGlDesc: json["HGlDesc"] ?? "",
      hGlCode: json["HGlCode"] ?? "",
      hPanNo: json["HPanNo"] ?? "",
      hMobileNo: json["HMobileNo"] ?? "",
      hAgent: json["HAgent"] ?? "",
      dSno: json["DSno"] == null ? "0.0" : "${json["DSno"]}",
      dPDesc: json["DPDesc"] == null ? "0.0" : "${json["DPDesc"]}",
      dQty: json["DQty"] == null ? "0.0" : "${json["DQty"]}",
      dAltQty: json["DAltQty"] == null ? "0.0" : "${json["DAltQty"]}",
      unitCode: json["UnitCode"] == null ? "0.0" : "${json["UnitCode"]}",
      altUnitCode: json["AltUnitCode"] ?? "",
      address: json["Address"] ?? "",
      dLocalRate: json["DLocalRate"] == null ? "0.0" : "${json["DLocalRate"]}",
      dBasicAmt: json["DBasicAmt"] == null ? "0.0" : "${json["DBasicAmt"]}",
      dTermAMt: json["DTermAMt"] == null ? "0.0" : "${json["DTermAMt"]}",
      dNetAmt: json["DNetAmt"] == null ? "0.0" : "${json["DNetAmt"]}",
      hTermAMt: json["HTermAMt"] == null ? "0.0" : "${json["HTermAMt"]}",
      hNetAmt: json["HNetAmt"] == null ? "0.0" : "${json["HNetAmt"]}",
      voucherNumber:
          json["Voucher Number"] == null ? "0.0" : "${json["Voucher Number"]}",
      dISCOUNT: json["DISCOUNT"] == null ? "0.0" : "${json["DISCOUNT"]}",
      deductedVAT:
          json["Deducted VAT"] == null ? "0.0" : "${json["Deducted VAT"]}",
      balanceAmt: json["BalanceAmt"] == null ? "0.0" : "${json["BalanceAmt"]}",
    );
  }

  Map<String, dynamic> toJson() => {
        "HVno": hVno,
        "HDate": hDate,
        "HMiti": hMiti,
        "HGlDesc": hGlDesc,
        "HGlCode": hGlCode,
        "HPanNo": hPanNo,
        "HMobileNo": hMobileNo,
        "HAgent": hAgent,
        "DSno": dSno,
        "DPDesc": dPDesc,
        "DQty": dQty,
        "DAltQty": dAltQty,
        "UnitCode": unitCode,
        "AltUnitCode": altUnitCode,
        "Address": address,
        "DLocalRate": dLocalRate,
        "DBasicAmt": dBasicAmt,
        "DTermAMt": dTermAMt,
        "DNetAmt": dNetAmt,
        "HTermAMt": hTermAMt,
        "HNetAmt": hNetAmt,
        "[Voucher Number]": voucherNumber,
        "DISCOUNT": dISCOUNT,
        "[Deducted VAT]": deductedVAT,
        "BalanceAmt": balanceAmt,
      };

  //for pdf
  String getIndex(int index, bool showEnglishDate) {
    switch (index) {
      case 0:
        return dPDesc;
      case 1:
        return unitCode;
      case 2:
        return dAltQty;
      case 3:
        return dQty;
      case 4:
        return dLocalRate;
      case 5:
        return dNetAmt;
    }
    return '';
  }
}
