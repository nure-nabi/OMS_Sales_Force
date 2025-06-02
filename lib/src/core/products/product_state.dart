import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/core/quickorder/quickorder.dart';
import 'package:oms_salesforce/src/service/router/router.dart';
import 'package:oms_salesforce/src/service/sharepref/sharepref.dart';
import 'package:oms_salesforce/src/utils/utils.dart';

class ProductState extends ChangeNotifier {
  ProductState();

  late BuildContext _context;

  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(_context);

  set getContext(BuildContext value) {
    _context = value;

    ///
    init();
  }

  late FilterOutletInfoModel _outletDetail = FilterOutletInfoModel.fromJson({});

  FilterOutletInfoModel get outletDetail => _outletDetail;

  set getOutletDetail(FilterOutletInfoModel value) {
    _outletDetail = value;
  }

  init() async {
    await clear();
    await checkConnection();
  }

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});

  CompanyDetailsModel get companyDetail => _companyDetail;

  set getCompanyDetail(CompanyDetailsModel value) {
    _companyDetail = value;
    notifyListeners();
  }

  clear() async {
    _isLoading = false;
    _filterGroupList = [];
    _groupList = [];
    _outletDetail = FilterOutletInfoModel.fromJson({});
  }

  late bool _isLoading = false;

  bool get isLoading => _isLoading;

  set getLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  checkConnection() async {
    await getGroupProductListFromDB();
    CheckNetwork.check().then((network) async {
      getCompanyDetail = await GetAllPref.companyDetail();
      if (network) {
        await networkSuccess();
      } else {
        await getGroupProductListFromDB();
      }
    });
  }

  networkSuccess() async {
    ///
   //  await getGroupProductListFromDB();
   // Fluttertoast.showToast(msg:filterGroupList.length.toString());
    getLoading = true;
     if(filterGroupList.isNotEmpty){
       await getGroupProductListFromDB();
     }else{
       await getDataFromAPI();
     }

    getLoading = false;
  }

  set filterProduct(value) {
    _filterProductList = _productList
        .where((product) => (product.pDesc.toLowerCase().contains(value.toLowerCase()) || product.pShortName.toLowerCase().contains(value.toLowerCase())))
        .toList();
    notifyListeners();
  }

  late List<FilterProductModel> _groupList = [], _filterGroupList = [];

  List<FilterProductModel> get groupList => _groupList;

  List<FilterProductModel> get filterGroupList => _filterGroupList;
  late List<FilterProductModel> _productList = [], _filterProductList = [];

  List<FilterProductModel> get productList => _productList;

  List<FilterProductModel> get filterProductList => _filterProductList;

  // check table
  List<ProductGroupModel> _productGroupTableList = [];
   List<ProductGroupModel> get productGroupTableList => _productGroupTableList;

  List<Map<String, dynamic>> _list = [];
  List<Map<String, dynamic>> get listMap => _list;

  set getProductGroupListMap(List<Map<String, dynamic>> value) {
    _list = value;
    notifyListeners();
  }

  set getProductGroupList(List<FilterProductModel> value) {
    _groupList = value;
    _filterGroupList = _groupList;
    notifyListeners();
  }

  set getProductGroupTableList(List<ProductGroupModel> value) {
    _productGroupTableList = value;
    notifyListeners();
  }

  set getFilterProductGroupList(List<FilterProductModel> value) {
    _filterGroupList = value;
    notifyListeners();
  }

  set getProductList(List<FilterProductModel> value) {
    _productList = value;
    _filterProductList = _productList;
    notifyListeners();
  }

  set getFilterProductList(List<FilterProductModel> value) {
    _filterProductList = value;
    notifyListeners();
  }

  getDataFromAPI() async {
    ProductModel productData = await ProductAPI.getProduct(
      agentCode: _companyDetail.agentCode,
      dbName: _companyDetail.databaseName,
     // brCode: await GetAllPref.unitCode() ?? "",
      brCode: "",
      customer: outletDetail.glDesc,
    );
    if (productData.statusCode == 200) {
      await onSuccess(dataModel: productData.data);
    //  getProductGroupTableList = productData.data;
    } else {
      ShowToast.errorToast(msg: "Failed to get data");
    }

    notifyListeners();
  }

  onSuccess({required List<ProductGroupModel> dataModel}) async {
    ///dataModel
    List<FilterProductModel> data = await filterAndArrangeData(
      dataModel: dataModel,
    );
    ///
    await ProductInfoDatabase.instance.deleteDataByGlCode(glCode: _outletDetail.glCode);
    for (var element in data) {
      await ProductInfoDatabase.instance.insertData(element);
    }
    ///
    await getGroupProductListFromDB();

    notifyListeners();
  }

  deleteData() async{
    await ProductInfoDatabase.instance.deleteDataByGlCode(glCode: _outletDetail.glCode);
  }

  getGroupProductListFromDB() async {

    await ProductInfoDatabase.instance
        .getProductGroupData(glCode: _outletDetail.glCode)
        .then((value) {
      getProductGroupList = value;
    });
    notifyListeners();
  }

  set filterProductGroup(value) {
    _filterGroupList = _groupList
        .where((u) => (u.grpDesc.toLowerCase().contains(value.toLowerCase())))
        .toList();
    notifyListeners();
  }

  set filterProductList(value) {
    _filterGroupList = _groupList
        .where((u) => (u.pDesc.toLowerCase().contains(value.toLowerCase())))
        .toList();
    notifyListeners();
  }

  getProductListFromDB({required String groupCode}) async {
    await ProductInfoDatabase.instance
        .getProductList(
            groupCode: groupCode,
            glCode: _outletDetail.glCode,
            outletCode: _outletDetail.outletCode)
        .then((value) {
      getProductList = value;
    });
    CustomLog.actionLog(
      value: "product list value => ${groupCode} ${_outletDetail.glCode} ${_outletDetail.outletCode}",);

    notifyListeners();
  }

  late FilterProductModel _selectedGroup = FilterProductModel.fromJson({});

  FilterProductModel get selectedGroup => _selectedGroup;

  set getSelectedGroup(FilterProductModel value) {
    _selectedGroup = value;
    notifyListeners();
  }

  getProductListAvailablityFromDB({required String groupCode}) async {
    await ProductInfoDatabase.instance
        .getAllProductAvalability(grCode: groupCode
       )
        .then((value) {
      getProductList = value;
    });
    CustomLog.actionLog(
      value: "product list value => ${groupCode} ${_outletDetail.glCode} ${_outletDetail.outletCode}",);

    notifyListeners();
  }

  groupSelected() async {
    await getProductListFromDB(groupCode: _selectedGroup.grpCode);
    navigator.pushNamed(productListPath);
    notifyListeners();
  }

  groupSelectedAvailabality() async {
    await getProductListAvailablityFromDB(groupCode: _selectedGroup.grpCode);
    navigator.pushNamed(productListAvailabilityScreen);
    notifyListeners();
  }

  //ProductListAvailabilityScreen
  /// ========================================== ///
  /// ========================================== ///
  /// ========================================== ///
  ///

  // late bool _isProductAvailable = false;
  // bool get isProductAvailable => _isProductAvailable;
  // set getProductAvailable(bool value) {
  //   _isProductAvailable = value;
  //   notifyListeners();
  // }

  ///
  /// This method is to format the response data get from api
  Future<List<FilterProductModel>> filterAndArrangeData({
    required List<ProductGroupModel> dataModel,
  }) async {
    List<FilterProductModel> filterData = <FilterProductModel>[];
    for (var groupData in dataModel) {
      for (var subGroupData in groupData.productSubGroupList) {
        for (var productDetails in subGroupData.productList) {
          filterData.add(
            FilterProductModel(
              pCode: productDetails.pCode,
              pDesc: productDetails.pDesc,
              pShortName: productDetails.pShortName,
              alias: productDetails.alias,
              mrp: productDetails.mrp,
              tradeRate: productDetails.tradeRate,
              buyRate: productDetails.buyRate,
              salesRate: productDetails.salesRate,
              vat: productDetails.vat,
              dealerPrice: productDetails.dealerPrice,
              exciseRate: productDetails.exciseRate,
              maxStock: productDetails.maxStock,
              discountRate: productDetails.discountRate,
              stockBalance: productDetails.stockBalance,
              unitCode: productDetails.unitCode,
              altQty: productDetails.altQty,
              qty: productDetails.qty,
              unit: productDetails.unit,
              altUnit: productDetails.altUnit,
              scheme: productDetails.scheme,
              ///
              grpCode: groupData.grpCode,
              grpDesc: groupData.grpDesc,

              ///
              glCode: _outletDetail.glCode,
              glDesc: _outletDetail.glDesc,

              ///
              tempPCode: "",
              orderPCode: "",
            ),
          );
        }
      }
    }
    return filterData;
  }
}
