import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/model/model.dart';
import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:oms_salesforce/src/core/quickorder/quickorder.dart';
import 'package:oms_salesforce/src/service/sharepref/get_all_pref.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'api/create_outlet_api.dart';

class QuickOrderState extends ChangeNotifier {
  QuickOrderState();

  late BuildContext _context;
  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(_context);
  set getContext(BuildContext value) {
    _context = value;

    ///
    init();
  }

  late bool _isAreaShow = true;
  bool get isAreaShow => _isAreaShow;
  set getIsAreaShow(bool value) {
    _isAreaShow = value;
    notifyListeners();
  }

  late bool _isLoading = false;
  bool get isLoading => _isLoading;
  set getLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  init() async {
    await clean();
    await checkConnection();
  }

  /// For Outlet Info
  late FilterOutletInfoModel _outletInfo = FilterOutletInfoModel.fromJson({});
  FilterOutletInfoModel get outletInfo => _outletInfo;

  set getOutletInfo(FilterOutletInfoModel value) {
    _outletInfo = value;
    notifyListeners();
  }

  set filterOutletGroup(value) {
    _filterOutletList = _outletList
        .where(
            (u) => (u.outletDesc.toLowerCase().contains(value.toLowerCase())))
        .toList();
    notifyListeners();
  }


  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});
  CompanyDetailsModel get companyDetail => _companyDetail;
  set getCompanyDetail(CompanyDetailsModel value) {
    _companyDetail = value;
    notifyListeners();
  }

  checkConnection() async {
    await getRouteListFromDB();
    CheckNetwork.check().then((network) async {
      getCompanyDetail = await GetAllPref.companyDetail();
      if (network) {
        await networkSuccess();
      } else {
        await getRouteListFromDB();
      }
    });
  }

  networkSuccess() async {
    ///
    // getLoading = true;
    if(filterRouteGroup.isNotEmpty){
      await getRouteListFromDB();
    }else {
      await getDataFromAPI();
    }
    // getLoading = false;

  }

  clean() async {
    _isLoading = false;

    _isAreaShow = await GetAllPref.smartOrderOption();

    ///
    await veriableClear();

    ///
    await listClear();
  }

  listClear() {
    _routeList = [];
    _outletList = [];
    _filterOutletList = [];
    _filterRouteGroup=[];
  }

  veriableClear() {
    _selectedRouteName = "";
    _selectedRouteCode = "";

    _outletInfo = FilterOutletInfoModel.fromJson({});
  }

  late String _selectedRouteName = "";
  late String _selectedRouteCode = "";
  String get selectedRouteName => _selectedRouteName;
  String get selectedRouteCode => _selectedRouteCode;
  set getRouteName(String value) {
    _selectedRouteName = value;
    notifyListeners();
  }

  set getRouteCode(String value) {
    _selectedRouteCode = value;
    notifyListeners();
  }

  List<FilterOutletInfoModel> _routeList = [], _outletList = [], _filterOutletList = [], _filterRouteGroup = [];
  List<FilterOutletInfoModel> get routeList => _routeList;
  List<FilterOutletInfoModel> get outletList => _outletList;
  List<FilterOutletInfoModel> get filterOutletList => _filterOutletList;
  List<FilterOutletInfoModel> get filterRouteGroup => _filterRouteGroup;


  set getOutletList(List<FilterOutletInfoModel> value) {
    _outletList = [];
    _outletList = value;
    _filterOutletList = _outletList;
    notifyListeners();
  }
  set getRouteList(List<FilterOutletInfoModel> value) {
    _routeList=[];
    _routeList = value;
    _filterRouteGroup = _routeList;
    notifyListeners();
  }


  set filterRouteGroup(value) {
    _filterRouteGroup = _routeList.where((u) => (u.routeDesc.toLowerCase().contains(value.toLowerCase()))).toList();
    notifyListeners();
  }
  getDataFromAPI() async {
    getLoading = true;
    QuickAreaRouteModel routeModel = await QuickOrderAPI.getRouteAPI(
      agentCode: _companyDetail.agentCode,
      dbName: _companyDetail.databaseName,
     // unit: await GetAllPref.unitCode(),
      unit: "",
      //methodName: _isAreaShow ? "ListSalesmanAssignToRouteAgent" : "ListSalesmanAssignToRoute",
      methodName:  "ListSalesmanAssignToRoute",
    );
    if (routeModel.statusCode == 200) {

      await onSuccess(dataModel: routeModel.zoneData);
      getLoading = false;
    } else {
      ShowToast.errorToast(msg: "Failed to get data");
    }
    notifyListeners();
  }

  onSuccess({required List<ZoneRouteModel> dataModel}) async {
    ///

    List<FilterOutletInfoModel> data = await filterAndArrangeData(
      dataModel: dataModel,
    );
    ///
    await OutLetInfoDatabase.instance.deleteData();
    for (var element in data) {
      await OutLetInfoDatabase.instance.insertData(element);
    }
    ///
    await getRouteListFromDB();

    notifyListeners();
  }

  getRouteListFromDB() async {
    await OutLetInfoDatabase.instance.getRouteData().then((value) {
      getRouteList = value;
    });
    // if (_selectedRouteCode.isEmpty) {
    //   await getOutletListFromDB();
    // }
    await getOutletListFromDB();
    notifyListeners();
  }

  getOutletListFromDB() async {
    CustomLog.actionLog(value: "OUTLET LIST CALLED");
    await OutLetInfoDatabase.instance
        .getOutletData(routeCode: _selectedRouteCode)
        .then((value) {
      getOutletList = value;
    });
    notifyListeners();
  }

  // /// This method is to format the response data get from api
  // Future<List<FilterOutletInfoModel>> filterAndArrangeData({
  //   required List<ZoneRouteModel> dataModel,
  // }) async {
  //   List<FilterOutletInfoModel> filterData = <FilterOutletInfoModel>[];
  //   for (var zoneData in dataModel) {
  //     for (var routeData in zoneData.routeList) {
  //       for (var outletInfo in routeData.outletInfo) {
  //         filterData.add(
  //           FilterOutletInfoModel(
  //             glCode: outletInfo.glCode,
  //             glDesc: outletInfo.glDesc,
  //             outletCode: outletInfo.outletCode,
  //             outletDesc: outletInfo.outletDesc,
  //             mobileNo: outletInfo.mobileNo,
  //             phoneNo: outletInfo.phoneNo,
  //             outletPerson: outletInfo.outletPerson,
  //             panno: outletInfo.panno,
  //             address: outletInfo.address,
  //             email: outletInfo.email,
  //             priceTag: outletInfo.priceTag,
  //             latitude: outletInfo.latitude,
  //             longitude: outletInfo.longitude,
  //             balance: outletInfo.balance,
  //             productPointBalance: outletInfo.productPointBalance,
  //             mAreaCode: zoneData.mAreaCode,
  //             mAreaDesc: zoneData.mAreaDesc,
  //             routeCode: routeData.routeCode,
  //             routeDesc: routeData.routeDesc,

  //             ///
  //             routeStatus: "",
  //             outletStatus: "",
  //           ),
  //         );
  //       }
  //       filterData.add(
  //         FilterOutletInfoModel(
  //           glCode: "",
  //           glDesc: "",
  //           outletCode: "",
  //           outletDesc: "",
  //           mobileNo: "",
  //           phoneNo: "",
  //           outletPerson: "",
  //           panno: "",
  //           address: "",
  //           email: "",
  //           priceTag: "",
  //           latitude: "",
  //           longitude: "",
  //           balance: "",
  //           productPointBalance: "",
  //           mAreaCode: zoneData.mAreaCode,
  //           mAreaDesc: zoneData.mAreaDesc,
  //           routeCode: routeData.routeCode,
  //           routeDesc: routeData.routeDesc,

  //           ///
  //           routeStatus: "",
  //           outletStatus: "",
  //         ),
  //       );
  //     }
  //   }
  //   return filterData;
  // }

  /// ========================================================== ///
  /// ========================================================== ///
  /// ========================================================== ///

  // /// This method is to format the response data get from api

  Future<List<FilterOutletInfoModel>> filterAndArrangeData({
    required List<ZoneRouteModel> dataModel,
  }) async {
    List<FilterOutletInfoModel> filterData = <FilterOutletInfoModel>[];

    for (var zoneData in dataModel) {
      for (var routeData in zoneData.routeList) {
        for (var outletInfo in routeData.outletInfo) {

          filterData.add(_createFilterOutletInfoModel(
            outletInfo: outletInfo,
            mAreaCode: zoneData.mAreaCode,
            mAreaDesc: zoneData.mAreaDesc,
            routeCode: routeData.routeCode,
            routeDesc: routeData.routeDesc,
          ));
        }
        if (routeData.outletInfo.isEmpty) {
          filterData.add(_createEmptyFilterOutletInfoModel(
            mAreaCode: zoneData.mAreaCode,
            mAreaDesc: zoneData.mAreaDesc,
            routeCode: routeData.routeCode,
            routeDesc: routeData.routeDesc,
          ));
        }
      }
    }

    return filterData;
  }

  FilterOutletInfoModel _createFilterOutletInfoModel({
    required OutletInfoModel outletInfo,
    required String mAreaCode,
    required String mAreaDesc,
    required String routeCode,
    required String routeDesc,
  }) {

    return FilterOutletInfoModel(
      glCode: outletInfo.glCode,
      glDesc: outletInfo.glDesc,
      outletCode: outletInfo.outletCode,
      outletDesc: outletInfo.outletDesc,
      mobileNo: outletInfo.mobileNo,
      phoneNo: outletInfo.phoneNo,
      outletPerson: outletInfo.outletPerson,
      panno: outletInfo.panno,
      address: outletInfo.address,
      email: outletInfo.email,
      priceTag: outletInfo.priceTag,
      latitude: outletInfo.latitude,
      longitude: outletInfo.longitude,
      balance: outletInfo.balance,
      productPointBalance: outletInfo.productPointBalance,
      mAreaCode: mAreaCode,
      mAreaDesc: mAreaDesc,
      routeCode: routeCode,
      routeDesc: routeDesc,
      routeStatus: "",
      outletStatus: "",
      tempPCode: "",
      orderPCode: "",
    );
  }

  FilterOutletInfoModel _createEmptyFilterOutletInfoModel({
    required String mAreaCode,
    required String mAreaDesc,
    required String routeCode,
    required String routeDesc,
  }) {
    return FilterOutletInfoModel(
      glCode: "",
      glDesc: "",
      outletCode: "",
      outletDesc: "",
      mobileNo: "",
      phoneNo: "",
      outletPerson: "",
      panno: "",
      address: "",
      email: "",
      priceTag: "",
      latitude: "",
      longitude: "",
      balance: "",
      productPointBalance: "",
      mAreaCode: mAreaCode,
      mAreaDesc: mAreaDesc,
      routeCode: routeCode,
      routeDesc: routeDesc,
      routeStatus: "",
      outletStatus: "",
      tempPCode: "",
      orderPCode: "",
    );
  }

  /// ========================================================== ///

  /// ========================================================== ///
  /// ========================================================== ///
  ///
  Future clearFieldToAddNewOutlet() async {
    _outletName = TextEditingController(text: "");
    _contactPerson = TextEditingController(text: "");
    _mobileNo = TextEditingController(text: "");
    _landlineNo = TextEditingController(text: "");
    _email = TextEditingController(text: "");
    _address = TextEditingController(text: "");
    _panNo = TextEditingController(text: "");
    _outletType = TextEditingController(text: "");
    _route.text = _selectedRouteName;

    notifyListeners();
  }

  /// Text Controllers to add new Outlet
  late TextEditingController _outletName = TextEditingController(text: "");
  late TextEditingController _contactPerson = TextEditingController(text: "");
  late TextEditingController _mobileNo = TextEditingController(text: "");
  late TextEditingController _landlineNo = TextEditingController(text: "");
  late TextEditingController _email = TextEditingController(text: "");
  late TextEditingController _address = TextEditingController(text: "");
  late TextEditingController _panNo = TextEditingController(text: "");
  late TextEditingController _outletType = TextEditingController(text: "");
  late final TextEditingController _route =
  TextEditingController(text: _selectedRouteName);

  TextEditingController get outletName => _outletName;
  TextEditingController get contactPerson => _contactPerson;
  TextEditingController get mobileNo => _mobileNo;
  TextEditingController get landlineNo => _landlineNo;
  TextEditingController get email => _email;
  TextEditingController get address => _address;
  TextEditingController get panNo => _panNo;
  TextEditingController get outletType => _outletType;
  TextEditingController get route => _route;

  late final FocusNode _contactPersonFocus = FocusNode();
  late final FocusNode _mobileNoFocus = FocusNode();
  late final FocusNode _landlineNoFocus = FocusNode();
  late final FocusNode _emailFocus = FocusNode();
  late final FocusNode _addressFocus = FocusNode();
  late final FocusNode _panNoFocus = FocusNode();

  FocusNode get contactPersonFocus => _contactPersonFocus;
  FocusNode get mobileNoFocus => _mobileNoFocus;
  FocusNode get landlineNoFocus => _landlineNoFocus;
  FocusNode get emailFocus => _emailFocus;
  FocusNode get addressFocus => _addressFocus;
  FocusNode get panNoFocus => _panNoFocus;

  createOutlet() async {
    getLoading = true;

    BasicModel model = await CreateOutletAPI.createOutlet(
      dbName: _companyDetail.databaseName,
      agentCode: _companyDetail.agentCode,
      longitude: await MyLocation().long(),
      outletName: _outletName.text.trim(),
      panNo: _panNo.text.trim(),
      phoneNo: _landlineNo.text.trim(),
      route: _selectedRouteCode,
      address: _address.text.trim(),
      mobileNo: _mobileNo.text.trim(),
      email: _email.text.trim(),
      latitude: await MyLocation().lat(),
      outletCode: "",
      contactPerson: _contactPerson.text.trim(),
      priceTag: "Wholedsale",
      tag: "New",
    );
    CustomLog.actionLog(value: "\n\n RESPONSE => ${jsonEncode(model)} \n\n");
    if (model.statusCode == 200) {
      await clearFieldToAddNewOutlet();
      ShowToast.successToast(msg: model.message);

      getLoading = false;
      navigator.pop();
    } else {
      ShowToast.errorToast(msg: model.message);
      getLoading = false;
    }
    notifyListeners();
  }
}
