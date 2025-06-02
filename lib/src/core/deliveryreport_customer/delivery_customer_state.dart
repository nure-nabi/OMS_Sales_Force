import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/service/router/router.dart';
import 'package:provider/provider.dart';

import '../../service/sharepref/sharepref.dart';
import '../datepicker/date_picker_state.dart';
import '../deliveryreport/deliveryreport.dart';
import 'deliveryreport.dart';


class DeliveryCustomerState extends ChangeNotifier {
  DeliveryCustomerState();

  late BuildContext _context;
  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(_context);
  set getContext(BuildContext value) {
    _context = value;

    ///
    init();
  }

  showReportLastSevenDays() async{
    DateTime now = DateTime.now();
    DateTime sevenDaysLater = now.add(const Duration(days: -7));
    String currentTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String currentTime2 = DateFormat('yyyy-MM-dd').format(sevenDaysLater);
    if(!dateMap) {
      getFromDate = currentTime2;
      getToDate = currentTime;
    }else{
      getFromDate = currentTime2;
      getToDate = currentTime;
    }
  }

  String toDate = "";
  String fromDate = "";
  set getFromDate(String value) {
    fromDate = value.replaceAll("/", "-");
    notifyListeners();
  }

  set getToDate(String value) {
    toDate = value.replaceAll("/", "-");
    notifyListeners();
  }
  onDatePickerConfirm() async {
    getDataList = [];
    getFromDate = Provider.of<DatePickerState>(context, listen: false).fromDate;
    getToDate = Provider.of<DatePickerState>(context, listen: false).toDate;
    await getDateWiseReport().whenComplete(() {
      Navigator.pop(context);
    });
    notifyListeners();
  }

  late bool _isLoading = false;
  bool get isLoading => _isLoading;
  set getLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  late bool _isFromIndex = true;
  bool get isFromIndex => _isFromIndex;
  set getIsFromIndex(bool value) {
    _isFromIndex = value;
    notifyListeners();
  }

  bool _dateMap = false;
  bool get dateMap => _dateMap;

  set setDateValue(bool value){
    _dateMap = value;
    notifyListeners();
  }

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});
  CompanyDetailsModel get companyDetail => _companyDetail;
  set getCompanyDetail(CompanyDetailsModel value) {
    _companyDetail = value;
    notifyListeners();
  }

  late ProductState productState;
  getOutletInfoState() {
    productState = Provider.of<ProductState>(context, listen: false);
  }

  init() async {
    await clear();
   // await showReportLastSevenDays();
    await getOutletInfoState();
    // if(await GetAllPref.getWhenHaveListDb()){
    //   getDateWiseReport();
    // }else{
    //   await getAPICall();
    //
    // }
    getFromDate = "";
    getToDate ="";
    await getAPICall();
  }

  clear() async {
    _isLoading = false;
    _dateList.clear();
    _companyDetail = await GetAllPref.companyDetail();
  }
//9801064780
  getAPICall() async {

    getLoading = true;
   DeliveryReportReqModel reportModel = await DeliveryReportCustomerAPI.apiCall(
      dbName: _companyDetail.databaseName,
      brCode: "",
      unitCode: "",
      module: "",
      userCode: '',
      glCode:    productState.outletDetail.glCode,
     // glCode: _isFromIndex ? "" : productState.outletDetail.glCode,
      agentCode: "",
    );

    if (reportModel.statusCode == 200) {
      await onSuccess(data: reportModel.data);
      getLoading = false;
    } else {
      getLoading = false;
    }
    notifyListeners();
  }

  late List<DeliveryReportCustomerDataModel> _dateList = [];
  List<DeliveryReportCustomerDataModel> get dateList => _dateList;
  set getDataList(List<DeliveryReportCustomerDataModel> value) {
    _dateList = value;
    notifyListeners();
  }

  late DeliveryReportCustomerDataModel _selectedDate = DeliveryReportCustomerDataModel.fromJson({});
  DeliveryReportCustomerDataModel get selectedDate => _selectedDate;
  set getSelectedDate(DeliveryReportCustomerDataModel value) {
    _selectedDate = value;
    notifyListeners();
  }

  onSuccess({required List<DeliveryReportCustomerDataModel> data}) async {
    await DeliveryReportCustomerDatabase.instance.deleteData();
    for (var element in data) {
      await DeliveryReportCustomerDatabase.instance.insertData(element);
    }
   // await getDateWiseReport();
    await getDateListFromDataBase();
    notifyListeners();
  }

  getDateListFromDataBase() async {
    await DeliveryReportCustomerDatabase.instance.getDateList().then((value) {
      getDataList = value;
    });
   // await SetAllPref.setWhenHaveListDb(value: true);
    getLoading = false;
    notifyListeners();
  }

  getDateWiseReport() async {
   await DeliveryReportCustomerDatabase.instance.getDateWiseList(fromDate: fromDate,toDate: toDate).then((value) {
    getDataList = value;
    });
   await SetAllPref.setWhenHaveListDb(value: true);
   getLoading = false;
    notifyListeners();
  }

  late List<DeliveryReportCustomerDataModel> _outletList = [];
  List<DeliveryReportCustomerDataModel> get outletList => _outletList;
  set getOutletList(List<DeliveryReportCustomerDataModel> value) {
    _outletList = value;
    notifyListeners();
  }
  getOutletListFilterByDate() async {
    await DeliveryReportCustomerDatabase.instance
        .getOutletListFilterByDate(englishDate: _selectedDate.vDate)
        .then((value) {
      getOutletList = value;
    });
    totalAmount();
    // getLoading = false;
    notifyListeners();
  }
  double netAmt = 0.0;
  totalAmount(){
     netAmt = 0.0;
    for(var value in outletList){
      netAmt += double.parse(value.netAmount);
    }
    notifyListeners();
  }

  onDateSelected() async {
    // if (_isFromIndex) {
    await getOutletListFilterByDate();
    navigator.pushNamed(deliveryOutletSectionPath);
   //  }
  }
}
