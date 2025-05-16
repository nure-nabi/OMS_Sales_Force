import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:oms_salesforce/src/service/sharepref/set_all_pref.dart';

import 'custom_log.dart';

class DeviceInfo1 {
  static Future getDeviceInfo() async {
    Map<String, dynamic> returnData = {
      "imei": "-",
      "macId": "-",
      "deviceName": "-",
    };
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        var deviceName = build.model;
        var identifier = "${build.id}/${build.fingerprint}"; //UUID for Android
        var imei = build.id;
        returnData = {
          "imei": imei,
          "macId": identifier,
          "deviceName": deviceName,
        };
        await SetAllPref.deviceInfo(value: "$returnData");
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        var deviceName = data.name;
        var identifier = data.identifierForVendor; //UUID for iOS

        returnData = {
          "imei": identifier,
          "macId": identifier,
          "deviceName": deviceName,
        };
        await SetAllPref.deviceInfo(value: "$returnData");
      }
    } on PlatformException {
      CustomLog.warningLog(value: "Only For Android and IOS");
    } catch (e) {
      CustomLog.errorLog(value: "$e");
    }

    return returnData;
  }
}
