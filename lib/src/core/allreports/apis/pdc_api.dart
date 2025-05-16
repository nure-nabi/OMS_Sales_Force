import 'package:oms_salesforce/src/service/api/api.dart';

import '../model/bank_model.dart';
import '../model/pdc_model.dart';
import '../model/pdf_bounce_cheque_model.dart';
import '../model/pdf_print_model.dart';

class PDCReportAPI {
  static Future getBankList({required String databaseName}) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "MasterList/ListBank?DbName=$databaseName",
    );
    return BankModel.fromJson(jsonData);
  }

  static Future apiCall({
    required String databaseName,
    required String glCode,
    required String agentCode,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "MasterList/DuePdcList1?DbName=$databaseName&Glcode=$glCode&AgentCode=$agentCode",
    );

    return PDCReportModel.fromJson(jsonData);
  }

  static Future apiCallfromBounceList({
    required String databaseName,
    required String glCode,
    required String agentCode,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "MasterList/PdcBounce?DbName=$databaseName&Glcode=$glCode&AgentCode=$agentCode",
    );

    return PdcBounceModel.fromJson(jsonData);
  }

  static Future pdcPrint({
    required String databaseName,
    required String vNo,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "MasterList/ListPDCPrint?DbName=$databaseName&Vno=$vNo",
    );

    return PdcPrintModel.fromJson(jsonData);
  }
}
