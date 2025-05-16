import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:oms_salesforce/src/core/allreports/allreports.dart';
import 'package:oms_salesforce/src/core/datepicker/datepicker.dart';
import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:oms_salesforce/src/core/pdf/pdf.dart';
import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/service/sharepref/sharepref.dart';
import 'package:oms_salesforce/src/utils/custom_log.dart';
import 'package:provider/provider.dart';

import '../../login/branch/branch_state_order.dart';
import '../model/cash_bank_print_model.dart';

class LedgerReportState extends ChangeNotifier {
  LedgerReportState();

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

  late bool _showEnglishDate = false;
  bool get showEnglishDate => _showEnglishDate;
  set getEnglishDate(bool value) {
    // /// [ RE-INITIALIZE the value for avoiding multiple addition in list]
    // _myValue = 0.00;

    _showEnglishDate = value;
    notifyListeners();
  }

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});
  CompanyDetailsModel get companyDetail => _companyDetail;
  set getCompanyDetail(CompanyDetailsModel value) {
    _companyDetail = value;
    notifyListeners();
  }

  late int _totalQty = 0;
  int get totalQty => _totalQty;
  set getTotalQty(int value) {
    _totalQty = value;
    notifyListeners();
  }

  init() async {
    await clear();
    await getOutletInfoState();
    await getAPICall();
  }

  late ProductState productState;
  getOutletInfoState() {
    productState = Provider.of<ProductState>(context, listen: false);
  }

  clear() async {
    toDate =
        NepaliDateTime.now().toString().substring(0, 10).replaceAll("/", "-");
    fromDate = NepaliDateTime.now()
        .subtract(const Duration(days: 7300)) // [ 20 Years ]
        .toString()
        .substring(0, 10)
        .replaceAll("/", "-");

    _isLoading = false;
    _showEnglishDate = false;

    _pdcIncluded = false;

    _companyDetail = await GetAllPref.companyDetail();

    _dataList = [];
    _totalDebit = 0.00;
    _totalCredit = 0.00;
    _totalQty = 0;
  }

  late List<LedgerReportDataModel> _dataList = [];
  List<LedgerReportDataModel> get dataList => _dataList;
  set getDataList(List<LedgerReportDataModel> value) {
    _dataList = value;
    notifyListeners();
  }

  late bool _pdcIncluded = false;
  bool get pdcIncluded => _pdcIncluded;
  set getPdcIncluded(bool value) {
    _pdcIncluded = value;
    notifyListeners();
  }

  getMethodName() async {
    if (_pdcIncluded) {
     await SetAllPref.setBranch(value: "");
      return "ListMobileRepLedgerDetails";
    }
    else {
      return "ListMobileRepLedgerDetailswithoutPDC";
    }
  }
  late BranchStateOrder provider;
  showBranchProvider () {
     provider = Provider.of<BranchStateOrder>(context,listen: false);
  }

  getAPICall() async {
    showBranchProvider();
    getLoading = true;
    getDataList = [];
    LedgerReportModel modelData = await LedgerReportAPI.apiCall(
      databaseName: _companyDetail.databaseName,
      brCode: await GetAllPref.getBranch() ?? "",
      glcode: productState.outletDetail.glCode,
      methodName: await getMethodName(),
    );

    if (modelData.statusCode == 200) {
      //provider.getUnitDesc = null;
     // await SetAllPref.setBranch(value: "");
     // Fluttertoast.showToast(msg: provider.unitDesc!);
      //
    //  getDataList = modelData.data;
      await onSuccess(modelData: modelData.data);
    } else {
      getLoading = false;
    }
    notifyListeners();
  }

  onSuccess({required List<LedgerReportDataModel> modelData}) async {
    await LedgerReportDatabase.instance.deleteData();
    getLoading = false;
    for (var element in modelData) {
      await LedgerReportDatabase.instance.insertData(element);
    }
    ///
    await getDataFromDatabase();
   // await getDataFromDatabaseFirstTime();
    notifyListeners();
  }

  onDatePickerConfirm() async {
    getDataList = [];
    getFromDate = Provider.of<DatePickerState>(context, listen: false).fromDate;
    getToDate = Provider.of<DatePickerState>(context, listen: false).toDate;
    await getDataFromDatabase().whenComplete(() {Navigator.pop(context);
    });
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

  late String _openingBalance = "";
  String get openingBalance => _openingBalance;
  set getOpeningBalance(String value) {
    _openingBalance = value;
    notifyListeners();
  }

  getDataFromDatabaseFirstTime() async {
    double myValue = 0.0;
    await LedgerReportDatabase.instance
        .getOpeningBalance(
            glCode: productState.outletDetail.glCode, fromDate: fromDate)
        .then((value) {
      getOpeningBalance = value;
    });

    myValue = double.parse(_openingBalance);
    await LedgerReportDatabase.instance
        .getAllDataList()
        .then((value) {
      for (var element in value) {
        myValue += double.parse(element.dr) - double.parse(element.cr);
        _dataList.add(
          LedgerReportDataModel(
            vno: element.vno,
            date: element.date,
            miti: element.miti,
            source: element.source,
            dr: element.dr,
            cr: element.cr,
            narration: element.narration,
            remarks: element.remarks,
            total: myValue.toStringAsFixed(2),
          ),
        );
      }
    });
    Fluttertoast.showToast(msg: 'Opening Balance $_openingBalance');
    if (double.parse(_openingBalance) != 0.00) {
      _dataList.insert(
        0,
        LedgerReportDataModel(
          vno: "Balance",
          date: "Opening",
          miti: "Opening",
          source: "",
          dr: "",
          cr: "",
          narration: "",
          remarks: "",
          total: _openingBalance,
        ),
      );
    }

    await LedgerReportDatabase.instance
        .getTotalDebitAmount(glCode: productState.outletDetail.glCode)
        .then((value) {
      getTotalDebit = double.parse(value);
    });
    await LedgerReportDatabase.instance
        .getTotalCreditAmount(glCode: productState.outletDetail.glCode)
        .then((value) {
      getTotalCredit = double.parse(value);
    });

    getLoading = false;
    notifyListeners();
  }

  getDataFromDatabase() async {
    double myValue = 0.0;
    await LedgerReportDatabase.instance
        .getOpeningBalance(
        glCode: productState.outletDetail.glCode, fromDate: fromDate)
        .then((value) {
      getOpeningBalance = value;
    });

    myValue = double.parse(_openingBalance);
    await LedgerReportDatabase.instance
        .getDataList(fromDate: fromDate, toDate: toDate)
        .then((value) {
      for (var element in value) {
        myValue += double.parse(element.dr) - double.parse(element.cr);
        _dataList.add(
          LedgerReportDataModel(
            vno: element.vno,
            date: element.date,
            miti: element.miti,
            source: element.source,
            dr: element.dr,
            cr: element.cr,
            narration: element.narration,
            remarks: element.remarks,
            total: myValue.toStringAsFixed(2),
          ),
        );
      }
    });
    if (double.parse(_openingBalance) != 0.00) {
      _dataList.insert(
        0,
        LedgerReportDataModel(
          vno: "Balance",
          date: "Opening",
          miti: "Opening",
          source: "",
          dr: "",
          cr: "",
          narration: "",
          remarks: "",
          total: _openingBalance,
        ),
      );
    }

    await LedgerReportDatabase.instance
        .getTotalDebitAmount(glCode: productState.outletDetail.glCode)
        .then((value) {
      getTotalDebit = double.parse(value);
    });
    await LedgerReportDatabase.instance
        .getTotalCreditAmount(glCode: productState.outletDetail.glCode)
        .then((value) {
      getTotalCredit = double.parse(value);
    });

    getLoading = false;
    notifyListeners();
  }

  late double _totalDebit = 0.00, _totalCredit = 0.00;
  double get totalDebit => _totalDebit;
  double get totalCredit => _totalCredit;
  set getTotalDebit(double value) {
    _totalDebit = value;
    notifyListeners();
  }

  set getTotalCredit(double value) {
    _totalCredit = value;
    notifyListeners();
  }

  getTotalBalance() {
    return (_totalDebit - _totalCredit).toStringAsFixed(2);
  }

  shareLedger() async {
    CustomLog.log(value: productState.outletDetail.outletDesc);
    await generateInvoice(
      companyDataDetails: _companyDetail,
      ledgerReportList: _dataList,
      clientName: productState.outletDetail.outletDesc,
      totalBalance: getTotalBalance(),
      totalDebit: "$_totalDebit",
      totalCredit: "$_totalCredit",
      fileName: productState.outletDetail.outletDesc,
      showEnglishDate: _showEnglishDate,
    );
  }

  late List<CashBankPrintDataModel> _cashBankDataList = [];
  List<CashBankPrintDataModel> get cashBankDataList => _cashBankDataList;
  set getCashBankDataList(List<CashBankPrintDataModel> value) {
    _cashBankDataList = [];
    _cashBankDataList = value;
    notifyListeners();
  }

  getCashBankPrintFromAPI({required String vno}) async {
    getLoading = true;
    _companyDetail = await GetAllPref.companyDetail();

    CashBankPrintModel reportModel = await LedgerReportAPI.cashBankPrint(
      databaseName: _companyDetail.databaseName,
      vNo: vno,
    );

    // CB-0022

    if (reportModel.statusCode == 200) {
      getCashBankDataList = reportModel.data;
      getLoading = false;
      await onPrint();
    } else {
      getLoading = false;
    }
    notifyListeners();
  }

  onPrint() async {
    for (var value in _cashBankDataList) {
      final pdfFile = await CashBankPdfInvoiceApi.generate(
        companyDetails: _companyDetail,
        billTitleName:
            value.reclocalAmt == 0.00 ? "Payment Voucher" : "Receipt Voucher",
        receivedNo: value.vNo,
        date: value.vmiti,
        receivedFrom: value.detailsLedger,
        recAmount: value.reclocalAmt,
        payAmount: value.payLocalAmt,
        remarks: value.remarks,
        receivedBy: _companyDetail.userName,
      );

      ////  opening the pdf file
      FileHandleApi.openFile(pdfFile);
    }

    notifyListeners();
  }
}
