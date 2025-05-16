class FilterOutletInfoModel {
  FilterOutletInfoModel({
    required this.glCode,
    required this.glDesc,
    required this.outletCode,
    required this.outletDesc,
    required this.mobileNo,
    required this.phoneNo,
    required this.outletPerson,
    required this.panno,
    required this.address,
    required this.email,
    required this.priceTag,
    required this.latitude,
    required this.longitude,
    required this.balance,
    required this.productPointBalance,
    //
    required this.mAreaCode,
    required this.mAreaDesc,
    required this.routeCode,
    required this.routeDesc,

    ///
    required this.routeStatus,
    required this.outletStatus,

    ///
    required this.tempPCode,
    required this.orderPCode,
  });

  final String glCode;
  final String glDesc;
  final String outletCode;
  final String outletDesc;
  final String mobileNo;
  final String phoneNo;
  final String outletPerson;
  final String panno;
  final String address;
  final String email;
  final String priceTag;
  final String latitude;
  final String longitude;
  final String balance;
  final String productPointBalance;

  //
  final String mAreaCode;
  final String mAreaDesc;

  //
  final String routeCode;
  final String routeDesc;

  final String routeStatus;
  final String outletStatus;

  /// [ TO UPDATE COLOR OF THE ORDER PRODUCTS ]
  final String tempPCode;
  final String orderPCode;

  factory FilterOutletInfoModel.fromJson(Map<String, dynamic> json) {
    return FilterOutletInfoModel(
      glCode: json["GlCode"] ?? "",
      glDesc: json["GlDesc"] ?? "",
      outletCode: json["outlet_code"] ?? "",
      outletDesc: json["outlet_desc"] ?? "",
      mobileNo: json["mobile_no"] ?? "",
      phoneNo: json["phone_no"] ?? "",
      outletPerson: json["outlet_person"] ?? "",
      panno: json["panno"] ?? "",
      address: json["address"] ?? "",
      email: json["email"] ?? "",
      priceTag: json["price_tag"] ?? "",
      latitude: json["Latitude"] ?? "",
      longitude: json["Longitude"] ?? "",
      balance: json["Balance"] ?? "",
      productPointBalance: json["ProductPointBalance"] ?? "",
      //
      mAreaCode: json["MAreaCode"] ?? "",
      mAreaDesc: json["MAreaDesc"] ?? "",
      //
      routeCode: json["route_code"] ?? "",
      routeDesc: json["route_desc"] ?? "",

      ///
      routeStatus: json["routeStatus"] ?? "",
      outletStatus: json["outletStatus"] ?? "",

      ///
      tempPCode: json['tempPCode'] ?? "",
      orderPCode: json["orderPCode"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "GlCode": glCode,
        "GlDesc": glDesc,
        "outlet_code": outletCode,
        "outlet_desc": outletDesc,
        "mobile_no": mobileNo,
        "phone_no": phoneNo,
        "outlet_person": outletPerson,
        "panno": panno,
        "address": address,
        "email": email,
        "price_tag": priceTag,
        "Latitude": latitude,
        "Longitude": longitude,
        "Balance": balance,
        "ProductPointBalance": productPointBalance,
        //
        "MAreaCode": mAreaCode,
        "MAreaDesc": mAreaDesc,
        //
        "route_code": routeCode,
        "route_desc": routeDesc,

        ///
        "routeStatus": routeStatus,
        "outletStatus": outletStatus,

        ///
        "tempPCode": tempPCode,
        "orderPCode": orderPCode,
      };
}
