import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:oms_salesforce/src/core/productorder/productorder.dart';
import 'package:oms_salesforce/src/core/savemovement/savemovement.dart';
import 'package:oms_salesforce/src/service/database/database.dart';
import 'package:oms_salesforce/src/service/router/router.dart';
import 'package:oms_salesforce/src/service/sharepref/sharepref.dart';
import 'package:oms_salesforce/src/utils/custom_log.dart';
import 'package:provider/provider.dart';

class HomeState extends ChangeNotifier {
  late bool isLoading = false;

  HomeState();

  late BuildContext _context;
  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(_context);
  set getContext(BuildContext value) {
    _context = value;

    ///
    init();
  }

  init() async {
    await clear();
  }

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});
  CompanyDetailsModel get companyDetail => _companyDetail;

  clear() async {
    isLoading = false;
    _companyDetail = await GetAllPref.companyDetail();

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

  set getLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  logOut(context) async {
    await SharedPref.removeData(key: PrefText.loginSuccess, type: "bool");
    await SharedPref.removeData(key: PrefText.companySelected, type: "bool");
    await SharedPref.removeData(key: PrefText.smartOrderOption, type: "bool");
    await SharedPref.removeData(key: PrefText.userName, type: "String");
    await SharedPref.removeData(key: PrefText.companyDetail, type: "String");
    await DatabaseHelper.instance.onDropDatabase();
    await refreshPageToLogIn(context);
  }

  clearSharePref(context) async {
    await SharedPref.removeAllData(context);
    await logOut(context);

    // await refreshPageToLogIn(context);
  }

  refreshPageToLogIn(context) async {
    Navigator.of(context).pushNamedAndRemoveUntil(splashPath, (route) => false);
  }

  late ProductOrderState produtOrderState;
  late SaveMovementState saveMovementState;

  stateCall() {
    produtOrderState = Provider.of<ProductOrderState>(_context, listen: false);
    saveMovementState = Provider.of<SaveMovementState>(_context, listen: false);
    notifyListeners();
  }

  uploadButton() async {
    context
        .read<SaveMovementState>().saveMovementToDatabase(message: 'Location Sync');
    await stateCall();
    getLoading = true;

    ///
    CustomLog.actionLog(value: "Upload");
    await produtOrderState.productOrderAPICall();

    await saveMovementState.postMovementToServer();

    ///
    getLoading = false;
    notifyListeners();
  }

  ///
  ///

  downloadButton() async {
    CustomLog.actionLog(value: "Download");

    // ShowAlert(context).alert(
    //   child: ConfirmationWidget(
    //     title: "CONFIRMATION",
    //     description: "adasdasdasdas",
    //     hideButton: true,
    //     onConfirm: () {},
    //   ),
    // );

    ///
    notifyListeners();
  }
}
