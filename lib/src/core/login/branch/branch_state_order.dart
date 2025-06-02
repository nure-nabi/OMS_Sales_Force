import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../service/router/router.dart';
import '../../../service/sharepref/sharepref.dart';
import '../../savemovement/savemovement.dart';
import '../login.dart';

class BranchStateOrder extends ChangeNotifier {
  BranchStateOrder();

  late BuildContext _context;
  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(_context);
  set context(BuildContext value) {
    _context = value;

    ///
    init();
  }

  String? selectedUnit = null;
  late bool _isLoading = false;
  bool get isLoading => _isLoading;

  late bool _selectBranch = false;
  bool get selectBranch => _selectBranch;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set setSelectBranch(bool value) {
    _selectBranch = value;
    notifyListeners();
  }
  init() async {
    await clean();
   // await getBranchListFromRemote();
    await getCompanyBranchList();
  }

  clean() async {
    _isLoading = false;
    setSelectBranch = false;
    getUnitDesc = null;
    _branchList.clear();
    await SetAllPref.branchDetail(value: BranchDataModel.fromJson({}));

    _companyDetail = await GetAllPref.companyDetail();
  }

  late String? _unitDesc = null;
  String?  get unitDesc => _unitDesc;

  late String? _unitCode = null;
  String?  get unitCode => _unitCode;


  set getUnitDesc(String? unitDesc) {
    _unitDesc = unitDesc;
    notifyListeners();
  }

  set getUnitCode(String? unitCode) {
    _unitCode = unitCode;
    notifyListeners();
  }

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});
  CompanyDetailsModel get companyDetail => _companyDetail;
  set getCompanyDetail(CompanyDetailsModel value) {
    _companyDetail = value;
    notifyListeners();
  }

  late List<BranchDataModel> _branchList = [];
  List<BranchDataModel> get branchList => _branchList;
  set branchList(List<BranchDataModel> value) {
    _branchList = value;
    notifyListeners();
  }

  getBranchListFromRemote() async {
    _companyDetail = await GetAllPref.companyDetail();

    ///
    try {
      BranchModel model = await BranchAPI.getAgentBranchList(
        databaseName: _companyDetail.databaseName,
        agentCode: _companyDetail.agentCode,
      );
      if (model.statusCode == 200) {
        branchList = model.data;
      } else {
        branchList = [];
       // navigator.pushReplacementNamed(homePagePath);
      }
    } catch (e) {
      branchList = [];
     // navigator.pushReplacementNamed(homePagePath);
    }

    CustomLog.actionLog(value: "BRANCH STATE ${branchList.isEmpty}");
    notifyListeners();
  }



  getCompanyBranchList() async {
    _companyDetail = await GetAllPref.companyDetail();
    try {
      BranchModel model = await BranchAPI.getCompanyBranch(
        databaseName: _companyDetail.databaseName,
      //  agentCode: _companyDetail.agentCode,
      );
      if (model.statusCode == 200) {
        branchList = model.data;
      } else {
        branchList = [];
        setSelectBranch = true;
       // navigator.pushReplacementNamed(homePagePath);
      }
    } catch (e) {
      branchList = [];
    //  navigator.pushReplacementNamed(homePagePath);
    }

    CustomLog.actionLog(value: "BRANCH STATE ${branchList.isEmpty}");
    notifyListeners();
  }

  userSelectedBranch(BranchDataModel branchInfo) async {
    final saveMovementState = context.read<SaveMovementState>();
    await SetAllPref.branchDetail(value: branchInfo);
    saveMovementState.saveMovementToDatabase(
      message: 'Agent has selected his/her branch successfully',
    );
    navigator.pushReplacementNamed(homePagePath);
    notifyListeners();
  }
}
