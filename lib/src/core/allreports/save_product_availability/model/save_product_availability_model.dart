class SaveProductAvailabilityModel {
  SaveProductAvailabilityModel({
    required this.routeCode,
    required this.outletCode,
    required this.productName,
    required this.itemCode,
    required this.qty,
    required this.price,
    required this.lat,
    required this.lng,
    required this.timestamp,
  });

  final String routeCode;
  final String outletCode;
  final String productName;
  final String itemCode;
  final String qty;
  final String price;
  final String lat;
  final String lng;
  final String timestamp;

  factory SaveProductAvailabilityModel.fromJson(Map<String, dynamic> json) {
    return SaveProductAvailabilityModel(
      routeCode: json["RouteCode"] ?? "",
      outletCode: json["OutletCode"] ?? "",
      productName: json["ProductName"] ?? "",
      itemCode: json["ItemCode"] ?? "",
      qty: json["Qty"] ?? "",
      price: json["Price"] ?? "",
      lat: json["Lat"] ?? "",
      lng: json["Lng"] ?? "",
      timestamp: json["Timestamp"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "RouteCode": routeCode,
        "OutletCode": outletCode,
        "ProductName": productName,
        "ItemCode": itemCode,
        "Qty": qty,
        "Price": price,
        "Lat": lat,
        "Lng": lng,
        "Timestamp": timestamp,
      };

  /// For PDF
  String getIndex(int index) {
    switch (index) {
      case 0:
        return productName;
      case 1:
        return qty;
      case 2:
        return price;
    }
    return '';
  }
}

/*
{
	"SalesmanId": "salesmanId",
	"DbName": "databaseName",
	"RouteCode": "routeCode",
	"OutletCode": "outletCode",
	"ItemCode": "product",
	"Qty": "roduct['qty']",
	"Price": "product['price']",
	"Lat": "product['lat']",
	"Lng": "product['lng']",
	"Timestamp": "product['timestamp']"
}*/