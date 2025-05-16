class QuestionReportModel {
  QuestionReportModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  final String message;
  final int statusCode;
  final List<QuestionReportDataModel> data;

  factory QuestionReportModel.fromJson(Map<String, dynamic> json) {
    return QuestionReportModel(
      message: json["MESSAGE"] ?? "",
      statusCode: json["STATUS_CODE"] ?? 0,
      data: json["data"] == null
          ? []
          : List<QuestionReportDataModel>.from(
              json["data"]!.map((x) => QuestionReportDataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "MESSAGE": message,
        "STATUS_CODE": statusCode,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class QuestionReportDataModel {
  QuestionReportDataModel({
    required this.qcode,
    required this.question,
    required this.answer,
    required this.gldesc,
    required this.agentDesc,
    required this.createdDate,
    required this.createdby,
    required this.glCode,
    required this.agentCode,
  });

  final String qcode;
  final String question;
  final String answer;
  final String gldesc;
  final String agentDesc;
  final String createdDate;
  final String createdby;
  final String glCode;
  final String agentCode;

  factory QuestionReportDataModel.fromJson(Map<String, dynamic> json) {
    return QuestionReportDataModel(
      qcode: json["Qcode"] ?? "",
      question: json["Question"] ?? "",
      answer: json["answer"] ?? "",
      gldesc: json["Gldesc"] ?? "",
      agentDesc: json["AgentDesc"] ?? "",
      createdDate: json["CreatedDate"] ?? "",
      createdby: json["Createdby"] ?? "",
      glCode: json["GlCode"] ?? "",
      agentCode: json["AgentCode"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "Qcode": qcode,
        "Question": question,
        "answer": answer,
        "Gldesc": gldesc,
        "AgentDesc": agentDesc,
        "CreatedDate": createdDate,
        "Createdby": createdby,
        "GlCode": glCode,
        "AgentCode": agentCode,
      };
}

/*
{
	"MESSAGE": "Succesfully",
	"STATUS_CODE": 200,
	"data": [
		{
			"Qcode": "1",
			"Question": "Stock Available",
			"answer": "NO",
			"Gldesc": "abcdddddd",
			"AgentDesc": "Bivan Shrestha",
			"CreatedDate": "2087",
			"Createdby": "11",
			"GlCode": "91",
			"AgentCode": "4"
		}
	]
}*/