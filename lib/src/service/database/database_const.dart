import 'package:oms_salesforce/config/app_detail.dart';

class DatabaseDetails {
  static String databaseName = AppDetails.appName;
  static int dbVersion = 1;

  ///
  static String clientListTable = "ClientInfo";
  static String userCode = "UserCode";
  static String loginName = "LoginName";
  static String password = "Password";
  static String userName = "UserName";
  static String createdDateTime = "CreateDateTime";
  static String isEnable = "IsEnabled";
  static String companyDBName = "DatabaseName";
  static String companyName = "CompanyName";
  static String companyPanNo = "PanNo";
  static String deviceId = "DeviceId";
  static String agentCode = "AgentCode";
  static String userType = "UserType";
  static String createdBy = "CreatedBy";
  static String createdDate = "CreatedDate";

  ///
  static String outletTable = "OutletInfo";
  static String mAreaCode = "MAreaCode";
  static String mAreaDesc = "MAreaDesc";
  static String routeCode = "route_code";
  static String routeDesc = "route_desc";
  static String glCode = "GlCode";
  static String glDesc = "GlDesc";
  static String outletCode = "outlet_code";
  static String outletDesc = "outlet_desc";
  static String mobileNo = "mobile_no";
  static String phoneNo = "phone_no";
  static String outletPerson = "outlet_person";
  static String panNo = "panno";
  static String address = "address";
  static String email = "email";
  static String priceTag = "price_tag";
  static String latitude = "Latitude";
  static String longitude = "Longitude";
  static String balance = "Balance";
  static String productPointBalance = "ProductPointBalance";
  static String routeStatus = "routeStatus";
  static String outletStatus = "outletStatus";

  static const String orderProductTableGroup = "orderProductTableGroup";
  ///
  ///
  static String productTable = "ProductInfo";
  static String grpCode = "GrpCode";
  static String grpDesc = "GrpDesc";
  //
  static String pCode = "PCode";
  static String pDesc = "PDesc";
  static String pShortName = "PShortName";
  static String alias = "Alias";
  static String mrp = "MRP";
  static String tradeRate = "TradeRate";
  static String buyRate = "BuyRate";
  static String salesRate = "SalesRate";
  static String vat = "Vat";
  static String dealerPrice = "DealerPrice";
  static String exciseRate = "ExciseRate";
  static String maxStock = "MaxStock";
  static String discountRate = "DiscountRate";
  static String stockBalance = "StockBalance";
  static String unitCode = "UnitCode";
  static String tempPCode = "tempPCode";
  static String orderPCode = "orderPCode";
  static String altQty = "AltQty";
  static String qty = "Qty";
  static String unit = "Unit";
  static String altUnit = "AltUnit";
  static String scheme = "Scheme";



  ///
  ///
  static String orderProductTable = "OrderProductInfo";
  static String salesReturnTable = "SalesReturnInfo";
  // static String glCode = "GlCode";
  // static String pCode = "PCode";
  static String quantity = "Quantity";
  static String rate = "Rate";
  // static String alias = "Alias";
  static String totalAmount = "TotalAmount";
  static String tempOrderProductTable = "TempOrderProductInfo";
  static String comment = "Comment";
  static String orderBy = "OrderBy";

  ///
  ///
  static String pendingVerifyTable = "PendingVerifyInfo";
  static String itemName = "ItemName";

  // static String rate = "Rate";
  static String netAmt = "NetAmt";
  static String brandCode = "BrandCode";
  // static String glCode = "GlCode";
  // static String glDesc = "GlDesc";

  ///
  ///
  static String deliveryTableInfo = "DeliveryTableInfo";
  static String deliveryReportByCustomerTableInfo = "DeliveryReportByCustomerTableInfo";
  static String vNo = "VNo";
  static String vDate = "VDate";
  static String VDate = "Date";
  static String vTime = "VTime";
  static String vMiti = "VMiti";
  static String miti = "Miti";
  // static String glCode = "GlCode";
  // static String glDesc = "GlDesc";
  static String glShortName = "GlShortName";
  static String netAmount = "NetAmount";
  static String agentDesc = "AgentDesc";
  static String pONo = "PONo";
  static String subledgerDesc = "SubledgerDesc";

  ///
  ///
  static String localMovementTableInfo = "LocalMovementTableInfo";
  static String lat = "lat";
  static String long = "long";
  static String timestamp = "timestamp";
  static String activity = "activity";

  // Ledger Details
  static const String ledgerDetailTable = "LedgerReportTableInfo";
  static const String vno = "Vno";
  static const String date = "Date";
  static const String Miti = "Miti";
  static const String dr = "Dr";
  static const String cr = "Cr";
  static const String source = "Source";
  static const String narration = "Narration";
  static const String remark = "Remarks";
  static const String total = "Total";

  // Save Product Availability
  static const String saveProductAvailability = "SaveProductAvailability";
  static const String sRouteCode = "RouteCode";
  static const String sOutletCode = "OutletCode";
  static const String productName = "ProductName";
  static const String itemCode = "ItemCode";
  // static const String qty = "Qty";
  static const String price = "Price";
  static const String lng = "Lng";
  static const String slat = "Lat";
  static const String timeStamp = "Timestamp";

  static const String saveOrderReportTable = "SaveOrderReportTable";
  static const String glcode = "Glcode";
  static const String salesman = "Salesman";
  static const String route = "Route";
  static const String telNoI = "TelNoI";
  static const String mobile = "Mobile";
  static const String creditLimite = "CreditLimite";
  static const String creditDay = "CreditDay";
  static const String overdays = "Overdays";
  static const String overLimit = "OverLimit";
  static const String currentBalance = "CurrentBalance";
  static const String ageOfOrder = "AgeOfOrder";
  static const String remarks = "Remarks";
  static const String managerRemarks = "ManagerRemarks";
  static const String reconcileDate = "ReconcileDate";
  static const String reconcileBy = "ReconcileBy";
  static const String entryModule = "EntryModule";
  static const String invType = "InvType";
  static const String invDate = "InvDate";




  static const String productAvailabilityTable = "ProductAvailabilityTable";
  static const String agentShortName = "AgentShortName";
  static const String areaCode = "AreaCode";
  static const String areaShortName = "AreaShortName";
  static const String areaDesc = "AreaDesc";
  static const String pADate = "PADate";


  static const String branchTable = "Branch";
  static const String branchCode = "BranchCode";





}
