import 'package:flutter/material.dart';

import '../../service/sharepref/sharepref.dart';
import '../login/login.dart';
import '../productorder/db/product_order_db.dart';
import 'model/pending_sync_model.dart';

class PendingSyncState extends ChangeNotifier {
  PendingSyncState();

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
    await clear();
  }

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});
  CompanyDetailsModel get companyDetail => _companyDetail;

  clear() async {
    _companyDetail = await GetAllPref.companyDetail();

    await getProductListFromDatabase();
  }

  late List<ProductPendingSync> _productList = [];
  List<ProductPendingSync> get productList => _productList;
  set getProductList(List<ProductPendingSync> value) {
    _productList = value;
    notifyListeners();
  }

  getProductListFromDatabase() async {
    await ProductOrderDatabase.instance.getAllProductList().then((value) {
      getProductList = value;
    });
    notifyListeners();
  }
}
