import 'package:flutter/material.dart';
import 'package:oms_salesforce/model/model.dart';
import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:oms_salesforce/src/service/sharepref/sharepref.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:provider/provider.dart';

import '../products/products.dart';
import 'leavenotes_api.dart';
import 'model/leave_report_model.dart';
import 'model/leave_type_model.dart';

class LeaveNotesState extends ChangeNotifier {
  LeaveNotesState();

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

  late bool _typeLoading;
  bool get typeLoading => _typeLoading;
  set getTypeLoading(bool value) {
    _typeLoading = value;
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
    await getOutletInfoState();

    await Future.wait([
      getLeaveType(),
      getLeaveReportFromRemote(),
    ]);
  }

  late ProductState productState;
  getOutletInfoState() {
    productState = Provider.of<ProductState>(context, listen: false);
  }

  late TextEditingController _reason = TextEditingController(text: ""),
      _fromDate = TextEditingController(text: ""),
      _toDate = TextEditingController(text: "");
  TextEditingController get reason => _reason;
  TextEditingController get fromDate => _fromDate;
  TextEditingController get toDate => _toDate;

  set getFromDate(String value) {
    _fromDate.text = value;
    calculateDays();
    notifyListeners();
  }

  set getToDate(String value) {
    _toDate.text = value;
    calculateDays();
    notifyListeners();
  }

  calculateDays() async {
    getDaysCount = MyDate.nepaliDaysCount(
      fromDate: _fromDate.text,
      toDate: _toDate.text,
    );
    notifyListeners();
  }

  clear() async {
    _typeLoading = false;
    _isLoading = false;
    _companyDetail = await GetAllPref.companyDetail();
    _reason = TextEditingController(text: "");
    _fromDate = TextEditingController(text: "");
    _toDate = TextEditingController(text: "");

    _daysCount = 0;

    _typeDetails = LeaveTypeDataModel.fromJson({});
  }

  late int _daysCount = 0;
  int get daysCount => _daysCount;
  set getDaysCount(int value) {
    _daysCount = value + 1;

    CustomLog.warningLog(value: "DAYS COUNT => $daysCount");
    notifyListeners();
  }

  late LeaveTypeDataModel _typeDetails = LeaveTypeDataModel.fromJson({});
  LeaveTypeDataModel get typeDetails => _typeDetails;
  set getTypeDetails(LeaveTypeDataModel value) {
    _typeDetails = value;
    notifyListeners();
  }

  late List<LeaveTypeDataModel> _typeList = [];
  List<LeaveTypeDataModel> get typeList => _typeList;
  set getTypeList(List<LeaveTypeDataModel> value) {
    _typeList = [];
    _typeList = value;
    notifyListeners();
  }

  Future getLeaveType() async {
    getTypeLoading = true;
    LeaveTypeModel typeModel = await LeaveNotesAPI.getLeaveType(
      databaseName: _companyDetail.databaseName,
      agentCode: _companyDetail.agentCode,
    );
    if (typeModel.statusCode == 200) {
      getTypeList = typeModel.data;
      getTypeLoading = false;
    } else {
      getTypeLoading = false;
    }

    ///

    notifyListeners();
  }

  postLeave() async {
    getLoading = true;
    BasicModel modelData = await LeaveNotesAPI.createLeaveNotes(
      databaseName: _companyDetail.databaseName,
      agentCode: _companyDetail.agentCode,
      dateFrom: MyTimeConverter.convertDateToTimeStamp(
        date: _fromDate.text.trim(),
      ),
      dateTo: MyTimeConverter.convertDateToTimeStamp(
        date: _toDate.text.trim(),
      ),
      noOfDays: "$_daysCount",
      leaveTypeId: "${_typeDetails.leaveid}",
      reason: _reason.text.trim(),
      memo: "",
    );
    if (modelData.statusCode == 200) {
      // getTypeList = typeModel.data;
      getLoading = false;
      navigator.pop();
      ShowToast.successToast(msg: "Success");
    } else {
      getLoading = false;
      ShowToast.errorToast(msg: "Error");
    }
    await clear();

    ///

    notifyListeners();
  }

  ///
  ///
  late List<LeaveReportDataModel> _reportList = [];
  List<LeaveReportDataModel> get reportList => _reportList;
  set reportList(List<LeaveReportDataModel> value) {
    _reportList = [];
    _reportList = value;
    notifyListeners();
  }

  Future getLeaveReportFromRemote() async {
    getLoading = true;
    LeaveReportModel typeModel = await LeaveNotesAPI.getLeaveReport(
      databaseName: _companyDetail.databaseName,
      agentCode: _companyDetail.agentCode,
    );
    if (typeModel.statusCode == 200) {
      reportList = typeModel.data;
      updateListToggleValue();
      getLoading = false;
    } else {
      getLoading = false;
    }

    ///

    notifyListeners();
  }

  late List<bool> _isShowItemBuilder = [];
  List<bool> get isShowItemBuilder => _isShowItemBuilder;

  updateListToggleValue() {
    _isShowItemBuilder = List.generate(
      reportList.length,
      (index) => false,
    );
    notifyListeners();
  }

  ///
  ///
}
