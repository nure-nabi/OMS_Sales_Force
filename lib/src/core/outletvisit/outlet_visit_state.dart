import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:provider/provider.dart';

import '../../service/sharepref/sharepref.dart';
import '../datepicker/date_picker_state.dart';
import '../login/login.dart';
import '../products/products.dart';
import 'outlet_visit_more_screen.dart';
import 'outletvisit.dart';

class OutletVisitState extends ChangeNotifier {
  OutletVisitState();

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
    await getOutletInfoState();
    await getOutletVisitFromRemote();
  }

  late ProductState productState;
  getOutletInfoState() {
    productState = Provider.of<ProductState>(context, listen: false);
  }

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});
  CompanyDetailsModel get companyDetail => _companyDetail;

  clean() async {
    _isLoading = false;

    toDate =
        NepaliDateTime.now().toString().substring(0, 10).replaceAll("/", "-");
    fromDate = NepaliDateTime.now()
        .subtract(const Duration(days: 90)) // [ 20 Years ]
        .toString()
        .substring(0, 10)
        .replaceAll("/", "-");

    _companyDetail = await GetAllPref.companyDetail();
  }

  late List<OutletVisitDataModel> _outletVisitList = [];
  List<OutletVisitDataModel> get outletVisitList => _outletVisitList;
  set outletVisitList(List<OutletVisitDataModel> value) {
    _outletVisitList = value;
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

  onDatePickerConfirm() async {
    getFromDate = Provider.of<DatePickerState>(context, listen: false).fromDate;
    getToDate = Provider.of<DatePickerState>(context, listen: false).toDate;
    await getOutletVisitFromRemote().whenComplete(() {
      Navigator.pop(context);
    });
    notifyListeners();
  }

  String convertDate(String date) {
    return NepaliDateTime.parse(date).toDateTime().toString().substring(0, 10);
  }

  getOutletVisitFromRemote() async {
    isLoading = true;
    outletVisitList = [];

    OutletVisitModel model = await OutletVisitAPI.getData(
      dbName: _companyDetail.databaseName,
      agentCode: _companyDetail.agentCode,
      // agentCode: "",
      glCode: "",
      areaCode: "",
      fromDate: convertDate(fromDate),
      toDate: convertDate(toDate),
    );

    if (model.statusCode == 200) {
      outletVisitList = model.data;
      updateListToggleValue();
    } else {
      outletVisitList = [];
    }

    isLoading = false;
    notifyListeners();
  }

  late List<bool> _isShowItemBuilder = [];
  List<bool> get isShowItemBuilder => _isShowItemBuilder;

  updateListToggleValue() {
    _isShowItemBuilder = List.generate(
      outletVisitList.length,
      (index) => false,
    );
    notifyListeners();
  }

  late OutletVisitDataModel _selectedOutlet = OutletVisitDataModel.fromJson({});
  OutletVisitDataModel get selectedOutlet => _selectedOutlet;
  set selectedOutlet(OutletVisitDataModel value) {
    _selectedOutlet = value;
    notifyListeners();
  }

  //
  late List<OutletVisitDataModel> _outletVisitMoreList = [];
  List<OutletVisitDataModel> get outletVisitMoreList => _outletVisitMoreList;
  set outletVisitMoreList(List<OutletVisitDataModel> value) {
    _outletVisitMoreList = value;
    notifyListeners();
  }

  getOutletVisitMoreFromRemote() async {
    isLoading = true;
    outletVisitMoreList = [];

    OutletVisitModel model = await OutletVisitAPI.viewMoreOutletVisit(
      dbName: _companyDetail.databaseName,
      agentCode: _companyDetail.agentCode,
      glCode: selectedOutlet.glCode,
      areaCode: selectedOutlet.areaCode,
      fromDate: convertDate(fromDate),
      toDate: convertDate(toDate),
    );

    if (model.statusCode == 200) {
      outletVisitMoreList = model.data;
      navigator.push(
        MaterialPageRoute(builder: (_) => const OutletVisitMoreScreen()),
      );
    } else {
      outletVisitMoreList = [];
    }

    isLoading = false;
    notifyListeners();
  }
}
