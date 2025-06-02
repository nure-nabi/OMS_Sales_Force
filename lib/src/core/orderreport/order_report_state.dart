import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:oms_salesforce/src/core/orderreport/api/order_report_api.dart';
import 'package:oms_salesforce/src/utils/show_toast.dart';
import 'package:provider/provider.dart';

import '../../../model/model.dart';
import '../../service/sharepref/sharepref.dart';
import '../datepicker/date_picker_state.dart';
import '../login/login.dart';
import 'db/order_report_db.dart';
import 'model/order_report_model.dart';

class OrderReportState extends ChangeNotifier {
  OrderReportState();

  late BuildContext _context;
  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(_context);
  set context(BuildContext value) {
    _context = value;

    ///
    init();
  }

  late bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  init() async {
    await clean();
    await showReportLastSevenDays();
  //  await getOrderReportFromReport();

   // if(await GetAllPref.getWhenHaveListDbPending()){
   //   getDateWiseReport();
  //  }else{
      await getOrderReportFromReport();
  //  }
  }

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});
  CompanyDetailsModel get companyDetail => _companyDetail;

  clean() async {
    _isLoading = false;
    _orderList.clear();
    _companyDetail = await GetAllPref.companyDetail();
    setDateValue = false;
    showReportLastSevenDays();
  }
  bool _dateMap = false;
  bool get dateMap => _dateMap;

  set setDateValue(bool value){
    _dateMap = value;
    notifyListeners();
  }
  showReportLastSevenDays() async{
    DateTime now = DateTime.now();
    DateTime sevenDaysLater = now.add(const Duration(days: -7));
    String currentTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String currentTime2 = DateFormat('yyyy-MM-dd').format(sevenDaysLater);
    if(!dateMap) {
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

  late List<OrderReportDataModel> _dateList = [];
  List<OrderReportDataModel> get dateList => _dateList;
  set getDataList(List<OrderReportDataModel> value) {
    _dateList = value;
    notifyListeners();
  }
  onDatePickerConfirm() async {
    getFromDate = Provider.of<DatePickerState>(context, listen: false).fromDate;
    getToDate = Provider.of<DatePickerState>(context, listen: false).toDate;
    await getDateWiseReport().whenComplete(() {
      Navigator.pop(context);
    });
    notifyListeners();
  }

  // Group the data
  late List<OrderReportDataModel> _orderList = [];
  List<OrderReportDataModel> get orderList => _orderList;
  set orderList(List<OrderReportDataModel> value) {
    _orderList = value;
    notifyListeners();
  }

  getOrderReportFromReport() async {
    isLoading = true;
    OrderReportModel model = await OrderReportAPI.getOrderReport(
      dbName: _companyDetail.databaseName,
      glCode: "",
      agentCode: _companyDetail.agentCode,
      //glCode: _companyDetail.userCode,
    );
    if (model.statusCode == 200) {
     // orderList = model.data;
       await onSuccess(data:model.data);
      // _orderList = groupDataByGlcode(model.data);
       print(model.data.toString());
      isLoading = false;
    } else {
      isLoading = false;
    }
    notifyListeners();
  }
  onSuccess({required List<OrderReportDataModel> data}) async {
    await OrderReportDatabase1.instance.deleteData();
    for (var element in data) {
      await OrderReportDatabase1.instance.insertData(element);
    }
   // await getDateWiseReport();
    await getDateListFromDataBase();

    notifyListeners();
  }
  getDateListFromDataBase() async {
    await OrderReportDatabase1.instance.getDateList().then((value) {
      orderList = value;
    });
    isLoading = false;
    notifyListeners();
  }

  getDateWiseReport() async {
    isLoading = true;
    await OrderReportDatabase1.instance.getDateWiseList(fromDate: fromDate,toDate: toDate).then((value) {
      orderList = value;
    });
    await SetAllPref.setWhenHaveListDbPending(value: true);
    isLoading = false;
    notifyListeners();
  }

  updatePendingVerifyList({required String vNo}) async {
    isLoading = true;
    BasicModel model = await OrderReportAPI.updatePendingOrder(
      dbName: _companyDetail.databaseName,
      vNo: vNo,
      userCode: _companyDetail.userCode,
    );

    if (model.statusCode == 200) {
      ShowToast.successToast(msg: model.message);
      await getOrderReportFromReport();
    } else {
      isLoading = false;
    }
    notifyListeners();
  }
}

