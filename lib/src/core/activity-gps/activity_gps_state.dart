import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/login/login.dart';

class ActivityGPSState extends ChangeNotifier {
  ActivityGPSState();

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

  init() async {
    await clear();
  }

  clear() async {}

  getActivityFromAPI() async {
    // ActivityGPSAPI
  }
}
