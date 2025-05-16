import 'package:flutter/material.dart';
import 'package:oms_salesforce/model/model.dart';
import 'package:oms_salesforce/src/core/allreports/model/ledger_notes_model.dart';
import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/service/router/router.dart';
import 'package:oms_salesforce/src/service/sharepref/sharepref.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:provider/provider.dart';

import 'save_ledger_notes_api.dart';

class SaveLedgetNotesState extends ChangeNotifier {
  SaveLedgetNotesState();

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
    await getOutletInfoState();
    await getNotesListFromAPI();
  }

  CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});

  clean() async {
    _isLoading = false;
    _remarks = TextEditingController(text: "");
    _companyDetail = await GetAllPref.companyDetail();
  }

  late ProductState productState;
  getOutletInfoState() {
    productState = Provider.of<ProductState>(context, listen: false);
  }

  late TextEditingController _remarks = TextEditingController(text: "");
  TextEditingController get remarks => _remarks;

  late final GlobalKey<FormState> _remarkKey = GlobalKey<FormState>();
  GlobalKey<FormState> get remarkKey => _remarkKey;

  saveNotesToAPI() async {
    getLoading = true;
    BasicModel modelData = await SaveLedgerNotesAPI.saveNotes(
      databaseName: _companyDetail.databaseName,
      glCode: productState.outletDetail.glCode,
      remarks: _remarks.text.trim(),
      timeStamp: await MyTimeConverter.getTimeStamp(),
      lat: "0",
      long: "0",
    );

    if (modelData.statusCode == 200) {
      getLoading = false;

      navigator.pushNamedAndRemoveUntil(
        homePagePath,
        (route) => false,
      );
      ShowToast.showToast(
        msg: modelData.message,
        backgroundColor: Colors.green,
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

  late List<LedgerNoteDataModel> _notesList = [];
  List<LedgerNoteDataModel> get notesList => _notesList;
  set getNotesList(List<LedgerNoteDataModel> value) {
    _notesList = value;
    notifyListeners();
  }

  getNotesListFromAPI() async {
    getLoading = true;
    getNotesList = [];
    LedgerNoteModel modelData = await SaveLedgerNotesAPI.notesList(
      databaseName: _companyDetail.databaseName,
      glCode: productState.outletDetail.glCode,
    );

    if (modelData.statusCode == 200) {
      getNotesList = modelData.data;
      getLoading = false;
    } else {
      getNotesList = [];
      getLoading = false;
    }
    notifyListeners();
  }
}
