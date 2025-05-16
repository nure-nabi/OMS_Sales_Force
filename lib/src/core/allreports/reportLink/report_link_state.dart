import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/allreports/allreports.dart';
import 'package:oms_salesforce/src/core/datepicker/datepicker.dart';
import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/enum/enum.dart';
import 'package:oms_salesforce/src/service/sharepref/get_all_pref.dart';
import 'package:oms_salesforce/src/service/sharepref/sharepref.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../login/login.dart';

class ReportLinkState extends ChangeNotifier {
  ReportLinkState();

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
    await getOutletInfoState();
    await clean();
  }

  clean() async {
    _isLoading = false;

    getToDate = DateTime.now().toString().substring(0, 10);
    getFromDate = DateTime.now()
        .subtract(const Duration(days: 7300)) // [ 20 Years ]
        .toString()
        .substring(0, 10);

    _companyDetails = await GetAllPref.companyDetail();
  }

  late ProductState productState;
  getOutletInfoState() {
    productState = Provider.of<ProductState>(context, listen: false);
  }

  late CompanyDetailsModel _companyDetails = CompanyDetailsModel.fromJson({});
  CompanyDetailsModel get companyDetails => _companyDetails;

  String toDate = "";
  String fromDate = "";
  onDatePickerConfirm() async {
    getFromDate = Provider.of<DatePickerState>(context, listen: false).fromDate;
    getToDate = Provider.of<DatePickerState>(context, listen: false).toDate;
    Navigator.pop(context);
  }

  set getFromDate(String value) {
    fromDate = convertDateFormat(value);

    notifyListeners();
  }

  set getToDate(String value) {
    toDate = convertDateFormat(value);
    notifyListeners();
  }

  String convertDateFormat(String inputDate) {
    List<String> dateParts = inputDate.split('-');
    String year = dateParts[0];
    String month = dateParts[1];
    String day = dateParts[2];

    return '$day/$month/$year';
  }

  openURL(LinkReportModel indexData) async {
    String baseURL = await GetAllPref.imageURL();
    await getBranchInfo();
    debugPrint("FINAL URL => ${baseURL + getUrl(value: indexData.enumValue)}");
    await OpenWithUrl.openUrl(
      url: baseURL + getUrl(value: indexData.enumValue),
    );
  }

  late BranchDataModel _branchInfo = BranchDataModel.fromJson({});
  BranchDataModel get branchInfo => _branchInfo;
  getBranchInfo() async {
    _branchInfo = await GetAllPref.branchDetail();
    notifyListeners();
  }

  String getUrl({required LinkReportEnum value}) {
    ///
    String dbName = _companyDetails.databaseName;
    String glCode = productState.outletDetail.glCode;

    ///
    switch (value) {
      ///
      case LinkReportEnum.outstandingReport:
        return "LinkReport/OutStandingReport?DbName=$dbName&FromDate=$fromDate&ToDate=$toDate&PartyCode=$glCode";

      ///
      case LinkReportEnum.agingReport:
        return "LinkReport/AgeingReport?DbName=$dbName&FromDate=$fromDate&ToDate=$toDate&Branch=&Include=&Option=None&Period=30&Slab=4&PartyCode=$glCode";

      ///
      case LinkReportEnum.ledgerwithNarration:
        return "LinkReport/AllLedgerReport?DbName=$dbName&FromDate=$fromDate&ToDate=$toDate&Branch=&Include=Details,Product,AgainstLedger,Remarks,Narration&Option=Ledger&PartyCode=$glCode";

      ///
      case LinkReportEnum.ledgerwithOutNarration:
        return "LinkReport/AllLedgerReport?DbName=$dbName&FromDate=$fromDate&ToDate=$toDate&Branch=&Include=Details,Product,AgainstLedger&Option=Ledger&PartyCode=$glCode";
    }
  }
  // String getUrl({required LinkReportEnum value}) {
  //   ///
  //   String dbName = _companyDetails.databaseName;
  //   String glCode = productState.outletDetail.glCode;

  //   ///
  //   switch (value) {
  //     ///
  //     case LinkReportEnum.outstandingReport:
  //       return "LinkReport/OutStandingReport?DbName=$dbName&FromDate=$fromDate&ToDate=$toDate&PartyCode=$glCode";

  //     ///
  //     case LinkReportEnum.agingReport:
  //       return "LinkReport/AgeingReport?DbName=$dbName&FromDate=$fromDate&ToDate=$toDate&Branch=${_branchInfo.unitCode}&Include=&Option=None&Period=30&Slab=4&PartyCode=$glCode";

  //     ///
  //     case LinkReportEnum.ledgerwithNarration:
  //       return "LinkReport/AllLedgerReport?DbName=$dbName&FromDate=$fromDate&ToDate=$toDate&Branch=${_branchInfo.unitCode}&Include=Details,Product,AgainstLedger,Remarks,Narration&Option=Ledger&PartyCode=$glCode";

  //     ///
  //     case LinkReportEnum.ledgerwithOutNarration:
  //       return "LinkReport/AllLedgerReport?DbName=$dbName&FromDate=$fromDate&ToDate=$toDate&Branch=${_branchInfo.unitCode}&Include=Details,Product,AgainstLedger&Option=Ledger&PartyCode=$glCode";
  //   }
  // }

  final List<LinkReportModel> reportLinkList = [
    LinkReportModel(
      name: "OutStanding Report",
      enumValue: LinkReportEnum.outstandingReport,
    ),
    LinkReportModel(
      name: "Ageing Report",
      enumValue: LinkReportEnum.agingReport,
    ),
    LinkReportModel(
      name: "Ledger Report Product Without Narration",
      enumValue: LinkReportEnum.ledgerwithOutNarration,
    ),
    LinkReportModel(
      name: "Ledger Report Product With Narration",
      enumValue: LinkReportEnum.ledgerwithNarration,
    ),
  ];
}
