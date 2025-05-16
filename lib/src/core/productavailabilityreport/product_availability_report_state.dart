import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/src/core/pendingverify/api/pending_verify_api.dart';
import 'package:oms_salesforce/src/core/productavailabilityreport/product_availability_details_screen.dart';
import 'package:oms_salesforce/src/core/productavailabilityreport/product_availability_product_qty_screen.dart';
import 'package:provider/provider.dart';

import '../../service/sharepref/sharepref.dart';
import '../login/login.dart';
import '../quickorder/quick_order_state.dart';
import 'api/pending_verify_api.dart';
import 'db/product_availability_report_db.dart';
import 'model/product_avalability_report_model.dart';


class ProductAvailabilityReportState extends ChangeNotifier {
  ProductAvailabilityReportState();

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

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});
  CompanyDetailsModel get companyDetail => _companyDetail;

  init() async {
   await getGlDescInfoState();
    await clear();
    await getDataListFromAPI();
  }

  clear() async {
    _isLoading = false;
    _companyDetail = await GetAllPref.companyDetail();
  }


  late List<ProductAvailabilityReportModel> _glDescList = [];
  List<ProductAvailabilityReportModel> get glDescList => _glDescList;
  set getGlDescList(List<ProductAvailabilityReportModel> value) {
    _glDescList = [];
    _glDescList = value;
    notifyListeners();
  }
  late List<ProductAvailabilityReportModel> _productList = [];
  List<ProductAvailabilityReportModel> get productList => _productList;
  set getProductList(List<ProductAvailabilityReportModel> value) {
    _productList = [];
    _productList = value;
    notifyListeners();
  }

  late List<ProductAvailabilityReportModel> _productAvailabilityReportList = [];
  List<ProductAvailabilityReportModel> get productAvailabilityReportList => _productAvailabilityReportList;
  set setProductAvailabilityReport(List<ProductAvailabilityReportModel> value) {
    _productAvailabilityReportList = value;
    notifyListeners();
  }

  late List<ProductAvailabilityReportModel> _productAvailabilityProductQtyList = [];
  List<ProductAvailabilityReportModel> get productAvailabilityProductQtyList => _productAvailabilityProductQtyList;
  set setProductAvailabilityQty(List<ProductAvailabilityReportModel> value) {
    _productAvailabilityProductQtyList = value;
    notifyListeners();
  }


  late ProductAvailabilityReportModel _selectedGlDesc = ProductAvailabilityReportModel.fromJson({});
  ProductAvailabilityReportModel get selectedGlDesc => _selectedGlDesc;
  set getSelectedGlDesc(ProductAvailabilityReportModel value) {
    _selectedGlDesc = value;
    notifyListeners();
  }
  late ProductAvailabilityReportModel _selectedProduct = ProductAvailabilityReportModel.fromJson({});
  ProductAvailabilityReportModel get selectedProduct => _selectedProduct;
  set getSelectedProduct(ProductAvailabilityReportModel value) {
    _selectedProduct = value;
    notifyListeners();
  }

 late QuickOrderState quickOrderState;

  getGlDescInfoState() {
    quickOrderState = Provider.of<QuickOrderState>(context, listen: false);
  }

  getDataListFromAPI() async {
    getLoading = true;
    ProductAvailabilityResponse dataModel = await ProductAvailabilityAPI.getData(
      dbName: _companyDetail.databaseName,
      gLdesc: await GetAllPref.getOutLetName(),
      pDesc: await GetAllPref.getProductName(),
    );
    if (dataModel.statusCode == 200) {
      await onSuccess(data: dataModel.data);
    } else {
      getLoading = false;
    }
    notifyListeners();
  }

  onSuccess({required List<ProductAvailabilityReportModel> data}) async {
    await ProductAvailabilityReportDatabase.instance.deleteData();
    for (var element in data) {
      await ProductAvailabilityReportDatabase.instance.insertData(element);
    }
    await getOutletListFromDatabase();
    //
    notifyListeners();
  }

  getOutletListFromDatabase() async {
    await ProductAvailabilityReportDatabase.instance.getGlDescInfo().then((value) {
      getGlDescList = value;
    });
    getLoading = false;
    notifyListeners();
  }

  late double _totalBalance = 0.00;
  double get totalBalance => _totalBalance;
  set getTotalBalance(double value) {
    _totalBalance = 0.00;
    _totalBalance = value;
    notifyListeners();
  }

  double totalQty = 0.0;
  double totalQty1 = 0.0;
  double  qty1 = 0.0;
  double  qty2 = 0.0;
  total() {
     qty1 = 0.0;
     qty2 = 0.0;
    for (int i = 0; i < productAvailabilityReportList.length; i++) {
      qty1 = double.parse(productAvailabilityReportList[i].qty);
      qty2 = double.parse(productAvailabilityReportList[i].qty);
      totalQty1 = qty1 - qty2;
    }
    getTotalBalance = qty1 - qty2;
   // Fluttertoast.showToast(msg: totalQty1.toString());
      notifyListeners();
    }



  ///
  onSelectedGlDesc(String glDesc) async {


    await ProductAvailabilityReportDatabase.instance
        .getProduct(glCode: _selectedGlDesc.glCode)
        .then((value) {
      setProductAvailabilityReport = value;
    });
    await total();
    navigator.push(
      MaterialPageRoute(
        builder: (context) =>  ProductAvailabilityDetailsScreen(glDesc:glDesc),
      ),
    );
    notifyListeners();
  }

  onSelectedProduct(String pDesc) async {
    _productAvailabilityProductQtyList = [];
    await ProductAvailabilityReportDatabase.instance
        .getProductListByPCode(pCode: _selectedProduct.pCode)
        .then((value) {
      setProductAvailabilityQty = value;
    });
  //  await total();
    navigator.push(
      MaterialPageRoute(
        builder: (context) =>  ProductAvailabilityProductQtyScreen(pDesc:pDesc),
      ),
    );
    notifyListeners();
  }
}
