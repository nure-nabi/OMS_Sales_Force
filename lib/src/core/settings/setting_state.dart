import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/service/router/router.dart';
import 'package:oms_salesforce/src/service/sharepref/sharepref.dart';

class SettingState extends ChangeNotifier {
  SettingState();

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
  }

  clean() async {
    _isLoading = false;

    ///
    getIsShowSmartOrder = await GetAllPref.smartOrderOption();

    debugPrint("_isShowSmartOrder => $_isShowSmartOrder");
  }

  late bool _isShowSmartOrder = false;
  bool get isShowSmartOrder => _isShowSmartOrder;
  set getIsShowSmartOrder(bool value) {
    _isShowSmartOrder = value;
    notifyListeners();
  }

  updateSmartOrder() async {
    await SetAllPref.smartOrderOption(value: _isShowSmartOrder);
    notifyListeners();
  }

  ///
  refreshPageToLogIn(context) async {
    await updateSmartOrder();
    Navigator.of(context).pushNamedAndRemoveUntil(splashPath, (route) => false);
  }
}
