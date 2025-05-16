class TodoUserAssignModel {
  TodoUserAssignModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  final String message;
  final int statusCode;
  final List<TodoUserAssignDataModel> data;

  factory TodoUserAssignModel.fromJson(Map<String, dynamic> json) {
    return TodoUserAssignModel(
      message: json["MESSAGE"] ?? "",
      statusCode: json["STATUS_CODE"] ?? 0,
      data: json["data"] == null
          ? []
          : List<TodoUserAssignDataModel>.from(json["data"]!.map(
              (x) => TodoUserAssignDataModel.fromJson(x),
            )),
    );
  }

  Map<String, dynamic> toJson() => {
        "MESSAGE": message,
        "STATUS_CODE": statusCode,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class TodoUserAssignDataModel {
  TodoUserAssignDataModel({required this.userCode});

  final String userCode;

  factory TodoUserAssignDataModel.fromJson(Map<String, dynamic> json) {
    return TodoUserAssignDataModel(
      userCode: json["UserCode"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "UserCode": userCode,
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