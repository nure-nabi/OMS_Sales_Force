import 'dart:convert';

import 'package:oms_salesforce/model/basic_model.dart';
import 'package:oms_salesforce/src/service/api/api.dart';
import 'package:oms_salesforce/src/utils/utils.dart';

import 'model/leave_report_model.dart';
import 'model/leave_type_model.dart';

class LeaveNotesAPI {
  static Future getLeaveType(
      {required String databaseName, required String agentCode}) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "MasterList/SalesmanLeaveTypeList?DbName=$databaseName&SalesManId=$agentCode",
    );

    return LeaveTypeModel.fromJson(jsonData);
  }

  static Future getLeaveReport({
    required String databaseName,
    required String agentCode,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "MasterList/LeaveReport?DbName=$databaseName&AgentCode=$agentCode",
    );

    return LeaveReportModel.fromJson(jsonData);
  }

  static Future createLeaveNotes({
    required String databaseName,
    required String agentCode,
    required String dateFrom,
    required String dateTo,
    required String noOfDays,
    required String leaveTypeId,
    required String reason,
    required String memo,
  }) async {
    var body = jsonEncode({
      "objLeaveEntry": [
        {
          "DbName": databaseName,
          "DateFrom": dateFrom,
          "DateTo": dateTo,
          "AgentCode": agentCode,
          "Noofdays": noOfDays,
          "LeaveTypeId": leaveTypeId,
          "Reason": reason,
          "Memo": memo
        }
      ]
    });

    CustomLog.actionLog(value: "\n\n BODY => $body \n\n");

    //
    var jsonData = await APIProvider.postAPI(
      endPoint: "User/SaveleaveEntry",
      body: body,
    );
    return BasicModel.fromJson(jsonData);
  }
}
