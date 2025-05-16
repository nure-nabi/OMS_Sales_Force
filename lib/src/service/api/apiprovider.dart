import 'dart:io';

import 'package:dio/dio.dart';

import '../../constant/constant.dart';
import '../../utils/custom_log.dart';
import '../sharepref/get_all_pref.dart';

class APIProvider {
  static Future<Map<String, dynamic>> _handleError(dynamic e) {
    if (e is SocketException) {
      return Future.value(ConstantAPIText.errorNetworkMap);
    } else {
      return Future.value(ConstantAPIText.errorMap);
    }
  }

  static Future<Map<String, dynamic>> _makeRequest({
    required String endPoint,
    required String method,
    dynamic body,
  }) async {
    final String api = await GetAllPref.apiUrl() + endPoint;
    final headers = {'Content-Type': 'application/json'};

    try {
      final Response response = await Dio().request(
        api.trim(),
        data: body,
        options: Options(headers: headers, method: method),
      );

      _logRequest(method, api, headers, body, response.data);

      return response.data;
    } on DioException catch (e) {
      _logRequest(method, api, headers, body, e);
      return _handleError(e);
    }
  }

  static Future<Map<String, dynamic>> getAPI({required String endPoint}) async {
    return _makeRequest(endPoint: endPoint, method: 'GET');
  }

  static Future<Map<String, dynamic>> postAPI({
    required String endPoint,
    required String body,
  }) async {
    return _makeRequest(endPoint: endPoint, method: 'POST', body: body);
  }

  static void _logRequest(
    String method,
    String api,
    Map<String, String> headers,
    dynamic body,
    dynamic response,
  ) {
    CustomLog.actionLog(value: "\n");
    CustomLog.errorLog(value: "METHOD   : [$method]");
    CustomLog.warningLog(value: "API      : [$api]");
    CustomLog.warningLog(value: "BODY     : $body");
    CustomLog.actionLog(value: "HEADER   : $headers");
    CustomLog.successLog(value: "RESPONSE : $response");
    CustomLog.actionLog(value: "\n");
  }
}

