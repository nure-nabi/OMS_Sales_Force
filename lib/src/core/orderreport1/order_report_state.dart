import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/pdf/bill_pdf.dart';
import 'package:oms_salesforce/src/utils/show_toast.dart';
import 'package:provider/provider.dart';
import '../../../model/model.dart';
import '../../service/router/route_name.dart';
import '../../service/sharepref/sharepref.dart';
import '../../utils/connection_status.dart';
import '../login/login.dart';
import 'datePicker/datePicker.dart';
import 'model/order_report_model.dart';
import 'order_report.dart';

class OrderReportState extends ChangeNotifier {
  OrderReportState();

  late BuildContext _context;

  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(_context);

  set getContext(BuildContext value) {
    _context = value;

    init();
  }

  init() async {
    await clean();
    await checkConnection();
  }

  clean() async {
    _isLoading = false;
    _dateList = [];
    _companyDetail = await GetAllPref.companyDetail();
     _outletList = [];
    // _dateWiseList = [];
     _outletList1 = [];
  }

  late bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});

  CompanyDetailsModel get companyDetail => _companyDetail;

  set getCompanyDetail(CompanyDetailsModel value) {
    _companyDetail = value;
    notifyListeners();
  }

  checkConnection() async {
    CheckNetwork.check().then((network) async {
      getCompanyDetail = await GetAllPref.companyDetail();
      if (network) {
        await networkSuccess();
      } else {
        await getLedgerDateWiseFromDB(fromDate, toDate);
      }
    });
  }

  networkSuccess() async {
    isLoading = true;
    await getLedgerDateWiseFromDB(fromDate, toDate);
    if(dateWiseList.isNotEmpty){
      await getLedgerDateWiseFromDB(fromDate, toDate);
    }else{
      await getOrderReportFromReport();
    }
    isLoading = false;
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
      agentcode: _companyDetail.agentCode,
    );

    if (model.statusCode == 200) {
      //orderList = model.data;
      await onSuccess(dataModel: model.data);
      isLoading = false;
    } else {
      orderList = [];
      isLoading = false;
    }
    notifyListeners();
  }

  onSuccess({required List<OrderReportDataModel> dataModel}) async {
    await OrderReportDatabase.instance.deleteData();
    for (var element in dataModel) {
      await OrderReportDatabase.instance.insertData(element);
    }

    //  await getDateListFromDataBase();
    await getLedgerDateWiseFromDB(fromDate, toDate);
    notifyListeners();
  }

  late List<OrderReportDataModel> _dateList = [];

  List<OrderReportDataModel> get dateList => _dateList;

  set getDataList(List<OrderReportDataModel> value) {
    _dateList = value;
    notifyListeners();
  }

  late OrderReportDataModel _selectedDate = OrderReportDataModel.fromJson({});

  OrderReportDataModel get selectedDate => _selectedDate;

  set getSelectedDate(OrderReportDataModel value) {
    _selectedDate = value;
    notifyListeners();
  }

  getDateListFromDataBase() async {
    await OrderReportDatabase.instance.getDateList().then((value) {
      getDataList = value;
    });
    isLoading = false;
    notifyListeners();
  }

  late List<OrderReportDataModel> _outletList = [];

  List<OrderReportDataModel> get outletList => _outletList;

  set getOutletList(List<OrderReportDataModel> value) {
    _outletList = value;
    notifyListeners();
  }

  getOutletListFilterByDate() async {
    await OrderReportDatabase.instance
        .getOutletListFilterByDate(englishDate: _selectedDate.vDate)
        .then((value) {
      getOutletList = value;
      totalAmount();
    });
    totalAmount();
    // isLoading = false;
    notifyListeners();
  }

  onDateSelected() async {
    await getOutletListFilterByDate();
    navigator.pushNamed(orderOutletScreen);
  }

  late OrderReportDataModel _selectedVno = OrderReportDataModel.fromJson({});

  OrderReportDataModel get selectedVno => _selectedVno;

  set getSelectedVno(OrderReportDataModel value) {
    _selectedVno = value;
    notifyListeners();
  }

  late List<OrderReportDataModel> _outletList1 = [];

  List<OrderReportDataModel> get outletList1 => _outletList1;

  set getOutletList1(List<OrderReportDataModel> value) {
    _outletList1 = value;
    notifyListeners();
  }

  getVnoListFilter() async {
    await OrderReportDatabase.instance
        .getFilterBillList(vno: _selectedVno.vNo)
        .then((value) {
      getOutletList1 = value;
    });
    isLoading = false;
    notifyListeners();
  }

  onVoucherSelected() async {
    await getVnoListFilter();
    navigator.pushNamed(orderBillScreen);
  }

  onDatePickerConfirm() async {
    getFromDate =
        Provider.of<DatePickerState1>(context, listen: false).fromDate;
    getToDate = Provider.of<DatePickerState1>(context, listen: false).toDate;
    getLedgerDateWiseFromDB("", "");
    notifyListeners();
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

  getLedgerDateWiseFromDB(
      String fromDate1,
      String toDate1,
      ) async {
    await OrderReportDatabase.instance
        .getDateWiseList(fromDate: fromDate, toDate: toDate)
        .then((value) {
      toDate = "";
      fromDate = "";
      getDateWiseList = value;
    });
    notifyListeners();
  }

  late List<OrderReportDataModel> _dateWiseList = [];

  List<OrderReportDataModel> get dateWiseList => _dateWiseList;

  set getDateWiseList(List<OrderReportDataModel> value) {
    _dateWiseList = value;
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

  double netAmt = 0.0;
  totalAmount(){
    netAmt = 0.0;
    for(var value in outletList){
      netAmt += double.parse(value.netAmt);
    }
    notifyListeners();
  }

  onPrint() async {
    for (var value in outletList1) {
      final pdfFile = await OrderReportPdf.generate(
        companyDetails: _companyDetail,
        vNo: value.vNo,
        date: value.vDate,
        salesman: value.salesman,
        mobile: value.mobile,
        currentBalance: value.currentBalance,
        creditLimit: value.creditLimite,
        overLimit: value.overLimit,
        creditDays: value.creditDay.toDouble(),
        overDays: value.overdays.toDouble(),
        ageOfOrder: value.ageOfOrder.toDouble(),
        glDesc: value.glDesc,
        route: value.route,
        netAmt: value.netAmt,
        remarks: value.remarks,
        reconcileBy: value.reconcileBy,
      );
      FileHandleApi.openFile(pdfFile);
    }
    notifyListeners();
  }
}
