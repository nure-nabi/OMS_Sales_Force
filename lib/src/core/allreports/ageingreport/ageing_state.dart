import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:provider/provider.dart';

import '../../../service/sharepref/sharepref.dart';
import '../model/ageing_model.dart';
import '../apis/aging_api.dart';

class AgingState extends ChangeNotifier {
  AgingState();

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

  late double _thirtyDaysTotal = 0.00,
      _sixtyDaysTotal = 0.00,
      _nintyDaysTotal = 0.00;
  late double _overNintyDaysTotal = 0.00, _totalBalance = 0.00;
  double get thirtyDaysTotal => _thirtyDaysTotal;
  double get sixtyDaysTotal => _sixtyDaysTotal;
  double get nintyDaysTotal => _nintyDaysTotal;
  double get overNintyDaysTotal => _overNintyDaysTotal;
  double get totalBalance => _totalBalance;
  //
  set getThirtyDaysTotal(double value) {
    _thirtyDaysTotal = value;
    notifyListeners();
  }

  set getSixtyDaysTotal(double value) {
    _sixtyDaysTotal = value;
    notifyListeners();
  }

  set getNintyDaysTotal(double value) {
    _nintyDaysTotal = value;
    notifyListeners();
  }

  set getOverNintyDaysTotal(double value) {
    _overNintyDaysTotal = value;
    notifyListeners();
  }

  set getTotalBalance(double value) {
    _totalBalance = value;
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

    _thirtyDaysTotal = 0.00;
    _sixtyDaysTotal = 0.00;
    _nintyDaysTotal = 0.00;
    _overNintyDaysTotal = 0.00;
    _totalBalance = 0.00;
  }

  getAPICall() async {
    getLoading = true;
    AgeingModel reportModel = await AgingReportAPI.apiCall(
      databaseName: _companyDetail.databaseName,
      agentCode: _companyDetail.agentCode,
      glcode: productState.outletDetail.glCode,
    );

    if (reportModel.statusCode == 200) {
      await onSuccess(data: reportModel.dataList);
      getLoading = false;
    } else {
      getLoading = false;
    }
    notifyListeners();
  }

  onSuccess({required List<AgeingDataModel> data}) async {
    for (var element in data) {
      ///
      _thirtyDaysTotal += double.parse(element.the30Days);
      _sixtyDaysTotal += double.parse(element.the60Days);
      _nintyDaysTotal += double.parse(element.the90Days);
      _overNintyDaysTotal += double.parse(element.over90Days);
    }

    getTotalBalance = (_thirtyDaysTotal +
        _sixtyDaysTotal +
        _nintyDaysTotal +
        _overNintyDaysTotal);

    notifyListeners();
  }
}
