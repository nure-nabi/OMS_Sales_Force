class ProductOrderModel {
  ProductOrderModel({
    required this.routeCode,
    required this.outletCode,
    required this.pCode,
    required this.alias,
    required this.rate,
    required this.quantity,
    required this.totalAmount,
    required this.comment,
    required this.orderBy,
  });

  final String routeCode;
  final String outletCode;
  final String pCode;
  final String alias;
  final String rate;
  final String quantity;
  final String totalAmount;
  final String comment;
  final String orderBy;

  factory ProductOrderModel.fromJson(Map<String, dynamic> json) {
    return ProductOrderModel(
      routeCode: json["route_code"] ?? "",
      outletCode: json["outlet_code"] ?? "",
      pCode: json["PCode"] ?? "",
      quantity: json["Quantity"] ?? "",
      rate: json["Rate"] ?? "",
      alias: json["Alias"] ?? "",
      totalAmount: json["TotalAmount"] ?? "",
      comment: json["Comment"] ?? "",
      orderBy: json["orderBy"] ?? "",

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
        "Comment": comment,
        "orderBy": orderBy,
      };
}
