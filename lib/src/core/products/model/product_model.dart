class ProductModel {
  ProductModel({
    required this.statusCode,
    required this.status,
    required this.data,
  });

  final int statusCode;
  final bool status;
  final List<ProductGroupModel> data;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      statusCode: json["status_code"] ?? 0,
      status: json["status"] ?? false,
      data: json["data"] == null
          ? []
          : List<ProductGroupModel>.from(
              json["data"]!.map((x) => ProductGroupModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class ProductGroupModel {
  ProductGroupModel({
    required this.grpCode,
    required this.grpDesc,
    required this.productSubGroupList,
  });

  final String grpCode;
  final String grpDesc;
  final List<ProductSubGroupModel> productSubGroupList;

  factory ProductGroupModel.fromJson(Map<String, dynamic> json) {
    return ProductGroupModel(
      grpCode: json["GrpCode"] ?? "",
      grpDesc: json["GrpDesc"] ?? "",
      productSubGroupList: json["ProductSubGroupList"] == null
          ? []
          : List<ProductSubGroupModel>.from(json["ProductSubGroupList"]!
              .map((x) => ProductSubGroupModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "GrpCode": grpCode,
        "GrpDesc": grpDesc,
        "ProductSubGroupList":
            productSubGroupList.map((x) => x.toJson()).toList(),
      };
}

class ProductSubGroupModel {
  ProductSubGroupModel({
    required this.sGrpCode,
    required this.sGrpDesc,
    required this.productList,
  });

  final String sGrpCode;
  final String sGrpDesc;
  final List<ProductDataModel> productList;

  factory ProductSubGroupModel.fromJson(Map<String, dynamic> json) {
    return ProductSubGroupModel(
      sGrpCode: json["SGrpCode"] ?? "",
      sGrpDesc: json["SGrpDesc"] ?? "",
      productList: json["ProductList"] == null ? [] : List<ProductDataModel>.from(json["ProductList"]!.map((x) => ProductDataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "SGrpCode": sGrpCode,
        "SGrpDesc": sGrpDesc,
        "ProductList": productList.map((x) => x.toJson()).toList(),
      };
}

class ProductDataModel {
  ProductDataModel({
    required this.pCode,
    required this.pDesc,
    required this.pShortName,
    required this.alias,
    required this.mrp,
    required this.tradeRate,
    required this.buyRate,
    required this.salesRate,
    required this.vat,
    required this.dealerPrice,
    required this.exciseRate,
    required this.maxStock,
    required this.discountRate,
    required this.stockBalance,
    required this.unitCode,
    required this.altQty,
    required this.qty,
    required this.unit,
    required this.altUnit,
    required this.scheme,
  });

  final String pCode;
  final String pDesc;
  final String pShortName;
  final String alias;
  final String mrp;
  final String tradeRate;
  final String buyRate;
  final String salesRate;
  final String vat;
  final String dealerPrice;
  final String exciseRate;
  final String maxStock;
  final String discountRate;
  final String stockBalance;
  final String unitCode;
  final String altQty;
  final String qty;
  final String unit;
  final String altUnit;
  final String scheme;

  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    return ProductDataModel(
      pCode: json["PCode"] ?? "",
      pDesc: json["PDesc"] ?? "",
      pShortName: json["PShortName"] ?? "",
      alias: json["Alias"] ?? "",
      mrp: json["MRP"] == null ? "0.00" : json["MRP"].toString(),
      tradeRate: json["TradeRate"] == null ? "0.00" : json["TradeRate"].toString(),
      buyRate: json["BuyRate"] == null ? "0.00" : json["BuyRate"].toString(),
      salesRate:
          json["SalesRate"] == null ? "0.00" : json["SalesRate"].toString(),
      vat: json["Vat"] == null ? "0.00" : json["Vat"].toString(),
      dealerPrice:
          json["DealerPrice"] == null ? "0.00" : json["DealerPrice"].toString(),
      exciseRate:
          json["ExciseRate"] == null ? "0.00" : json["ExciseRate"].toString(),
      maxStock: json["MaxStock"] == null ? "0.00" : json["MaxStock"].toString(),
      discountRate: json["DiscountRate"] == null
          ? "0.00"
          : json["DiscountRate"].toString(),
      stockBalance: json["StockBalance"] == null
          ? "0.00"
          : json["StockBalance"].toString(),
      unitCode: json["UnitCode"] ?? "",
      altQty: json["AltQty"] == null ? "0.00" : json["AltQty"].toString(),
      qty: json["Qty"] == null ? "0.00" : json["Qty"].toString(),
      unit: json["Unit"] ?? "",
      altUnit: json["AltUnit"] ?? "",
      scheme: json["Scheme"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "PCode": pCode,
        "PDesc": pDesc,
        "PShortName": pShortName,
        "Alias": alias,
        "MRP": mrp,
        "TradeRate": tradeRate,
        "BuyRate": buyRate,
        "SalesRate": salesRate,
        "Vat": vat,
        "DealerPrice": dealerPrice,
        "ExciseRate": exciseRate,
        "MaxStock": maxStock,
        "DiscountRate": discountRate,
        "StockBalance": stockBalance,
        "UnitCode": unitCode,
        "AltQty": altQty,
        "Qty": qty,
        "Unit": unit,
        "AltUnit": altUnit,
        "Scheme": scheme,


      };
}
