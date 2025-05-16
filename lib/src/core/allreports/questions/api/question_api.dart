import 'package:oms_salesforce/src/service/api/apiprovider.dart';

import '../model/question_model.dart';
import '../model/question_report_model.dart';

class QuestionAPI {
  static Future getQuestion({required String databaseName}) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "MasterList/Question?DbName=$databaseName",
    );

    return QuestionModel.fromJson(jsonData);
  }

  static Future getQuestionReports(
      {required String databaseName, required String glCode}) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "MasterList/QuestionReport?DbName=$databaseName&Glcode=$glCode",
    );

    return QuestionReportModel.fromJson(jsonData);
  }

  static Future postAnswerToQuestion({
    required String databaseName,
    required String questionCode,
    required String answer,
    required String glCode,
    required String agentCode,
    required String userCode,
    required String lat,
    required String lng,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "MasterList/QuestionAnswer?DbName=$databaseName&Qcode=$questionCode&Answer=$answer&Glcode=$glCode&AgentCode=$agentCode&usercode=$userCode&Lat=$lat&Lng=$lng",
    );

    return QuestionModel.fromJson(jsonData);
  }
}
