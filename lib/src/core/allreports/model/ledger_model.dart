class LedgerReportModel {
  LedgerReportModel({
    required this.statusCode,
    required this.status,
    required this.data,
  });

  final int statusCode;
  final bool status;
  final List<LedgerReportDataModel> data;

  factory LedgerReportModel.fromJson(Map<String, dynamic> json) {
    return LedgerReportModel(
      statusCode: json["status_code"] ?? 0,
      status: json["status"] ?? false,
      data: json["data"] == null
          ? []
          : List<LedgerReportDataModel>.from(
              json["data"]!.map((x) => LedgerReportDataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class LedgerReportDataModel {
  LedgerReportDataModel({
    required this.vno,
    required this.date,
    required this.miti,
    required this.source,
    required this.dr,
    required this.cr,
    required this.narration,
    required this.remarks,
    required this.total,
  });

  final String vno;
  final String date;
  final String miti;
  final String source;
  final String dr;
  final String cr;
  final String narration;
  final String remarks;

  ///
  final String total;

  factory LedgerReportDataModel.fromJson(Map<String, dynamic> json) {
    return LedgerReportDataModel(
      vno: json["Vno"] ?? "",
      date: json["Date"] ?? "",
      miti: json["Miti"] ?? "",
      source: json["Source"] ?? "",
      //dr: json["Dr"] == null ? "0" : json["Dr"].toString(),
      //cr: json["Cr"] == null ? "0" : json["Cr"].toString(),
      cr: json["Cr"] == null ? "0.00" : double.parse("${json["Cr"]}").toStringAsFixed(2),
      dr: json["Dr"] == null ? "0.00" : double.parse("${json["Dr"]}").toStringAsFixed(2),
      narration: json["Narration"] ?? "",
      remarks: json["Remarks"] ?? "",
      total: json["Total"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "Vno": vno,
        "Date": date,
        "Miti": miti,
        "Source": source,
        "Dr": dr,
        "Cr": cr,
        "Narration": narration,
        "Remarks": remarks,
        "Total": total,
      };

  /// For PDF
  String getIndex(int index, bool showEnglishDate) {
    switch (index) {
      case 0:
        return showEnglishDate == true ? date : miti;
      case 1:
        return vno;
      case 2:
        return dr;
      case 3:
        return cr;
      case 4:
        return total;
    }
    return '';
  }
}

/*
{
	"status_code": 200,
	"status": true,
	"data": [
		{
			"Vno": "43",
			"Date": "20",
			"Miti": "79",
			"Source": "Sales",
			"Dr": 200000,
			"Cr": 0,
			"Narration": "",
			"Remarks": ""
		}
	]
}*/