import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/sharepref/sharepref.dart';
import '../login/login.dart';
import '../products/product_state.dart';
import 'top_buying.dart';

class TopBuyingState extends ChangeNotifier {
  TopBuyingState();

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

  late bool _isFromIndex = true;
  bool get isFromIndex => _isFromIndex;
  set isFromIndex(bool value) {
    _isFromIndex = true;
    _isFromIndex = value;
    notifyListeners();
  }

  init() async {
    await clean();
    await getOutletInfoState();
    await getTopBuyingFromRemote();
  }

  CompanyDetailsModel _companyDetails = CompanyDetailsModel.fromJson({});

  clean() async {
    _isLoading = false;
    _isOrderbyQTY = true;

    _dataList = [];
    _companyDetails = await GetAllPref.companyDetail();
  }

  late ProductState productState;
  getOutletInfoState() {
    productState = Provider.of<ProductState>(context, listen: false);
  }

  late List<TopBuyingDataModel> _dataList = [];
  List<TopBuyingDataModel> get dataList => _dataList;
  set dataList(List<TopBuyingDataModel> value) {
    _dataList = value;
    filterDataList();
    notifyListeners();
  }

  late bool _isOrderbyQTY = true;
  bool get isOrderbyQTY => _isOrderbyQTY;
  set isOrderbyQTY(bool value) {
    _isOrderbyQTY = value;
    notifyListeners();
  }

  filterDataList() {
    if (_isOrderbyQTY) {
      _dataList.sort((a, b) => b.qty.compareTo(a.qty));
    } else {
      _dataList.sort((a, b) => b.netAmt.compareTo(a.netAmt));
    }
    notifyListeners();
  }

  getTopBuyingFromRemote() async {
    isLoading = true;
    TopBuyingModel model = await TopBuyingAPI.getQuestion(
      databaseName: _companyDetails.databaseName,
      glCode: _isFromIndex ? "" : productState.outletDetail.glCode,
    );

    if (model.statusCode == 200) {
      dataList = model.data;
    } else {
      dataList = [];
    }
    isLoading = false;
    notifyListeners();
  }
}
