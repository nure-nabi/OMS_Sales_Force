class TodoLedgerModel {
  TodoLedgerModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  final String message;
  final int statusCode;
  final List<TodoLedgerDataModel> data;

  factory TodoLedgerModel.fromJson(Map<String, dynamic> json) {
    return TodoLedgerModel(
      message: json["message"] ?? "",
      statusCode: json["status_code"] ?? 0,
      data: json["data"] == null
          ? []
          : List<TodoLedgerDataModel>.from(json["data"]!.map(
              (x) => TodoLedgerDataModel.fromJson(x),
            )),
    );
  }

  Map<String, dynamic> toJson() => {
        "MESSAGE": message,
        "STATUS_CODE": statusCode,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class TodoLedgerDataModel {
  TodoLedgerDataModel({
    required this.glCode,
    required this.glDesc,
  });

  final String glCode;
  final String glDesc;

  factory TodoLedgerDataModel.fromJson(Map<String, dynamic> json) {
    return TodoLedgerDataModel(
      glCode: json["GlCode"] ?? "",
      glDesc: json["GlDesc"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "GlCode": glCode,
        "GlDesc": glDesc,
      };
}

/*
{
	"MESSAGE": "Succesfully",
	"STATUS_CODE": 200,
	"data": [
		{
			"UserCode": ""
		},
    {
			"UserCode": "15"
		}
	]
}*/