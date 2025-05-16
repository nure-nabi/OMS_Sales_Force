import 'package:flutter/material.dart';
import 'package:oms_salesforce/model/model.dart';
import 'package:oms_salesforce/src/core/allreports/allreports.dart';
import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:oms_salesforce/src/service/sharepref/sharepref.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../imagepicker/imagepicker.dart';
import '../../pdf/bill_pdf.dart';
import '../../pdf/pdc_pdf.dart';
import '../../products/products.dart';

class PDCEntriesState extends ChangeNotifier {
  PDCEntriesState();

  late bool _isLoading = false;
  bool get isLoading => _isLoading;
  set getLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  late GlobalKey<FormState> validateKey = GlobalKey<FormState>();
  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});
  CompanyDetailsModel get companyDetail => _companyDetail;
  set getCompanyDetail(CompanyDetailsModel value) {
    _companyDetail = value;
    notifyListeners();
  }

  late BuildContext _context;
  BuildContext get context => _context;
  set getContext(BuildContext value) {
    _context = value;

    ///
    init();
  }

  late ProductState productState;
  getOutletInfoState() {
    productState = Provider.of<ProductState>(context, listen: false);
  }

  init() async {
    await clear();
    await getOutletInfoState();
    await getBankListFromAPI();
  }

  late bool _isBankLoading = false;
  bool get isBankLoading => _isBankLoading;
  set getBankLoading(bool value) {
    _isBankLoading = value;
    notifyListeners();
  }

  clear() async {
    _isLoading = false;
    _isBankLoading = false;
    _isImageAdd = false;
    _bankName = TextEditingController(text: "");
    _amount = TextEditingController(text: "");
    _chequeNo = TextEditingController(text: "");
    _chequeDate = TextEditingController(text: "");
    _remarks = TextEditingController(text: "");

    _companyDetail = await GetAllPref.companyDetail();
  }

  late TextEditingController _bankName = TextEditingController(text: ""),
      _amount = TextEditingController(text: ""),
      _chequeNo = TextEditingController(text: ""),
      _remarks = TextEditingController(text: "");
  late TextEditingController _chequeDate = TextEditingController(text: "");
  TextEditingController get chequeDate => _chequeDate;
  TextEditingController get amount => _amount;
  TextEditingController get bankName => _bankName;
  TextEditingController get chequeNo => _chequeNo;
  TextEditingController get remarks => _remarks;

  set getBankName(String value) {
    _bankName.text = value;
    debugPrint("Bank Name => $_bankName");
    // notifyListeners();
  }

  // set getAmount(String value) {
  //   _amount.text = value;
  //   notifyListeners();
  // }

  // set getChequeNo(String value) {
  //   _chequeNo.text = value;
  //   notifyListeners();
  // }

  set getChequeDate(String value) {
    _chequeDate.text = value;
    notifyListeners();
  }

  // set getRemark(String value) {
  //   _remarks.text = value;
  //   notifyListeners();
  // }

  late FocusNode customerNameFocus = FocusNode();

  late String _myContainImage = "";
  String get myContainImage => _myContainImage;
  set getBillImage(String value) {
    _myContainImage = "";
    _myContainImage = value;
    notifyListeners();
  }

  late bool _isImageAdd = false;
  bool get isImageAdd => _isImageAdd;
  set getIsImageAdd(bool value) {
    _isImageAdd = value;
    notifyListeners();
  }



  late List<BankListModel> _bankList = [];
  List<BankListModel> get bankList => _bankList;
  set getBankList(List<BankListModel> value) {
    _bankList = value;
    _filteredBankList = value;

    notifyListeners();
  }

  List<BankListModel> _filteredBankList = [];
  List<BankListModel> get filteredBankList => _filteredBankList;

  set getBankFilterList(List<BankListModel> value) {
    _filteredBankList = value;
    notifyListeners();
  }

  update(){
    notifyListeners();
  }

  getBankListFromAPI() async {
    getBankLoading = true;
    _bankList = [];
    BankModel modelData = await PDCReportAPI.getBankList(
        databaseName: _companyDetail.databaseName);

    if (modelData.statusCode == 200) {
      getBankList = modelData.data;
      getBankLoading = false;
    } else {
      getBankLoading = false;
    }
    notifyListeners();
  }

  late BranchDataModel _branchInfo = BranchDataModel.fromJson({});
  BranchDataModel get branchInfo => _branchInfo;
  getBranchInfo() async {
    _branchInfo = await GetAllPref.branchDetail();
    notifyListeners();
  }

  onConfirm(context) async {
    await getBranchInfo();
    getBillImage =
        Provider.of<ImagePickerState>(context, listen: false).myPickedImage;
    if (validateKey.currentState!.validate()) {
      validateKey.currentState!.save();
      getLoading = true;

      BasicModel groupModel = await PDCEntriesAPI.postData(
        databaseName: _companyDetail.databaseName,
        branchCode: await GetAllPref.getBranch(),
        glCode: productState.outletDetail.glCode,
        remarks: _remarks.text,
        amount: _amount.text,
        chequeNo: _chequeNo.text,
        bankName: _bankName.text,
        image: _myContainImage,
        timeStamp: MyTimeConverter.convertDateToTimeStamp(
          date: _chequeDate.text.trim(),
        ),
      );

      if (groupModel.statusCode == 200) {
        validateKey.currentState!.reset();
        Provider.of<ImagePickerState>(context, listen: false).init();

        getLoading = false;
        ShowToast.successToast(msg: groupModel.message);
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //   homePagePath,
        //   (route) => false,
        // );
        Navigator.of(context).pop();

        await onPrint();
      } else {
        getLoading = false;
        ShowToast.errorToast(msg: groupModel.message);
      }
    }
    notifyListeners();
  }

  onPrint() async {
    final pdfFile = await PDCPdfInvoiceApi.generate(
      companyDetails: _companyDetail,
      billTitleName: "PDC Report",
      receivedNo: "TEMP",
      date: "${DateTime.now()}".substring(0, 10),
      bankName: _bankName.text,
      chequeNo: _chequeNo.text,
      chequeDate: _chequeDate.text,
      receivedFrom: productState.outletDetail.glDesc,
      receivedAmount: _amount.text,
      remarks: _remarks.text,
      receivedBy: "${_companyDetail.loginName} ( ${_companyDetail.userName} )",
      branchName: await GetAllPref.getBranchName(),
    );

    ////  opening the pdf file
    FileHandleApi.openFile(pdfFile);

    notifyListeners();
  }
}
