import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/pendingverify/api/pending_verify_api.dart';

import '../../service/sharepref/sharepref.dart';
import '../login/login.dart';
import 'components/pending_product_details_section.dart';
import 'db/pending_verify_db.dart';
import 'model/pending_verify_model.dart';

class PendingVerifyState extends ChangeNotifier {
  PendingVerifyState();

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

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});
  CompanyDetailsModel get companyDetail => _companyDetail;

  init() async {
    await clear();
    await getDataListFromAPI();
  }

  clear() async {
    _isLoading = false;
    _companyDetail = await GetAllPref.companyDetail();
  }

  late List<PendingVerifyDataModel> _outletList = [];
  List<PendingVerifyDataModel> get outletList => _outletList;
  set getOutletList(List<PendingVerifyDataModel> value) {
    _outletList = value;
    notifyListeners();
  }

  getDataListFromAPI() async {
    getLoading = true;
    PendingVerifyModel dataModel = await PendingVeriyAPI.getData(
      dbName: _companyDetail.databaseName,
      agentCode: _companyDetail.agentCode,
    );
    if (dataModel.statusCode == 200) {
      await onSuccess(data: dataModel.data);
    } else {
      getLoading = false;
    }
    notifyListeners();
  }

  onSuccess({required List<PendingVerifyDataModel> data}) async {
    await PendingVerifyDatabase.instance.deleteData();
    for (var element in data) {
      await PendingVerifyDatabase.instance.insertData(element);
    }

    await getOutletListFromDatabase();
    //
    notifyListeners();
  }

  getOutletListFromDatabase() async {
    await PendingVerifyDatabase.instance.getOutletInfo().then((value) {
      getOutletList = value;
    });
    getLoading = false;
    notifyListeners();
  }

  ///
  late PendingVerifyDataModel _selectedOutlet =
      PendingVerifyDataModel.fromJson({});
  PendingVerifyDataModel get selectedOutlet => _selectedOutlet;
  set getSelectedOutlet(PendingVerifyDataModel value) {
    _selectedOutlet = value;
    notifyListeners();
  }

  late List<PendingVerifyDataModel> _productList = [];
  List<PendingVerifyDataModel> get productList => _productList;
  set getProductList(List<PendingVerifyDataModel> value) {
    _productList = [];
    _productList = value;
    notifyListeners();
  }

  late double _totalBalance = 0.00;
  double get totalBalance => _totalBalance;
  set getTotalBalance(double value) {
    _totalBalance = 0.00;
    _totalBalance = value;
    notifyListeners();
  }

  late int _brandCount = 0;
  int get brandCount => _brandCount;
  set getBrandCount(int value) {
    _brandCount = 0;
    _brandCount = value;
    notifyListeners();
  }

  onOutletSelected() async {
    await PendingVerifyDatabase.instance
        .getProductListByGlCode(glCode: _selectedOutlet.glCode)
        .then((value) {
      getProductList = value;
    });
    await PendingVerifyDatabase.instance
        .getTotal(glCode: _selectedOutlet.glCode)
        .then((value) {
      getTotalBalance = value;
    });
    await PendingVerifyDatabase.instance
        .getBrandCount(glCode: _selectedOutlet.glCode)
        .then((value) {
      getBrandCount = value;
    });

    ///
    navigator.push(
      MaterialPageRoute(
        builder: (context) => const PendingProductDetailsSection(),
      ),
    );

    ///
    notifyListeners();
  }
}
