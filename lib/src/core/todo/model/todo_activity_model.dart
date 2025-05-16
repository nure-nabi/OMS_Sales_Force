class TodoActivityModel {
  TodoActivityModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  final String message;
  final int statusCode;
  final List<TodoActivityDataModel> data;

  factory TodoActivityModel.fromJson(Map<String, dynamic> json) {
    return TodoActivityModel(
      message: json["MESSAGE"] ?? "",
      statusCode: json["STATUS_CODE"] ?? 0,
      data: json["data"] == null
          ? []
          : List<TodoActivityDataModel>.from(
              json["data"]!.map((x) => TodoActivityDataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "MESSAGE": message,
        "STATUS_CODE": statusCode,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class TodoActivityDataModel {
  TodoActivityDataModel({
    required this.frequencyType,
    required this.description,
    required this.toDoItems,
    required this.priorityLevel,
    required this.createdBy,
    required this.activityDescription,
    required this.activityCreatedon,
    required this.userId,
  });

  final String frequencyType;
  final String description;
  final String toDoItems;
  final String priorityLevel;
  final String createdBy;
  final String activityDescription;
  final String activityCreatedon;
  final String userId;

  factory TodoActivityDataModel.fromJson(Map<String, dynamic> json) {
    return TodoActivityDataModel(
      frequencyType: json["FrequencyType"] ?? "",
      description: json["Description"] ?? "",
      toDoItems: json["ToDoItems"] ?? "",
      priorityLevel: json["PriorityLevel"] ?? "",
      createdBy: json["CreatedBy"] ?? "",
      activityDescription: json["ActivityDescription"] ?? "",
      activityCreatedon: json["ActivityCreatedon"] ?? "",
      userId: json["UserId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "FrequencyType": frequencyType,
        "Description": description,
        "ToDoItems": toDoItems,
        "PriorityLevel": priorityLevel,
        "CreatedBy": createdBy,
        "ActivityDescription": activityDescription,
        "ActivityCreatedon": activityCreatedon,
        "UserId": userId,
      };
}

/*
{
	"MESSAGE": "Succesfully",
	"STATUS_CODE": 200,
	"data": [
		{
			"FrequencyType": "Occasional",
			"Description": "Meeting with AB Group for Chicken for Petrolpump Software",
			"ToDoItems": "Meeting with AB Group for Chicken for Petrolpump ",
			"PriorityLevel": "Critical",
			"CreatedBy": "OMS",
			"ActivityDescription": "Visit for meeting",
			"ActivityCreatedon": "2024",
			"UserId": "OMS"
		},
		{
			"FrequencyType": "Daily",
			"Description": "There is demo for ERP Software with Kiran Dai - electronic department, Hope every thing wend good",
			"ToDoItems": "CG For Dmeo",
			"PriorityLevel": "High",
			"CreatedBy": "OMS",
			"ActivityDescription": "There is demo for ERP Software with Kiran Dai - electronic department, Hope every thing wend good",
			"ActivityCreatedon": "2024-04-18T13:15:38.757",
			"UserId": "OMS"
		},
		{
			"FrequencyType": "Daily",
			"Description": "There is demo for ERP Software with Kiran Dai - electronic department, Hope every thing wend good",
			"ToDoItems": "CG For Dmeo",
			"PriorityLevel": "High",
			"CreatedBy": "OMS",
			"ActivityDescription": "Again Come next time says",
			"ActivityCreatedon": "2024-04-18T13:16:32.02",
			"UserId": "OMS"
		},
		{
			"FrequencyType": "Daily",
			"Description": "There is demo for ERP Software with Kiran Dai - electronic department, Hope every thing wend good",
			"ToDoItems": "CG For Dmeo",
			"PriorityLevel": "High",
			"CreatedBy": "OMS",
			"ActivityDescription": "Again Says next day come for",
			"ActivityCreatedon": "2024-04-18T13:17:08.683",
			"UserId": "OMS"
		},
		{
			"FrequencyType": "Occasional",
			"Description": "vISIT FOR SOFTWARE DEMO again",
			"ToDoItems": "for meeting",
			"PriorityLevel": "Critical",
			"CreatedBy": "OMS",
			"ActivityDescription": "Visitr today",
			"ActivityCreatedon": "2024-04-25T15:24:14.967",
			"UserId": "DEMOSUPPORT"
		},
		{
			"FrequencyType": "Occasional",
			"Description": "vISIT FOR SOFTWARE DEMO again",
			"ToDoItems": "for meeting",
			"PriorityLevel": "Critical",
			"CreatedBy": "OMS",
			"ActivityDescription": "visit at 25 gate",
			"ActivityCreatedon": "2024-04-25T15:24:46.677",
			"UserId": "DEMOSUPPORT"
		},
		{
			"FrequencyType": "Occasional",
			"Description": "vISIT FOR SOFTWARE DEMO again",
			"ToDoItems": "for meeting",
			"PriorityLevel": "Critical",
			"CreatedBy": "OMS",
			"ActivityDescription": "Demo Again",
			"ActivityCreatedon": "2024-04-25T15:49:36.6",
			"UserId": "DEMOSUPPORT"
		},
		{
			"FrequencyType": "Daily",
			"Description": "There is demo for ERP Software with Kiran Dai - electronic department, Hope every thing wend good",
			"ToDoItems": "CG For Dmeo",
			"PriorityLevel": "High",
			"CreatedBy": "OMS",
			"ActivityDescription": "FOR 25 GATE CALL FOR SUPPORT",
			"ActivityCreatedon": "2024-04-25T16:12:48.867",
			"UserId": "OMS"
		}
	]
}*/