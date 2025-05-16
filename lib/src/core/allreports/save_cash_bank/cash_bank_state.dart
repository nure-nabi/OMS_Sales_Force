import 'package:flutter/material.dart';
import 'package:oms_salesforce/model/model.dart';
import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/service/sharepref/get_all_pref.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../pdf/pdf.dart';
import '../apis/cash_bank_api.dart';

class SaveCashBankState extends ChangeNotifier {
  SaveCashBankState();

  late BuildContext _context;
  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(_context);
  set getContext(BuildContext value) {
    _context = value;

    ///
    init();
  }

  late bool _isLoading, _payAmountReadOnlyValue, _recAmountReadOnlyValue;
  bool get isLoading => _isLoading;
  bool get payAmountReadOnlyValue => _payAmountReadOnlyValue;
  bool get recAmountReadOnlyValue => _recAmountReadOnlyValue;
  set getLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set getPayAmountReadOnlyValue(bool value) {
    _payAmountReadOnlyValue = value;
    notifyListeners();
  }

  set getRecAmountReadOnlyValue(bool value) {
    _recAmountReadOnlyValue = value;
    notifyListeners();
  }

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});
  CompanyDetailsModel get companyDetail => _companyDetail;
  set getCompanyDetail(CompanyDetailsModel value) {
    _companyDetail = value;
    notifyListeners();
  }

  late TextEditingController _recAmountController =
      TextEditingController(text: "");
  late TextEditingController _payAmountController =
      TextEditingController(text: "");
  late TextEditingController _remarkController =
      TextEditingController(text: "");
  TextEditingController get recAmountController => _recAmountController;
  TextEditingController get payAmountController => _payAmountController;
  TextEditingController get remarkController => _remarkController;

  clear() async {
    _isLoading = false;
    _payAmountReadOnlyValue = false;
    _recAmountReadOnlyValue = false;

    _recAmountController = TextEditingController(text: "");
    _payAmountController = TextEditingController(text: "");
    _remarkController = TextEditingController(text: "");

    _companyDetail = await GetAllPref.companyDetail();
  }

  onDispose() async {
    // _recAmountController.dispose();
    // _payAmountController.dispose();
    // _remarkController.dispose();
  }

  late ProductState productState;
  getOutletInfoState() {
    productState = Provider.of<ProductState>(context, listen: false);
  }

  init() async {
    await clear();
    await getOutletInfoState();
  }

  updateBoolean({required String value, required String from}) {
    if (from == "recAmount" && value.isNotEmpty) {
      _payAmountReadOnlyValue = true;
      _payAmountController.text = "0";
    } else if (from == "payAmount" && value.isNotEmpty) {
      _recAmountReadOnlyValue = true;
      _recAmountController.text = "0";
    } else {
      _payAmountReadOnlyValue = false;
      _recAmountReadOnlyValue = false;
      _recAmountController.text = "";
      _payAmountController.text = "";
    }
    notifyListeners();
  }

  late BranchDataModel _branchInfo = BranchDataModel.fromJson({});
  BranchDataModel get branchInfo => _branchInfo;
  getBranchInfo() async {
    _branchInfo = await GetAllPref.branchDetail();
    notifyListeners();
  }

  confirm() async {
    await getBranchInfo();
    BasicModel model = await SaveCashBankAPI.saveCashBank(
      recAmount: _recAmountController.text.trim(),
      payAmount: _payAmountController.text.trim(),
      remark: _remarkController.text.trim(),
      timeStamp: await MyTimeConverter.getTimeStamp(),
      databaseName: _companyDetail.databaseName,
      branchCode: _branchInfo.unitCode,
      userName: _companyDetail.userName,
      glCode: productState.outletDetail.glCode,
    );

    if (model.statusCode == 200) {
      ShowToast.showToast(msg: model.message, backgroundColor: successColor);
      navigator.pop();
      await onPrint();
    } else {
      ShowToast.showToast(msg: model.message, backgroundColor: errorColor);
      navigator.pop();
    }
  }

  onPrint() async {
    final pdfFile = await CashBankPdfInvoiceApi.generate(
      companyDetails: _companyDetail,
      billTitleName: double.parse(_recAmountController.text) == 0.00
          ? "Payment Voucher"
          : "Receipt Voucher",
      receivedNo: "TEMP",
      date: "${DateTime.now()}".substring(0, 10).replaceAll("/", "-"),
      receivedFrom: productState.outletDetail.glDesc,
      recAmount: double.parse(_recAmountController.text),
      payAmount: double.parse(_payAmountController.text),
      remarks: _remarkController.text,
      receivedBy: _companyDetail.userName,
    );

    ////  opening the pdf file
    FileHandleApi.openFile(pdfFile);

    notifyListeners();
  }
}
