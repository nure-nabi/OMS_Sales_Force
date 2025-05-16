class TodoModel {
  TodoModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  final String message;
  final int statusCode;
  final List<TodoDataModel> data;

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      message: json["MESSAGE"] ?? "",
      statusCode: json["STATUS_CODE"] ?? 0,
      data: json["data"] == null
          ? []
          : List<TodoDataModel>.from(
              json["data"]!.map((x) => TodoDataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "MESSAGE": message,
        "STATUS_CODE": statusCode,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class TodoDataModel {
  TodoDataModel({
    required this.id,
    required this.frequencyType,
    required this.description,
    required this.toDoItems,
    required this.priorityLevel,
    required this.createdBy,
    required this.assignedBy,
    required this.assignedTo,
    required this.fromDate,
    required this.toDate,
    required this.taskStatus,
    required this.createdon,
    required this.fromMiti,
    required this.toMiti,
    required this.closedStatus,
    required this.closedBy,
    required this.closedDate,
    required this.gldesc,
    required this.glCode,
    required this.agentDesc,
    required this.agentCode,
  });

  final int id;
  final String frequencyType;
  final String description;
  final String toDoItems;
  final String priorityLevel;
  final String createdBy;
  final String assignedBy;
  final String assignedTo;
  final String fromDate;
  final String toDate;
  final String taskStatus;
  final String createdon;
  final String fromMiti;
  final String toMiti;
  final String closedStatus;
  final String closedBy;
  final String closedDate;
  final String gldesc;
  final String glCode;
  final String agentDesc;
  final String agentCode;

  factory TodoDataModel.fromJson(Map<String, dynamic> json) {
    return TodoDataModel(
      id: json["Id"] ?? 0,
      frequencyType: json["FrequencyType"] ?? "",
      description: json["Description"] ?? "",
      toDoItems: json["ToDoItems"] ?? "",
      priorityLevel: json["PriorityLevel"] ?? "",
      createdBy: json["CreatedBy"] ?? "",
      assignedBy: json["AssignedBy"] ?? "",
      assignedTo: json["AssignedTo"] ?? "",
      fromDate: json["FromDate"] ?? "",
      toDate: json["ToDate"] ?? "",
      taskStatus: json["TaskStatus"] ?? "",
      createdon: json["Createdon"] ?? "",
      fromMiti: json["FromMiti"] ?? "",
      toMiti: json["ToMiti"] ?? "",
      closedStatus: json["ClosedStatus"] ?? "",
      closedBy: json["ClosedBy"] ?? "",
      closedDate: json["ClosedDate"] ?? "",
      gldesc: json["Gldesc"] ?? "",
      glCode: json["GlCode"] ?? "",
      agentDesc: json["AgentDesc"] ?? "",
      agentCode: json["AgentCode"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "Id": id,
        "FrequencyType": frequencyType,
        "Description": description,
        "ToDoItems": toDoItems,
        "PriorityLevel": priorityLevel,
        "CreatedBy": createdBy,
        "AssignedBy": assignedBy,
        "AssignedTo": assignedTo,
        "FromDate": fromDate,
        "ToDate": toDate,
        "TaskStatus": taskStatus,
        "Createdon": createdon,
        "FromMiti": fromMiti,
        "ToMiti": toMiti,
        "ClosedStatus": closedStatus,
        "ClosedBy": closedBy,
        "ClosedDate": closedDate,
        "Gldesc": gldesc,
        "GlCode": glCode,
        "AgentDesc": agentDesc,
        "AgentCode": agentCode,
      };
}

/*
{
	"MESSAGE": "Succesfully",
	"STATUS_CODE": 200,
	"data": [
		{
			"Id": 1,
			"FrequencyType": "Occasional",
			"Description": "sasasas",
			"ToDoItems": "sunam 123",
			"PriorityLevel": "Critical",
			"CreatedBy": "demo",
			"AssignedBy": "",
			"AssignedTo": "Global.Sunam",
			"FromDate": "2023-06-01T00:00:00",
			"ToDate": "2023-06-30T00:00:00",
			"TaskStatus": "Pending",
			"Createdon": "2023-06-30T15:15:50.85",
			"FromMiti": "",
			"ToMiti": "",
			"ClosedStatus": "",
			"ClosedBy": "",
			"ClosedDate": "",
			"Gldesc": "",
			"GlCode": "",
			"AgentDesc": "",
			"AgentCode": ""
		},
		{
			"Id": 2,
			"FrequencyType": "Occasional",
			"Description": "Meeting with AB Group for Chicken for Petrolpump Software",
			"ToDoItems": "Meeting with AB Group for Chicken for Petrolpump ",
			"PriorityLevel": "Critical",
			"CreatedBy": "OMS",
			"AssignedBy": "",
			"AssignedTo": "OMS",
			"FromDate": "2024-04-18T00:00:00",
			"ToDate": "2024-04-19T00:00:00",
			"TaskStatus": "InProgress",
			"Createdon": "2024-04-18T13:13:02.787",
			"FromMiti": "",
			"ToMiti": "",
			"ClosedStatus": "",
			"ClosedBy": "",
			"ClosedDate": "",
			"Gldesc": "",
			"GlCode": "",
			"AgentDesc": "",
			"AgentCode": ""
		},
		{
			"Id": 3,
			"FrequencyType": "Daily",
			"Description": "There is demo for ERP Software with Kiran Dai - electronic department, Hope every thing wend good",
			"ToDoItems": "CG For Dmeo",
			"PriorityLevel": "High",
			"CreatedBy": "OMS",
			"AssignedBy": "",
			"AssignedTo": "OMS",
			"FromDate": "2024-04-19T00:00:00",
			"ToDate": "2024-04-20T00:00:00",
			"TaskStatus": "InProgress",
			"Createdon": "2024-04-18T13:14:51.803",
			"FromMiti": "",
			"ToMiti": "",
			"ClosedStatus": "",
			"ClosedBy": "",
			"ClosedDate": "",
			"Gldesc": "",
			"GlCode": "",
			"AgentDesc": "",
			"AgentCode": ""
		},
		{
			"Id": 4,
			"FrequencyType": "1",
			"Description": "2",
			"ToDoItems": "3",
			"PriorityLevel": "4",
			"CreatedBy": "5",
			"AssignedBy": "6",
			"AssignedTo": "7",
			"FromDate": "2024-04-05T00:00:00",
			"ToDate": "2024-04-25T00:00:00",
			"TaskStatus": "8",
			"Createdon": "2024-04-24T17:21:23.62",
			"FromMiti": "23/12/2080",
			"ToMiti": "13/01/2081",
			"ClosedStatus": "",
			"ClosedBy": "",
			"ClosedDate": "1900-01-01T00:00:00",
			"Gldesc": "",
			"GlCode": "",
			"AgentDesc": "",
			"AgentCode": ""
		},
		{
			"Id": 5,
			"FrequencyType": "1",
			"Description": "2",
			"ToDoItems": "3",
			"PriorityLevel": "4",
			"CreatedBy": "5",
			"AssignedBy": "6",
			"AssignedTo": "7",
			"FromDate": "2024-04-05T00:00:00",
			"ToDate": "2024-04-25T00:00:00",
			"TaskStatus": "8",
			"Createdon": "2024-04-24T17:31:19.433",
			"FromMiti": "23/12/2080",
			"ToMiti": "13/01/2081",
			"ClosedStatus": "",
			"ClosedBy": "",
			"ClosedDate": "1900-01-01T00:00:00",
			"Gldesc": "",
			"GlCode": "",
			"AgentDesc": "",
			"AgentCode": ""
		},
		{
			"Id": 6,
			"FrequencyType": "Occasional",
			"Description": "vISIT FOR SOFTWARE DEMO again",
			"ToDoItems": "for meeting",
			"PriorityLevel": "Critical",
			"CreatedBy": "OMS",
			"AssignedBy": "",
			"AssignedTo": "DEMOSUPPORT",
			"FromDate": "2024-04-24T00:00:00",
			"ToDate": "2024-04-25T00:00:00",
			"TaskStatus": "Completed",
			"Createdon": "2024-04-24T20:51:45.46",
			"FromMiti": "",
			"ToMiti": "",
			"ClosedStatus": "",
			"ClosedBy": "",
			"ClosedDate": "",
			"Gldesc": "",
			"GlCode": "",
			"AgentDesc": "",
			"AgentCode": "5"
		},
		{
			"Id": 7,
			"FrequencyType": "Occasional",
			"Description": "ok for oms software",
			"ToDoItems": "meeting with sanjay",
			"PriorityLevel": "Critical",
			"CreatedBy": "OMS",
			"AssignedBy": "",
			"AssignedTo": "DEMOSUPPORT",
			"FromDate": "2024-04-25T00:00:00",
			"ToDate": "2024-04-25T00:00:00",
			"TaskStatus": "Pending",
			"Createdon": "2024-04-25T15:55:25.037",
			"FromMiti": "",
			"ToMiti": "",
			"ClosedStatus": "",
			"ClosedBy": "",
			"ClosedDate": "",
			"Gldesc": "Aashiyana Vehicle",
			"GlCode": "78",
			"AgentDesc": "",
			"AgentCode": "harish kc"
		},
		{
			"Id": 8,
			"FrequencyType": "Occasional",
			"Description": "ok",
			"ToDoItems": "meeting with bijay ji",
			"PriorityLevel": "Critical",
			"CreatedBy": "OMS",
			"AssignedBy": "",
			"AssignedTo": "ADMIN",
			"FromDate": "2024-04-25T00:00:00",
			"ToDate": "2024-04-26T00:00:00",
			"TaskStatus": "Pending",
			"Createdon": "2024-04-25T15:58:22.203",
			"FromMiti": "",
			"ToMiti": "",
			"ClosedStatus": "",
			"ClosedBy": "",
			"ClosedDate": "",
			"Gldesc": "Aashiyana Vehicle",
			"GlCode": "78",
			"AgentDesc": "",
			"AgentCode": "Bivan Shrestha"
		},
		{
			"Id": 9,
			"FrequencyType": "Daily",
			"Description": "for problem at oms",
			"ToDoItems": "Daily call for support at UHS",
			"PriorityLevel": "Critical",
			"CreatedBy": "OMS",
			"AssignedBy": "",
			"AssignedTo": "ADMIN",
			"FromDate": "2024-04-29T00:00:00",
			"ToDate": "2024-05-02T00:00:00",
			"TaskStatus": "Pending",
			"Createdon": "2024-04-25T16:08:40.64",
			"FromMiti": "",
			"ToMiti": "",
			"ClosedStatus": "",
			"ClosedBy": "",
			"ClosedDate": "",
			"Gldesc": "Aryal Store",
			"GlCode": "47",
			"AgentDesc": "",
			"AgentCode": "13"
		},
		{
			"Id": 10,
			"FrequencyType": "Occasional",
			"Description": "OK",
			"ToDoItems": "FOR RND TEST",
			"PriorityLevel": "Critical",
			"CreatedBy": "OMS",
			"AssignedBy": "",
			"AssignedTo": "ADMIN",
			"FromDate": "20200",
			"ToDate": "202400:00",
			"TaskStatus": "Pending",
			"Createdon": "2024-",
			"FromMiti": "",
			"ToMiti": "",
			"ClosedStatus": "",
			"ClosedBy": "",
			"ClosedDate": "",
			"Gldesc": "Aryal Store",
			"GlCode": "47",
			"AgentDesc": "",
			"AgentCode": "15"
		}
	]
}*/