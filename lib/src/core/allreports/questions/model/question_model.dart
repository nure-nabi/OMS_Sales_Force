class QuestionModel {
  QuestionModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  final String message;
  final int statusCode;
  final List<QuestionDataModel> data;

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      message: json["MESSAGE"] ?? "",
      statusCode: json["STATUS_CODE"] ?? 0,
      data: json["data"] == null
          ? []
          : List<QuestionDataModel>.from(
              json["data"]!.map((x) => QuestionDataModel.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
        "MESSAGE": message,
        "STATUS_CODE": statusCode,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class QuestionDataModel {
  QuestionDataModel({
    required this.qcode,
    required this.question,
    required this.type,
    required this.isActive,
  });

  final int qcode;
  final String question;
  final String type;
  final bool isActive;

  factory QuestionDataModel.fromJson(Map<String, dynamic> json) {
    return QuestionDataModel(
      qcode: json["Qcode"] ?? 0,
      question: json["Question"] ?? "",
      type: json["Type"] ?? "",
      isActive: json["isActive"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "Qcode": qcode,
        "Question": question,
        "Type": type,
        "isActive": isActive,
      };
}

/*
{
	"MESSAGE": "Succesfully",
	"STATUS_CODE": 200,
	"data": [
		{
			"Qcode": 1,
			"Question": "Stock Available",
			"Type": "Boolean",
			"isActive": true
		},
		{
			"Qcode": 2,
			"Question": "Meeting with",
			"Type": "Text",
			"isActive": true
		},
		{
			"Qcode": 3,
			"Question": "Order Given",
			"Type": "Text",
			"isActive": true
		},
		{
			"Qcode": 4,
			"Question": "Chiled Share",
			"Type": "Boolean",
			"isActive": true
		}
	]
}*/