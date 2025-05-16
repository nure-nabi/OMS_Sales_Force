import 'package:oms_salesforce/src/service/api/api.dart';

import '../../../utils/utils.dart';
import '../model/assign_user_model.dart';
import '../model/create_activity_model.dart';
import '../model/ledger_model.dart';
import '../todo.dart';

class ToDoAPI {
  static Future todoData({
    required String databaseName,
    required String glCode,
    required String agentCode,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "Masterlist/ToDoList?dbname=$databaseName&glcode=$glCode&Agentcode=$agentCode",
    );

    return TodoModel.fromJson(jsonData);
  }

  static Future getAssignToUser({required String databaseName}) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "Masterlist/TodoUserList?dbname=$databaseName",
    );

    return TodoUserAssignModel.fromJson(jsonData);
  }

  static Future getLedgerList({required String databaseName}) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "generalledger/LedgerList?dbname=$databaseName",
    );

    return TodoLedgerModel.fromJson(jsonData);
  }

  static Future todoActivityData({
    required String databaseName,
    required String glCode,
    required String agentCode,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "MasterList/todoActivity?DbName=$databaseName&glcode=$glCode&Agentcode=$agentCode",
    );

    CustomLog.actionLog(value: "JSON RESPONSE => $jsonData");

    return TodoActivityModel.fromJson(jsonData);
  }

  static Future createToDo({
    required String databaseName,
    required String frequencyType,
    required String description,
    required String todoItems,
    required String priorityLevel,
    required String createdBy,
    required String assignedBy,
    required String assignedTo,
    required String fromDate,
    required String toDate,
    required String taskStatus,
    required String closedStatus,
    required String closedBy,
    required String closedDate,
    required String glDesc,
    required String glCode,
    required String agentDesc,
    required String agentCode,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "Masterlist/TodolistEntry?dbname=$databaseName&FrequencyType=$frequencyType&Description=$description&ToDoItems=$todoItems&PriorityLevel=$priorityLevel&CreatedBy=$createdBy&AssignedBy=$assignedBy&AssignedTo=$assignedTo&FromDate=$fromDate&ToDate=$toDate&TaskStatus=$taskStatus&ClosedStatus=$closedStatus&ClosedBy=$closedBy&ClosedDate=$closedDate&Gldesc=$glDesc&GlCode=$glCode&AgentDesc=$agentDesc&AgentCode=$agentCode",
    );

    CustomLog.actionLog(value: "JSON RESPONSE => $jsonData");

    return CreateActivityModel.fromJson(jsonData);
  }
}
