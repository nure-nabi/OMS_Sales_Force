class SalesmanActivityModel {
  SalesmanActivityModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  final String message;
  final int statusCode;
  final List<SalesmanActivityDataModel> data;

  factory SalesmanActivityModel.fromJson(Map<String, dynamic> json) {
    return SalesmanActivityModel(
      message: json["MESSAGE"] ?? "",
      statusCode: json["STATUS_CODE"] ?? 0,
      data: json["data"] == null
          ? []
          : List<SalesmanActivityDataModel>.from(
              json["data"]!.map((x) => SalesmanActivityDataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "MESSAGE": message,
        "STATUS_CODE": statusCode,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class SalesmanActivityDataModel {
  SalesmanActivityDataModel({
    required this.activity,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.salesManId,
    required this.agentDesc,
    required this.date,
    required this.date1,
    required this.time,
  });

  final String activity;
  final String latitude;
  final String longitude;
  final String address;
  final String salesManId;
  final String agentDesc;
  final String date;
  final String date1;
  final String time;

  factory SalesmanActivityDataModel.fromJson(Map<String, dynamic> json) {
    return SalesmanActivityDataModel(
      activity: json["Activity"] ?? "",
      latitude: json["latitude"] ?? "",
      longitude: json["Longitude"] ?? "",
      address: json["Address"] ?? "",
      salesManId: json["SalesManId"] ?? "",
      agentDesc: json["AgentDesc"] ?? "",
      date: json["Date"] ?? "",
      date1: json["Date1"] ?? "",
      time: json["Time"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "Activity": activity,
        "latitude": latitude,
        "Longitude": longitude,
        "Address": address,
        "SalesManId": salesManId,
        "AgentDesc": agentDesc,
        "Date": date,
        "Date1": date1,
        "Time": time,
      };
}

/*
{
	"MESSAGE": "Succesfully",
	"STATUS_CODE": 200,
	"data": [
		{
			"Activity": "user logged in",
			"latitude": "27.6974694",
			"Longitude": "85.3047984",
			"Address": "KATHMANDU-NEPAL",
			"SalesManId": "4",
			"AgentDesc": "Bivan Shrestha",
			"Date": "2023",
			"Date1": "22023",
			"Time": "11"
		}
	]
}*/