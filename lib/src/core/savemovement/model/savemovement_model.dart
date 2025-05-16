class SaveMovementModel {
  SaveMovementModel({
    required this.lat,
    required this.long,
    required this.timestamp,
    required this.activity,
  });

  final String lat;
  final String long;
  final String timestamp;
  final String activity;

  factory SaveMovementModel.fromJson(Map<String, dynamic> json) {
    return SaveMovementModel(
      lat: json["lat"] ?? "",
      long: json["long"] ?? "",
      timestamp: json["timestamp"] ?? "",
      activity: json["activity"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
        "timestamp": timestamp,
        "activity": activity,
      };
}

/*
{
	"lat": "",
	"long": "",
	"timestamp": "",
	"activity": ""
}*/