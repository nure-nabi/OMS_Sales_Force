import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../service/sharepref/sharepref.dart';
import '../allreports.dart';

class SalesHistoryState extends ChangeNotifier {
  SalesHistoryState();

  late BuildContext _context;
  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(_context);
  set getContext(BuildContext value) {
    _context = value;

    ///
    init();
  }

  late bool _isLoading;
  bool get isLoading => _isLoading;
  set getLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});
  CompanyDetailsModel get companyDetail => _companyDetail;
  set getCompanyDetail(CompanyDetailsModel value) {
    _companyDetail = value;
    notifyListeners();
  }

  late int _totalQty = 0;
  int get totalQty => _totalQty;
  set getTotalQty(int value) {
    _totalQty = value;
    notifyListeners();
  }

  init() async {
    await clear();
    await getOutletInfoState();

    await getAPICall();
  }

  late ProductState productState;
  getOutletInfoState() {
    productState = Provider.of<ProductState>(context, listen: false);
  }

  clear() async {
    _isLoading = false;
    _companyDetail = await GetAllPref.companyDetail();

    _dataList = [];

    _totalQty = 0;
  }

  getAPICall() async {
    getLoading = true;
    SalesHistoryModel reportModel = await SalesHistoryAPI.apiCall(
      databaseName: _companyDetail.databaseName,
      agentCode: _companyDetail.agentCode,
      glcode: productState.outletDetail.glCode,
    );

    if (reportModel.statusCode == 200) {
      await onSuccess(data: reportModel.dataList);
    } else {
      getLoading = false;
    }
    notifyListeners();
  }

  late List<SalesHistoryDataModel> _dataList = [];
  List<SalesHistoryDataModel> get dataList => _dataList;
  set getDataList(List<SalesHistoryDataModel> value) {
    _dataList = value;
    notifyListeners();
  }

  onSuccess({required List<SalesHistoryDataModel> data}) async {
    for (var element in data) {
      CustomLog.actionLog(value: "QTY => ${element.qty}");
      _totalQty += int.parse(element.qty);
    }
    getDataList = data;

    getLoading = false;
    notifyListeners();
  }
}
