import 'package:flutter/material.dart';

import '../../service/sharepref/sharepref.dart';
import '../login/login.dart';
import 'model/target_achivement_model.dart';
import 'target_achivement_api.dart';

class TargetAndAchivementState extends ChangeNotifier {
  TargetAndAchivementState();

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
    _isShowItemBuilder = [];

    getCompanyDetail = await GetAllPref.companyDetail();
  }

  late List<TargetAndAchivementDataModel> _reportList = [];
  List<TargetAndAchivementDataModel> get reportList => _reportList;
  set getReportList(List<TargetAndAchivementDataModel> value) {
    _reportList = value;
    notifyListeners();
  }

  getReportFromAPI() async {
    getLoading = true;
    TargetAndAchivementModel modelData = await TargetAndAchivementAPI.apiCall(
      databaseName: _companyDetail.databaseName,
      agentCode: _companyDetail.agentCode,
      // agentCode: "6",
    );

    if (modelData.statusCode == 200) {
      getReportList = modelData.data;
      await updateListToggleValue();
      getLoading = false;
    } else {
      getLoading = false;
    }

    notifyListeners();
  }

  late List<bool> _isShowItemBuilder = [];
  List<bool> get isShowItemBuilder => _isShowItemBuilder;

  updateListToggleValue() {
    _isShowItemBuilder = List.generate(reportList.length, (index) => false);
    notifyListeners();
  }

  getAchivePercentQty({required String achieveQty, required String targetQty}) {
    double value = (double.parse(achieveQty) / double.parse(targetQty)) * 100;
    if ("$value" == "Infinity" || "$value" == "NaN") {
      return "0.00";
    }
    return value.toStringAsFixed(2);
  }

  getAchivePercentAmt({required String achieveAmt, required String targetAmt}) {
    double value = (double.parse(achieveAmt) / double.parse(targetAmt)) * 100;
    if ("$value" == "Infinity" || "$value" == "NaN") {
      return "0.00";
    }
    return value.toStringAsFixed(2);
  }
}
