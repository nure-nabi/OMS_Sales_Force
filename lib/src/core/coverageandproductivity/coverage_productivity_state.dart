import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/coverageandproductivity/coverageandproductivity.dart';

import '../../service/sharepref/sharepref.dart';
import '../login/login.dart';

class CoverageProductivityState extends ChangeNotifier {
  CoverageProductivityState();

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
    await clean();
    await getReportFromAPI();
  }

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});
  CompanyDetailsModel get companyDetail => _companyDetail;
  set getCompanyDetail(CompanyDetailsModel value) {
    _companyDetail = value;
    notifyListeners();
  }

  clean() async {
    _isLoading = false;
    _reportList = [];

    getCompanyDetail = await GetAllPref.companyDetail();
  }

  late List<CoverageProductivityDataModel> _reportList = [];
  List<CoverageProductivityDataModel> get reportList => _reportList;
  set getReportList(List<CoverageProductivityDataModel> value) {
    _reportList = value;
    notifyListeners();
  }

  getReportFromAPI() async {
    getLoading = true;
    CoverageProductivityModel modelData = await CoverageProductivityAPI.apiCall(
      databaseName: _companyDetail.databaseName,
      agentCode: _companyDetail.agentCode,
    );

    if (modelData.statusCode == 200) {
      getReportList = modelData.data;
      getLoading = false;
    } else {
      getLoading = false;
    }

    notifyListeners();
  }
}
