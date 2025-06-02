import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/orderReportDetails/pdf/orderReportDetailsPdf.dart';
import '../../service/sharepref/get_all_pref.dart';
import '../../utils/custom_log.dart';
import '../login/company_model.dart';
import 'api/orderReportDetailsApi.dart';
import 'model/orderReportDetailsModel.dart';

class OrderDetailsState extends ChangeNotifier {
  OrderDetailsState();

  late BuildContext _context;

  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(_context);

  set getContext(BuildContext value) {
    _context = value;
  }

  late bool _isLoading = false;

  bool get isLoading => _isLoading;

  set getLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});

  CompanyDetailsModel get companyDetail => _companyDetail;

  init({required String vNo}) async {
    await clear();
    await getDataListFromAPI(vNo: vNo);
  }

  clear() async {
    _isLoading = false;
    _companyDetail = await GetAllPref.companyDetail();
    _dataList = [];
  }

  late List<OrderReportDetailDataModel> _dataList = [];

  List<OrderReportDetailDataModel> get dataList => _dataList;

  set getDataList(List<OrderReportDetailDataModel> value) {
    _dataList = [];
    _dataList = value;
    notifyListeners();
  }

  getDataListFromAPI({required String vNo}) async {
    getLoading = true;
    OrderReportDetailModel dataModel =
        await OrderReportDetailsApi.getOrderBillReport(
      databaseName: _companyDetail.databaseName,
      vNo: vNo,
    );
    if (dataModel.statusCode == 200) {
      getDataList = dataModel.data;
      getLoading = false;
    } else {
      getLoading = false;
    }
    notifyListeners();
  }

  shareLedger(
      {required String vNo,
      required String glDesc,
      required String mobile,
      required String route,
      required String remarks,
      }) async {
    CustomLog.log(value: _companyDetail.databaseName);
    await generateOrderProductListPDF(
      companyDataDetails: _companyDetail,
      orderProductList: dataList,
      glDesc: glDesc,
      vNo: vNo,
      mobile: mobile,
      route: route,
      remarks: remarks,
    );
  }
}
