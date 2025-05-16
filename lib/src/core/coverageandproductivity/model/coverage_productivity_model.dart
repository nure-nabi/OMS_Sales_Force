class CoverageProductivityModel {
  CoverageProductivityModel({
    required this.statusCode,
    required this.status,
    required this.data,
  });

  final int statusCode;
  final bool status;
  final List<CoverageProductivityDataModel> data;

  factory CoverageProductivityModel.fromJson(Map<String, dynamic> json) {
    return CoverageProductivityModel(
      statusCode: json["status_code"] ?? 0,
      status: json["status"] ?? false,
      data: json["data"] == null
          ? []
          : List<CoverageProductivityDataModel>.from(json["data"]!
              .map((x) => CoverageProductivityDataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class CoverageProductivityDataModel {
  CoverageProductivityDataModel({
    required this.productivity,
    required this.target,
    required this.coverage,
    required this.remaining,
    required this.productivityPercentage,
    required this.coveragePercentage,
  });

  final String productivity;
  final String target;
  final String coverage;
  final String remaining;
  final String productivityPercentage;
  final String coveragePercentage;

  factory CoverageProductivityDataModel.fromJson(Map<String, dynamic> json) {
    return CoverageProductivityDataModel(
      productivity: json["Productivity"] ?? "",
      target: json["Target"] ?? "",
      coverage: json["Coverage"] ?? "",
      remaining: json["Remaining"] ?? "",
      productivityPercentage: json["ProductivityPercentage"] ?? "",
      coveragePercentage: json["CoveragePercentage"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "Productivity": productivity,
        "Target": target,
        "Coverage": coverage,
        "Remaining": remaining,
        "ProductivityPercentage": productivityPercentage,
        "CoveragePercentage": coveragePercentage,
      };
}

/*
{
	"status_code": 200,
	"status": true,
	"data": [
		{
			"Productivity": "0",
			"Target": "0",
			"Coverage": "0",
			"Remaining": "0",
			"ProductivityPercentage": "0",
			"CoveragePercentage": "0"
		}
	]
}*/