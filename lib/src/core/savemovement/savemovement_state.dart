import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/model/model.dart';
import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:oms_salesforce/src/core/savemovement/api/savemovement_api.dart';
import 'package:oms_salesforce/src/core/savemovement/db/savemovement_db.dart';
import 'package:oms_salesforce/src/service/sharepref/sharepref.dart';
import 'package:oms_salesforce/src/utils/utils.dart';

import 'model/savemovement_model.dart';

class SaveMovementState extends ChangeNotifier {
  SaveMovementState();

  late BuildContext _context;

  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(_context);

  set getContext(BuildContext value) {
    _context = value;
  }

  late bool _isLoading = false;

  bool get isLoading => _isLoading;

  set getLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  init() async {
    await clean();
  }

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});

  CompanyDetailsModel get companyDetail => _companyDetail;

  set getCompanyDetail(CompanyDetailsModel value) {
    _companyDetail = value;
    notifyListeners();
  }

  clean() async {
    _isLoading = false;

    ///
    _movementData = SaveMovementModel.fromJson({});
    getCompanyDetail = await GetAllPref.companyDetail();
  }

  late List<SaveMovementModel> _movementList = [];

  List<SaveMovementModel> get movementList => _movementList;

  set getMovementList(List<SaveMovementModel> value) {
    _movementList = [];
    _movementList = value;
    notifyListeners();
  }

  late SaveMovementModel _movementData = SaveMovementModel.fromJson({});

  SaveMovementModel get movementData => _movementData;

  set getMovementData(SaveMovementModel value) {
    _movementData = value;
    notifyListeners();
  }

  saveMovementToDatabase({required String message}) async {
    await init();

    ///
    _movementData = SaveMovementModel(
      lat: await MyLocation().lat(),
      long: await MyLocation().long(),
      timestamp: await MyTimeConverter.getTimeStamp(),
      activity: message,
    );
    await MovementDatabase.instance.insertData(_movementData);
    notifyListeners();
  }

  getMovementFromDatabase() async {
    await MovementDatabase.instance.getLocalMovementData().then((value) {
      getMovementList = value;
    });
    notifyListeners();
  }

  allMovementData() async {
    String movementData = "";
    List<SaveMovementModel> n = _movementList;
    movementData = "";
    movementData += "[";
    if (n.isNotEmpty) {
      for (int i = 0; i < n.length; i++) {
        if (i < (n.length - 1)) {
          movementData +=
              '{ "DbName": "${_companyDetail.databaseName}","SalesmanId": "${_companyDetail.agentCode}","UserName": "${_companyDetail.userName}","Lat": "${n[i].lat}","Lng": "${n[i].long}","Action": "${n[i].activity}","Timestamp": "${n[i].timestamp}" },';
        } else {
          movementData +=
              '{ "DbName": "${_companyDetail.databaseName}","SalesmanId": "${_companyDetail.agentCode}","UserName": "${_companyDetail.userName}","Lat": "${n[i].lat}","Lng": "${n[i].long}","Action": "${n[i].activity}","Timestamp": "${n[i].timestamp}" }';
        }
      }
    }
    movementData += "]";

    CustomLog.successLog(value: "Movement Data =>  $movementData");
    return jsonDecode(movementData);
  }

  postMovementToServer() async {
    getCompanyDetail = await GetAllPref.companyDetail();
    await getMovementFromDatabase();
    BasicModel modelData =
        await SaveMovementAPI.saveMovement(bodyData: await allMovementData());
    if (modelData.statusCode == 200) {
      debugPrint("SUCCESS");
      await MovementDatabase.instance.deleteData();
    } else {
      debugPrint("ERROR");
    }
    notifyListeners();
  }
}
