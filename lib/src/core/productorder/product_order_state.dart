import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/service/sharepref/sharepref.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../model/model.dart';
import '../quickorder/db/outlet_info_db.dart';
import 'api/product_api.dart';
import 'db/product_order_db.dart';
import 'db/temp_product_order_db.dart';
import 'model/branch_model.dart';
import 'model/post_order_model.dart';
import 'model/product_order_model.dart';
import 'model/temp_product_order_model.dart';

class ProductOrderState extends ChangeNotifier {
  ProductOrderState();

  late BuildContext _context;

  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(_context);

  set getContext(BuildContext value) {
    _context = value;

    ///
    init();
  }


  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});

  CompanyDetailsModel get companyDetail => _companyDetail;

  set getCompanyDetail(CompanyDetailsModel value) {
    _companyDetail = value;
    notifyListeners();
  }

  // getBranchAPICall() async {
  //
  //   getLoading = true;
  //   BranchDataModel model = await OrderProductAPI.branch(
  //     dbName: _companyDetail.databaseName,
  //     usercode: await GetAllPref.userName(),
  //   ).onError((error, stackTrace) {
  //     CustomLog.warningLog(value: "ERROR $error");
  //
  //     getLoading = false;
  //     //
  //
  //   });
  //   CustomLog.warningLog(value: "API RESPONSE => ${jsonEncode(model)}");
  //
  //   if (model.s == 200) {
  //    // await onLoginSuccess(data: model.data);
  //     getBranchList = model.data;
  //   }
  //   //
  //   else {
  //     getLoading = false;
  //     ShowToast.errorToast(msg: model.message);
  //   }
  // }

  late List<BranchDetailsModel> _branchList = [];
  List<BranchDetailsModel> get branchList => _branchList;
  set getBranchList(List<BranchDetailsModel> value) {
    _branchList = value;
    notifyListeners();
  }


  late bool _isLoading = false;

  bool get isLoading => _isLoading;

  set getLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  init() async {
    _companyDetail = await GetAllPref.companyDetail();
    await getOutletInfoState();
    // await clear();
    // await checkConnection();
  }

  late ProductState productState;

  getOutletInfoState() {
    productState = Provider.of<ProductState>(context, listen: false);
  }

  clear() async {
    _isLoading = false;

    _productDetail = FilterProductModel.fromJson({});

    _quantity = TextEditingController(text: "0.00");
    _altQty = TextEditingController(text: "0.00");
    _salesRate = TextEditingController(text: "");

    // Total Price = Total Amount of the single product (ie rate * quantity)
    _totalPrice = 0.0;
  }

  late FilterProductModel _productDetail = FilterProductModel.fromJson({});

  FilterProductModel get productDetail => _productDetail;

  set getProductDetails(FilterProductModel value) {
    _productDetail = value;
    notifyListeners();
  }

  late TextEditingController _altQty = TextEditingController(text: "");

  TextEditingController get altQty => _altQty;

  late TextEditingController _quantity = TextEditingController(text: "");

  TextEditingController get quantity => _quantity;

  late TextEditingController _salesRate = TextEditingController(text: "");

  TextEditingController get salesRate => _salesRate;

  set getSalesRate(String value) {
    _salesRate.text = value;
    notifyListeners();
  }

  late double _totalPrice = 0.0;

   double get totalPrice => _totalPrice;

  late double _totalPriceWithVat = 0.0;

  double get totalPriceWithVat => _totalPriceWithVat;

  late double _totalVat = 0.0;

  double get totalVat => _totalVat;

  late double _totalAlt = 0.0;

  double get totalAlt => _totalAlt;

  set getTotalPrice(double value) {
    _totalPrice = value;
    CustomLog.actionLog(value: "CUSTOM LOG => $_totalPrice");
    notifyListeners();
  }

  set getTotalPriceWithVat(double value) {
    _totalPriceWithVat = value;
    CustomLog.actionLog(value: "CUSTOM LOG => $_totalPriceWithVat");
    notifyListeners();
  }

  set getTotalVat(double value) {
    _totalVat = value;
    notifyListeners();
  }

  set getTotalAlt(double value) {
    _totalAlt = value;
    notifyListeners();
  }



  calculate() async {

    if (_quantity.text.isEmpty || _salesRate.text.isEmpty) {
      getTotalPrice = 0.00;
      getTotalVat = 0.00;
      getTotalAlt = 0.00;
      getTotalPriceWithVat = 0.00;
    }
    ///
    else {
      if(productDetail.altQty == '0.00'){
      }else{
        if(_altQty.text == "0.00"){

          double altQtyConversion = double.parse(_quantity.text) / double.parse(productDetail.altQty);
          // _altQty.text = altQtyConversion.toString();
        }else{
          double altQtyConversion1 = double.parse(productDetail.altQty) * double.parse(_altQty.text.isNotEmpty ? _altQty.text : "0.00");
          _quantity.text = altQtyConversion1.toString();
          double altQtyConversion = double.parse(_quantity.text) / double.parse(productDetail.altQty);
         //   _altQty.text = altQtyConversion.toString();
        }

      }
     double totalWithVat = (double.parse(_quantity.text) * double.parse(_salesRate.text) * 13) / 100;
     getTotalVat = totalWithVat;
      getTotalPriceWithVat = double.parse(_quantity.text) * double.parse(_salesRate.text) + totalWithVat;
     getTotalPrice = double.parse(_quantity.text) * double.parse(_salesRate.text);
    }
    ///
    notifyListeners();
  }

  saveTempProduct(String code) async {
    if (_orderFormKey.currentState!.validate()) {
      final productState = Provider.of<ProductState>(context, listen: false);
      CustomLog.actionLog(value: "VALUE => ${_totalPrice.toStringAsFixed(2)}");
      TempProductOrderModel orderProduct = TempProductOrderModel(
        routeCode: productState.outletDetail.routeCode,
        //outletCode: _productDetail.glCode,
        outletCode: await GetAllPref.getOutLetCode(),
        pCode: _productDetail.pCode,
        alias: _productDetail.alias,
        rate: _salesRate.text.trim(),
        quantity: _quantity.text.trim(),
        totalAmount: _totalPrice.toStringAsFixed(2),
      );
    //  await OutLetInfoDatabase.instance.updateTempCode(await GetAllPref.getTempCode(),code);
      await TempProductOrderDatabase.instance.insertData(orderProduct);
      productState.getProductListFromDB(
          groupCode: productState.selectedGroup.grpCode);
      navigator.pop();

      notifyListeners();
    }
  }

  /// [ ALL ORDER LIST IS FOR ORDER EDIT AND DELETE ]
  late List<TempProductOrderModel> _allTempOrderList =
      <TempProductOrderModel>[];

  List<TempProductOrderModel> get allTempOrderList => _allTempOrderList;

  set getAllTempOrderList(List<TempProductOrderModel> value) {
    _allTempOrderList.clear();
    _allTempOrderList = value;
    notifyListeners();
  }

  getAllTempProductOrderList() async {
    await TempProductOrderDatabase.instance.getAllProductList().then((value) {
      getAllTempOrderList = value;
    });
    notifyListeners();
  }

  /// [ EDIT/UPDATE ORDERED PRODUCT ]
  updateTempOrderProductDetail({
    required String productID,
    required String rate,
    required String quantity,
  }) async {
    await TempProductOrderDatabase.instance
        .editDataById(productID: productID, rate: rate, quantity: quantity)
        .then((value) {
      getAllTempOrderList = value;
    });
    await getAllTempProductOrderList();

    notifyListeners();
  }

  /// [ DELETE ORDERED PRODUCT ]
  deleteTempOrderProduct({required String productID}) async {
    await TempProductOrderDatabase.instance
        .deleteDataByID(productID: productID);
    await getAllTempProductOrderList();

    notifyListeners();
  }

  late BranchDataModel _branchInfo = BranchDataModel.fromJson({});
  BranchDataModel get branchInfo => _branchInfo;
  getBranchInfo() async {
    _branchInfo = await GetAllPref.branchDetail();
    notifyListeners();
  }

  Future productOrderAPICall() async {
    await getBranchInfo();
    getCompanyDetail = await GetAllPref.companyDetail();
    BasicModel modelData = await OrderProductAPI.postOrder(
      dbName: _companyDetail.databaseName,
     // branchCode: _branchInfo.unitCode,
      branchCode: await GetAllPref.getBranch() ?? 'null',
      salesManId: _companyDetail.agentCode,
      orderDetails: await getFormatPOSTDATA(),
    );
    if (modelData.statusCode == 200) {
      ShowToast.successToast(msg: modelData.message);
      await ProductOrderDatabase.instance.deleteData();
      print(modelData.data);

    } else {
     // ShowToast.errorToast(msg: modelData.message);
      ShowToast.errorToast(msg: "Wrong");
    }
    notifyListeners();
  }
  getIndexTotalAmount({required String rate}) {
    double vatAmount = (double.parse(rate) * 0.13);
    CustomLog.actionLog(value: "TOTAL AMOUNT CHECKDDDD => $rate");
    return vatAmount + double.parse(rate);
  }

  late double _totalBalance = 0.00;

  double get totalBalance => _totalBalance;

  set getTotalBalance(double value) {
    _totalBalance = value;
    notifyListeners();
  }

  calculateTotalAmount() {
    _totalBalance = 0.00;
    for (var element in allTempOrderList) {
      _totalBalance += getIndexTotalAmount(rate: element.totalAmount);
    }
    return _totalBalance.toStringAsFixed(2);
  }

  ///
  List<String> options = ['By Visit', 'By Phone/SMS'];

  late int selectedOption;

  /// ***************************************** ///
  /// ***************************************** ///
  /// [ FINAL ORDER PRODUCT]

  onAddCommentInit() async {
    _orderOption = "";
    _comment = TextEditingController(text: "");
  }

  late String _orderOption = "";

  String get orderOption => _orderOption;

  set getOrderOption(String value) {
    _orderOption = "";
    _orderOption = value;
    notifyListeners();
  }

  final _commentKey = GlobalKey<FormState>();
  final _orderFormKey = GlobalKey<FormState>();

  GlobalKey<FormState> get commentKey => _commentKey;
  GlobalKey<FormState> get orderFormKey => _orderFormKey;

  late TextEditingController _comment = TextEditingController(text: "");

  TextEditingController get comment => _comment;

  Future onFinalOrderSaveToDB() async {

    CustomLog.actionLog(value: "TEMP ORDER COUNT  => ${_allTempOrderList.length}");

    for(int i = 0; i<_allTempOrderList.length; i++){
      ProductOrderModel finalOrder = ProductOrderModel(
        routeCode: _allTempOrderList[i].routeCode,
        outletCode: _allTempOrderList[i].outletCode,
        pCode: _allTempOrderList[i].pCode,
        alias: _allTempOrderList[i].alias,
        rate: _allTempOrderList[i].rate,
        quantity: _allTempOrderList[i].quantity,
        totalAmount: _allTempOrderList[i].totalAmount,
        comment: _comment.text.trim(),
        orderBy: _orderOption.isEmpty ? "By Visit" : _orderOption,
      );
      await ProductOrderDatabase.instance.insertData(finalOrder);
    }
    await TempProductOrderDatabase.instance.deleteData();

  }

  /// ***************************************************** ///
  late List<OrderPostModel> _orderPostDataList = [];

  List<OrderPostModel> get orderPostDataList => _orderPostDataList;

  set getOrderPostData(List<OrderPostModel> value) {
    _orderPostDataList.clear();
    _orderPostDataList = value;
    notifyListeners();
  }

  getDataFromOrderTable() async {
    await ProductOrderDatabase.instance.getOrderDetails().then((value) {
      CustomLog.actionLog(value: "LENGTH => ${value.length}");
    });
  }

  getOrderByOutletAndRoute() async {
    await ProductOrderDatabase.instance
        .getOrderByOutletAndRoute(outletCode: '13', routeCode: '1')
        .then((value) {
      CustomLog.actionLog(value: "LENGTH => ${value.length}");
    });
  }

  getFormatPOSTDATA() async {
    await ProductOrderDatabase.instance.getFormatPOSTDATA().then((value) {
      getOrderPostData = value;
      CustomLog.actionLog(value: "LENGTH => ${value.length}");
      CustomLog.actionLog(value: "ORDER LIST DATA => ${jsonEncode(value)}");
    });

    CustomLog.actionLog(
        value: "ORDER LIST DATA => ${jsonEncode(_orderPostDataList)}");
    return _orderPostDataList;
  }
}
