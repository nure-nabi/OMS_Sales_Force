class CreateActivityModel {
  CreateActivityModel({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  factory CreateActivityModel.fromJson(Map<String, dynamic> json) {
    return CreateActivityModel(
      message: json["MESSAGE"] ?? "",
      statusCode: json["STATUS_CODE"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "MESSAGE": message,
        "STATUS_CODE": statusCode,
      };
}
