class TempProductOrderModel {
  TempProductOrderModel({
    required this.routeCode,
    required this.outletCode,
    required this.pCode,
    required this.alias,
    required this.rate,
    required this.quantity,
    required this.totalAmount,
  });

  final String routeCode;
  final String outletCode;
  final String pCode;
  final String alias;
  final String rate;
  final String quantity;
  final String totalAmount;

  factory TempProductOrderModel.fromJson(Map<String, dynamic> json) {
    return TempProductOrderModel(
      routeCode: json["route_code"] ?? "",
      outletCode: json["outlet_code"] ?? "",
      pCode: json["PCode"] ?? "",
      quantity: json["Quantity"] ?? "",
      rate: json["Rate"] ?? "",
      alias: json["Alias"] ?? "",
      totalAmount: json["TotalAmount"] ?? "",

      ///
    );
  }

  Map<String, dynamic> toJson() => {
        "route_code": routeCode,
        "outlet_code": outletCode,
        "PCode": pCode,
        "Quantity": quantity,
        "Rate": rate,
        "Alias": alias,
        "TotalAmount": totalAmount,
      };
}
