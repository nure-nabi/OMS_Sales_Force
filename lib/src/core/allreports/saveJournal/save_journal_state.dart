import 'package:flutter/material.dart';
import 'package:oms_salesforce/model/model.dart';
import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/service/router/router.dart';
import 'package:oms_salesforce/src/service/sharepref/sharepref.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:provider/provider.dart';

import 'model/ledger_model.dart';
import 'save_journal_api.dart';

class SaveJournalState extends ChangeNotifier {
  SaveJournalState();

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

  late bool _isLedgerLoading = false;
  bool get isLedgerLoading => _isLedgerLoading;
  set getIsLedgerLoading(bool value) {
    _isLedgerLoading = value;
    notifyListeners();
  }

  init() async {
    await getOutletInfoState();
    await clean();
    await getLedgerListFromAPI();
  }

  late ProductState productState;
  getOutletInfoState() {
    productState = Provider.of<ProductState>(context, listen: false);
  }

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});

  clean() async {
    _isLedgerLoading = false;
    _isLoading = false;
    _debitBool = false;
    _creditBool = false;

    _debit = TextEditingController(text: "");
    _credit = TextEditingController(text: "");
    _remarks = TextEditingController(text: "");

    _companyDetail = await GetAllPref.companyDetail();
  }

  late List<JournalLedgerDataModel> _ledgerList = [];
  List<JournalLedgerDataModel> get ledgerList => _ledgerList;
  set getLedgerList(List<JournalLedgerDataModel> value) {
    _ledgerList = value;
    notifyListeners();
  }

  late JournalLedgerDataModel _selectedLedger =
      JournalLedgerDataModel.fromJson({});
  JournalLedgerDataModel get selectedLedger => _selectedLedger;
  set getSelectedLedgerList(JournalLedgerDataModel value) {
    _selectedLedger = value;
  }

  getLedgerListFromAPI() async {
    getIsLedgerLoading = true;
    JournalLedgerModel modelData = await SaveJournalAPI.getLedger(
      databaseName: _companyDetail.databaseName,
      glCode: "",
      groupCode: "",
      category: "",
    );

    if (modelData.statusCode == 200) {
      getLedgerList = modelData.data;
      getIsLedgerLoading = false;
    } else {
      getIsLedgerLoading = false;
    }
    notifyListeners();
  }

  late TextEditingController _debit = TextEditingController(text: "");
  late TextEditingController _credit = TextEditingController(text: "");
  late TextEditingController _remarks = TextEditingController(text: "");
  TextEditingController get debit => _debit;
  TextEditingController get credit => _credit;
  TextEditingController get remarks => _remarks;

  late bool _debitBool = false, _creditBool = false;
  bool get debitBool => _debitBool;
  bool get creditBool => _creditBool;
  set getDebitBool(bool value) {
    _debitBool = value;
    notifyListeners();
  }

  set getCreditBool(bool value) {
    _creditBool = value;
    notifyListeners();
  }

  updateBoolean({required String value, required String from}) {
    if (from == "debit" && value.isNotEmpty) {
      getCreditBool = true;
      _credit.text = "0";
    } else if (from == "credit" && value.isNotEmpty) {
      getDebitBool = true;
      _debit.text = "0";
    } else {
      getDebitBool = false;
      getCreditBool = false;
      _credit.text = "";
      _debit.text = "";
    }
    notifyListeners();
  }

  saveJournal() async {
    getLoading = true;
    BasicModel modelData = await SaveJournalAPI.saveJournal(
      databaseName: _companyDetail.databaseName,
      glCode: _selectedLedger.glCode,
      remarks: remarks.text.trim(),
      timeStamp: await MyTimeConverter.getTimeStamp(),
      glCode1: productState.outletDetail.glCode,
      debit: debit.text.trim(),
      credit: credit.text.trim(),
      userCode: _companyDetail.userCode,
    );

    if (modelData.statusCode == 200) {
      getLoading = false;
      ShowToast.showToast(
        msg: modelData.message,
        backgroundColor: Colors.green,
      );
      navigator.pushNamedAndRemoveUntil(
        homePagePath,
        (route) => false,
      );
    } else {
      getLoading = false;
      ShowToast.showToast(
        msg: modelData.message,
        backgroundColor: Colors.red,
      );
    }
    notifyListeners();
  }
}
