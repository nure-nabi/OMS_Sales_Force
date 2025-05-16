import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/src/service/api/apiprovider.dart';
import 'package:oms_salesforce/src/utils/custom_log.dart';

import '../model/cash_bank_print_model.dart';
import '../model/ledger_model.dart';

class LedgerReportAPI {
  static Future apiCall({
    required String databaseName,
    required String brCode,
    required String glcode,
    required String methodName,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "MasterList/$methodName?DbName=$databaseName&GlCode=$glcode&brCode=$brCode",
    );

    CustomLog.successLog(value: "MasterList/$methodName?DbName=$databaseName&GlCode=$glcode&brCode=$brCode");


    return LedgerReportModel.fromJson(jsonData);
  }

  static Future cashBankPrint(
      {required String databaseName, required String vNo}) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "MasterList/ListCashbankPrint?dbname=$databaseName&vno=$vNo",
    );

    CustomLog.successLog(value: "RESPONSE => $jsonData");

    return CashBankPrintModel.fromJson(jsonData);
  }
}
