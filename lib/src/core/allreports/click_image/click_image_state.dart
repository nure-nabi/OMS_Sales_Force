import 'package:flutter/material.dart';
import 'package:oms_salesforce/model/basic_model.dart';
import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/service/sharepref/get_all_pref.dart';
import 'package:oms_salesforce/src/utils/location_permission.dart';
import 'package:oms_salesforce/src/utils/show_toast.dart';
import 'package:oms_salesforce/src/utils/time_converter.dart';
import 'package:provider/provider.dart';

import '../../imagepicker/imagepicker.dart';
import '../allreports.dart';

class ClickImageState extends ChangeNotifier {
  ClickImageState();

  late BuildContext _context;
  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(_context);
  set getContext(BuildContext value) {
    _context = value;

    ///
    init();
  }

  late bool _isLoading;
  bool get isLoading => _isLoading;
  set getLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});
  CompanyDetailsModel get companyDetail => _companyDetail;
  set getCompanyDetail(CompanyDetailsModel value) {
    _companyDetail = value;
    notifyListeners();
  }

  late ProductState productState;
  getOutletInfoState() {
    productState = Provider.of<ProductState>(context, listen: false);
  }

  init() async {
    await clear();
    await getOutletInfoState();
  }

  clear() async {
    _isLoading = false;
    _myContainImage = "";
    _remarks = TextEditingController(text: "");

    _companyDetail = await GetAllPref.companyDetail();
  }

  late bool _isImageAdd = false;
  bool get isImageAdd => _isImageAdd;
  set getIsImageAdd(bool value) {
    _isImageAdd = value;
    notifyListeners();
  }

  late String _myContainImage = "";
  String get myContainImage => _myContainImage;
  set getBillImage(String value) {
    _myContainImage = "";
    _myContainImage = value;
    notifyListeners();
  }

  late TextEditingController _remarks = TextEditingController(text: "");
  TextEditingController get remarks => _remarks;

  onConfirm() async {
    getLoading = true;
    getBillImage =
        Provider.of<ImagePickerState>(context, listen: false).myPickedImage;

    BasicModel model = await ClickImageAPI.postData(
      databaseName: _companyDetail.databaseName,
      salesmanId: _companyDetail.agentCode,
      routeCode: productState.outletDetail.routeCode,
      outletCode: productState.outletDetail.outletCode,
      remarks: _remarks.text.trim(),
      lat: await MyLocation().lat(),
      long: await MyLocation().long(),
      image: _myContainImage,
      timeStamp: await MyTimeConverter.getTimeStamp(),
    );
    if (model.statusCode == 200) {
      ShowToast.successToast(msg: model.message);
    } else {
      ShowToast.errorToast(msg: model.message);
    }
    getLoading = false;
    navigator.pop();

    notifyListeners();
  }
}
