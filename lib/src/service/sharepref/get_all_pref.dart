import 'dart:convert';

import 'package:oms_salesforce/src/core/login/login.dart';

import 'pref_text.dart';
import 'share_preference.dart';

class GetAllPref {
  static checkLogin() async {
    return await SharedPref.getData(
      key: PrefText.loginSuccess,
      dValue: false,
      type: "bool",
    );
  }

  static checkCompanySelected() async {
    return await SharedPref.getData(
      key: PrefText.companySelected,
      dValue: false,
      type: "bool",
    );
  }

  static userName() async {
    return await SharedPref.getData(
      key: PrefText.userName,
      dValue: "-",
      type: "String",
    );
  }
  static unitCode() async {
    return await SharedPref.getData(
      key: PrefText.unitCode,
      dValue: "-",
      type: "String",
    );
  }

  static apiUrl() async {
    return await SharedPref.getData(
      key: PrefText.apiUrl,
      dValue: "-",
      type: "String",
    );
  }

  static imageURL() async {
    return await SharedPref.getData(
      key: PrefText.imageURL,
      dValue: "-",
      type: "String",
    );
  }

  static Future<CompanyDetailsModel> companyDetail() async {
    String value = await SharedPref.getData(
      key: PrefText.companyDetail,
      dValue: "ERROR",
      type: "String",
    );
    if (value != "-") {
      Map<String, dynamic> userAuthData = jsonDecode(value);
      return CompanyDetailsModel.fromJson(userAuthData);
    } else {
      return CompanyDetailsModel.fromJson({});
    }
  }

  static Future<BranchDataModel> branchDetail() async {
    String value = await SharedPref.getData(
      key: PrefText.branchDetail,
      dValue: "ERROR",
      type: "String",
    );
    if (value != "-") {
      Map<String, dynamic> userAuthData = jsonDecode(value);
      return BranchDataModel.fromJson(userAuthData);
    } else {
      return BranchDataModel.fromJson({});
    }
  }

  static getBranchCode() async {
    await SharedPref.setData(
      key: PrefText.setBranchCode,
      dValue: "-",
      type: "String",
    );
  }

  static deviceInfo() async {
    await SharedPref.setData(
      key: PrefText.deviceInfo,
      dValue: "-",
      type: "String",
    );
  }

  static smartOrderOption() async {
    return await SharedPref.getData(
      key: PrefText.smartOrderOption,
      dValue: false,
      type: "bool",
    );
  }

  static getWhenHaveListDb() async {
    return await SharedPref.getData(
      key: PrefText.setWhenHaveListDb,
      dValue: false,
      type: "bool",
    );
  }
  static getWhenHaveListDbPending() async {
    return await SharedPref.getData(
      key: PrefText.setWhenHaveListDbPending,
      dValue: false,
      type: "bool",
    );
  }

  static getTempCode() async {
    return await SharedPref.getData(
      key: PrefText.setTempCode,
      dValue: "-",
      type: "String",
    );
  }

  static getDate() async {
    return await SharedPref.getData(
      key: PrefText.setDate,
      dValue: "-",
      type: "String",
    );
  }
  static getBranch() async {
    return await SharedPref.getData(
      key: PrefText.setBranch,
      dValue: "null",
      type: "String",
    );
  }

  static getBranchName() async {
    return await SharedPref.getData(
      key: PrefText.setBranchName,
      dValue: "-",
      type: "String",
    );
  }

  static getOutLetName() async {
    return await SharedPref.getData(
      key: PrefText.setOutLetName,
      dValue: "-",
      type: "String",
    );
  }
  static getOutLetCode() async {
    return await SharedPref.getData(
      key: PrefText.setOutLetCode,
      dValue: "-",
      type: "String",
    );
  }

  static getProductName() async {
    return await SharedPref.getData(
      key: PrefText.productName,
      dValue: "-",
      type: "String",
    );
  }
}
