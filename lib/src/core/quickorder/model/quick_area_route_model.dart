class QuickAreaRouteModel {
  QuickAreaRouteModel({
    required this.statusCode,
    required this.status,
    required this.zoneData,
  });

  final int statusCode;
  final bool status;
  final List<ZoneRouteModel> zoneData;

  factory QuickAreaRouteModel.fromJson(Map<String, dynamic> json) {
    return QuickAreaRouteModel(
      statusCode: json["status_code"] ?? 0,
      status: json["status"] ?? false,
      zoneData: json["data"] == null
          ? []
          : List<ZoneRouteModel>.from(
              json["data"]!.map((x) => ZoneRouteModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "data": zoneData.map((x) => x.toJson()).toList(),
      };
}

class ZoneRouteModel {
  ZoneRouteModel({
    required this.mAreaCode,
    required this.mAreaDesc,
    required this.routeList,
  });

  final String mAreaCode;
  final String mAreaDesc;
  final List<DistrictRouteModel> routeList;

  factory ZoneRouteModel.fromJson(Map<String, dynamic> json) {
    return ZoneRouteModel(
      mAreaCode: json["MAreaCode"] ?? "",
      mAreaDesc: json["MAreaDesc"] ?? "",
      routeList: json["RouteList"] == null
          ? []
          : List<DistrictRouteModel>.from(
              json["RouteList"]!.map((x) => DistrictRouteModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "MAreaCode": mAreaCode,
        "MAreaDesc": mAreaDesc,
        "RouteList": routeList.map((x) => x.toJson()).toList(),
      };
}

class DistrictRouteModel {
  DistrictRouteModel({
    required this.routeCode,
    required this.routeDesc,
    required this.outletInfo,
  });

  final String routeCode;
  final String routeDesc;
  final List<OutletInfoModel> outletInfo;

  factory DistrictRouteModel.fromJson(Map<String, dynamic> json) {
    return DistrictRouteModel(
      routeCode: json["route_code"] ?? "",
      routeDesc: json["route_desc"] ?? "",
      outletInfo: json["outlet_info"] == null
          ? []
          : List<OutletInfoModel>.from(
              json["outlet_info"]!.map((x) => OutletInfoModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "route_code": routeCode,
        "route_desc": routeDesc,
        "outlet_info": outletInfo.map((x) => x.toJson()).toList(),
      };
}

class OutletInfoModel {
  OutletInfoModel({
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

  factory OutletInfoModel.fromJson(Map<String, dynamic> json) {
    return OutletInfoModel(
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
      };
}
