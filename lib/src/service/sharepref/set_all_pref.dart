import 'dart:convert';

import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:oms_salesforce/src/utils/custom_log.dart';

import 'sharepref.dart';

class SetAllPref {
  static baseURL({required String value}) async {
    await SharedPref.setData(
      key: PrefText.apiUrl,
      dValue: value,
      type: "String",
    );
  }

  static imageURL({required String value}) async {
    CustomLog.warningLog(value: "\n\nIMAGE URL => $value");
    await SharedPref.setData(
      key: PrefText.imageURL,
      dValue: value,
      type: "String",
    );
  }

  static userName({required String value}) async {
    await SharedPref.setData(
      key: PrefText.userName,
      dValue: value,
      type: "String",
    );
  }

  static unitCode({required String value}) async {
    await SharedPref.setData(
      key: PrefText.unitCode,
      dValue: value,
      type: "String",
    );
  }

  static isLogin({required bool value}) async {
    await SharedPref.setData(
      key: PrefText.loginSuccess,
      dValue: value,
      type: "bool",
    );
  }

  static companySelected({required bool value}) async {
    await SharedPref.setData(
      key: PrefText.companySelected,
      dValue: value,
      type: "bool",
    );
  }

  static companyDetail({required CompanyDetailsModel value}) async {
    await SharedPref.setData(
      key: PrefText.companyDetail,
      dValue: jsonEncode(value),
      type: "String",
    );
  }

  static branchDetail({required BranchDataModel value}) async {
    await SharedPref.setData(
      key: PrefText.branchDetail,
      dValue: jsonEncode(value),
      type: "String",
    );
  }



  static branchDetails({required BranchModelAgent value}) async {
    await SharedPref.setData(
      key: PrefText.branchDetail,
      dValue: jsonEncode(value),
      type: "String",
    );
  }



  static setBranchCode({required String value}) async {
    await SharedPref.setData(
      key: PrefText.setBranchCode,
      dValue: value,
      type: "String",
    );
  }

  static deviceInfo({required String value}) async {
    await SharedPref.setData(
      key: PrefText.deviceInfo,
      dValue: value,
      type: "String",
    );
  }


  static deviceInfo1({required String value}) async {
    await SharedPref.setData(
      key: PrefText.deviceInfo,
      dValue: value,
      type: "String",
    );
  }

  static smartOrderOption({required bool value}) async {
    await SharedPref.setData(
      key: PrefText.smartOrderOption,
      dValue: value,
      type: "bool",
    );
  }
  static setWhenHaveListDb({required bool value}) async {
    await SharedPref.setData(
      key: PrefText.setWhenHaveListDb,
      dValue: value,
      type: "bool",
    );
  }
  static setWhenHaveListDbPending({required bool value}) async {
    await SharedPref.setData(
      key: PrefText.setWhenHaveListDbPending,
      dValue: value,
      type: "bool",
    );
  }
  static setTempCode({required String value}) async {
    await SharedPref.setData(
      key: PrefText.setTempCode,
      dValue: value,
      type: "String",
    );
  }

  static setDate({required String value}) async {
    await SharedPref.setData(
      key: PrefText.setDate,
      dValue: value,
      type: "String",
    );
  }

  static setBranch({required String value}) async {
    await SharedPref.setData(
      key: PrefText.setBranch,
      dValue: value,
      type: "String",
    );
  }

  static setBranchName({required String value}) async {
    await SharedPref.setData(
      key: PrefText.setBranchName,
      dValue: value,
      type: "String",
    );
  }
  static setOutLetName({required String value}) async {
    await SharedPref.setData(
      key: PrefText.setOutLetName,
      dValue: value,
      type: "String",
    );
  }
  static setProductName({required String value}) async {
    await SharedPref.setData(
      key: PrefText.productName,
      dValue: value,
      type: "String",
    );
  }
}
