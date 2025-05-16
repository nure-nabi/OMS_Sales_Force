import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oms_salesforce/model/basic_model.dart';
import 'package:oms_salesforce/src/core/allreports/db/sales_return_db.dart';
import 'package:oms_salesforce/src/core/login/company_model.dart';
import 'package:oms_salesforce/src/core/productorder/model/product_order_model.dart';
import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/service/router/router.dart';
import 'package:oms_salesforce/src/service/sharepref/get_all_pref.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../pendingsync/pendingsync.dart';
import '../apis/sales_return_api.dart';
import 'sales_return_product.dart';

class SalesReturnState extends ChangeNotifier {
  SalesReturnState();

  late BuildContext _context;
  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(_context);
  set getContext(BuildContext value) {
    _context = value;

    ///
    init();
  }

  late bool _isLoading = false;
  bool get isLoading => _isLoading;
  set getLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  init() async {
    await getOutletInfoState();
    await clean();
    await getGroupProductListFromDB();
  }

  clean() async {
    _isLoading = false;
    _groupList = [];
    _filterGroupList = [];

    _comment = TextEditingController(text: "");
    _salesRate = TextEditingController(text: "");
    _quantity = TextEditingController(text: "");

    _companyDataModel = await GetAllPref.companyDetail();
  }

  late CompanyDetailsModel _companyDataModel = CompanyDetailsModel.fromJson({});
  CompanyDetailsModel get companyDataModel => _companyDataModel;

  late ProductState productState;
  getOutletInfoState() {
    productState = Provider.of<ProductState>(context, listen: false);
  }

  set filterProductGroup(value) {
    _filterGroupList = _groupList
        .where((u) => (u.grpDesc.toLowerCase().contains(value.toLowerCase())))
        .toList();
    notifyListeners();
  }

  late FilterProductModel _selectedGroup = FilterProductModel.fromJson({});
  FilterProductModel get selectedGroup => _selectedGroup;
  set getSelectedGroup(FilterProductModel value) {
    _selectedGroup = value;
    notifyListeners();
  }

  late List<FilterProductModel> _groupList = [], _filterGroupList = [];
  List<FilterProductModel> get groupList => _groupList;
  List<FilterProductModel> get filterGroupList => _filterGroupList;
  set getProductGroupList(List<FilterProductModel> value) {
    _groupList = value;
    _filterGroupList = _groupList;
    notifyListeners();
  }

  getGroupProductListFromDB() async {
    await ProductInfoDatabase.instance
        .getProductGroupData(glCode: productState.outletDetail.glCode)
        .then((value) {
      getProductGroupList = value;
    });
    notifyListeners();
  }

  late FilterProductModel _productDetails = FilterProductModel.fromJson({});
  FilterProductModel get productDetails => _productDetails;
  set getProductDetails(FilterProductModel value) {
    _productDetails = value;
    notifyListeners();
  }

  late List<FilterProductModel> _productList = [], _filterProductList = [];
  List<FilterProductModel> get productList => _productList;
  List<FilterProductModel> get filterProductList => _filterProductList;

  set getProductList(List<FilterProductModel> value) {
    _productList = [];
    _filterProductList = [];
    _productList = value;
    _filterProductList = _productList;
    notifyListeners();
  }

  groupSelected() async {
    await ProductInfoDatabase.instance
        .getProductList(
            groupCode: _selectedGroup.grpCode,
            glCode: productState.outletDetail.glCode,
            outletCode: productState.outletDetail.outletCode)
        .then((value) {
      getProductList = value;
    });

    await navigator.push(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const SalesReturnProductScreen(),
      ),
    );
    notifyListeners();
  }

  final _commentKey = GlobalKey<FormState>();
  final _orderFormKey = GlobalKey<FormState>();

  GlobalKey<FormState> get commentKey => _commentKey;
  GlobalKey<FormState> get orderFormKey => _orderFormKey;

  late TextEditingController _comment = TextEditingController(text: "");
  TextEditingController get comment => _comment;

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
  set getTotalPrice(double value) {
    _totalPrice = value;
    CustomLog.actionLog(value: "CUSTOM LOG => $_totalPrice");
    notifyListeners();
  }

  calculate() async {
    if (_quantity.text.isEmpty || _salesRate.text.isEmpty) {
      getTotalPrice = 0.00;
    }

    ///
    else {
      getTotalPrice =
          double.parse(_quantity.text) * double.parse(_salesRate.text);
    }

    ///
    notifyListeners();
  }

  saveProduct() async {
    if (_orderFormKey.currentState!.validate()) {
      final productState = Provider.of<ProductState>(context, listen: false);
      CustomLog.actionLog(value: "VALUE => ${_totalPrice.toStringAsFixed(2)}");
      ProductOrderModel orderProduct = ProductOrderModel(
        routeCode: productState.outletDetail.routeCode,
        outletCode: productState.outletDetail.glCode,
        pCode: _productDetails.pCode,
        alias: _productDetails.alias,
        rate: _salesRate.text.trim(),
        quantity: _quantity.text.trim(),
        totalAmount: _totalPrice.toStringAsFixed(2),
        comment: '',
        orderBy: '',
      );

      await SalesReturnDatabase.instance.insertData(orderProduct);
      await productState.getProductListFromDB(
        groupCode: productState.selectedGroup.grpCode,
      );
      navigator.pop();

      notifyListeners();
    }
  }

  /// [ ALL ORDER LIST IS FOR ORDER EDIT AND DELETE ]
  late List<ProductPendingSync> _allTempOrderList = <ProductPendingSync>[];
  List<ProductPendingSync> get allTempOrderList => _allTempOrderList;
  set getAllTempOrderList(List<ProductPendingSync> value) {
    _allTempOrderList.clear();
    _allTempOrderList = value;
    notifyListeners();
  }

  getAllSalesReturnData() async {
    await SalesReturnDatabase.instance.getAllProductList().then((value) {
      getAllTempOrderList = value;
    });
    notifyListeners();
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

  getIndexTotalAmount({required String rate}) {
    double vatAmount = (double.parse(rate) * 0.13);
    CustomLog.actionLog(value: "TOTAL AMOUNT CHECK => $rate");
    return vatAmount + double.parse(rate);
  }

  /// [ EDIT/UPDATE ORDERED PRODUCT ]
  updateTempOrderProductDetail({
    required String productID,
    required String rate,
    required String quantity,
  }) async {
    await SalesReturnDatabase.instance
        .editDataById(productID: productID, rate: rate, quantity: quantity)
        .then((value) {
      getAllTempOrderList = value;
    });
    await getAllSalesReturnData();

    notifyListeners();
  }

  /// [ DELETE ORDERED PRODUCT ]
  deleteTempOrderProduct({required String productID}) async {
    await SalesReturnDatabase.instance.deleteById(pCode: productID);
    await getAllSalesReturnData();

    notifyListeners();
  }

  onSalesReturnAPICall() async {
    getLoading = true;
    navigator.pop();
    String productList = jsonEncode(_allTempOrderList).toString();

    BasicModel modelData = await SalesReturnAPI.productSalesReturnSave(
      databaseName: _companyDataModel.databaseName,
      userName: _companyDataModel.databaseName,
      remarks: comment.text.trim(),
      glCode: productState.outletDetail.glCode,
      productList: productList,
    );

    if (modelData.statusCode == 200) {
      getLoading = false;
      await SalesReturnDatabase.instance.deleteData();

      navigator.pushNamedAndRemoveUntil(
        homePagePath,
        (route) => false,
      );
      ShowToast.showToast(
        msg: modelData.message,
        backgroundColor: Colors.green,
      );
    } else {
      getLoading = false;
    }
    notifyListeners();
  }
}
