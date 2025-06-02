import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/model/basic_model.dart';
import 'package:oms_salesforce/src/service/sharepref/sharepref.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../service/router/route_name.dart';
import '../savemovement/savemovement.dart';
import 'login.dart';

class LoginState extends ChangeNotifier {
  LoginState();

  late TextEditingController userNameController;
  late TextEditingController passwordController;
  late TextEditingController apiController;

  late String baseUrl;

  ///
  late BuildContext context;
  late final NavigatorState navigator = Navigator.of(context);

  set getContext(value) {
    context = value;

    ///
    init();
  }

  init() async {
    await clear();
  }

  clear() async {
    apiController = TextEditingController(text: "");
    userNameController = TextEditingController(text: "");
    passwordController = TextEditingController(text: "");

    _isLoading = false;
    _isPasswordHidden = true;

    baseUrl = await GetAllPref.apiUrl();
  }

  set getMyAPI(String value) {
    apiController.text = value.trim();
    notifyListeners();
  }

  late bool _isLoading = false, _isPasswordHidden = false;

  bool get isLoading => _isLoading;

  bool get isPasswordHidden => _isPasswordHidden;

  set showHidePassword(value) {
    _isPasswordHidden = value;
    notifyListeners();
  }

  set getLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  isOnline() async {
    await CheckNetwork.check().then((internet) async {
      if (!internet) {
        ShowToast.errorToast(msg: "No Internet Connection.");
        return;
      }

      ///
      else {
        await getLoginAPICall();
      }
    });

    notifyListeners();
  }

  permissionHandler() async {
    await MyPermission.askPermissions().then((value) async {
      if (value) {
        await isOnline();
        // await getLoginAPICall();
      } else {
        await MyPermission.askPermissions();
      }
    });
    notifyListeners();
  }

  getLoginAPICall() async {
    getLoading = true;
    CompanyModel model = await LoginAPI.login(
      username: userNameController.text.trim(),
      password: passwordController.text.trim(),
    ).onError((error, stackTrace) {
      CustomLog.warningLog(value: "ERROR $error");

      getLoading = false;
      //
      navigator.push(PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const SetAPISection(),
      ));
    });
    CustomLog.warningLog(value: "API RESPONSE => ${jsonEncode(model)}");

    if (model.statusCode == 200) {
      deviceId = model.data[0].deviceId;
      await onLoginSuccess(data: model.data);

    }
    //
    else {
      getLoading = false;
      ShowToast.errorToast(msg: model.message);
    }
  }

  String deviceId= "";
  onLoginSuccess({required List<CompanyDetailsModel> data}) async {
    await ClientListDBHelper.instance.deleteAllData();
    for (var element in data) {
      await ClientListDBHelper.instance.insertData(element);
      deviceId = element.deviceId;
    }
    await checkUserDeviceId();
    notifyListeners();
  }

  Future checkUserDeviceId() async {
    await getDeviceInfo();
    String result = extractNumber(_imei);
    if (deviceId.isEmpty) {
      BasicModel model = await LoginAPI.updateMobileNumber(
        username: userNameController.text.trim(),
        deviceId: result);
      if (model.statusCode == 200) {
        await onSuccess();
      }
    } else if (deviceId == result) {
      await onSuccess();
    } else {
      getLoading = false;
      Fluttertoast.showToast(msg:"You are no authorize user!");
    }
  }

  getCompanyFromDatabase() async {
    await ClientListDBHelper.instance.getDataList().then((value) {
      getCompanyList = value;
    });
    getLoading = false;
    notifyListeners();
  }

  onSuccess() async {
    getLoading = false;
    //
    await SetAllPref.userName(value: userNameController.text.trim());
    await SetAllPref.isLogin(value: true);
    await getCompanyFromDatabase();
    navigator.pushReplacement(PageTransition(
      type: PageTransitionType.rightToLeft,
      child: const CompanyListScreen(automaticallyImplyLeading: false),
    ));
  }

  late bool _isCompanyUpdated = false;
  bool get isCompanyUpdated => _isCompanyUpdated;
  set getIsCompanyUpdate(bool value) {
    _isCompanyUpdated = value;
    notifyListeners();
  }

  Future apiForUpdateAgentCode(
    context, {
    required CompanyDetailsModel selectedCompany,
    required bool automaticallyImplyLeading,
  }) async {
    getIsCompanyUpdate = true;
    CompanyModel model = await LoginAPI.updateAgentCode(
      username: await GetAllPref.userName(),
      dbName: selectedCompany.databaseName,
    );
    if (model.statusCode == 200) {
      getIsCompanyUpdate = false;
      CompanyDetailsModel updateData = await updateCompanyData(
        selectedCompany,
        model.data,
      );
      await updateSharePrefAndNavigate(
        context,
        detailsModel: updateData,
        automaticallyImplyLeading: automaticallyImplyLeading,
      );
    } else {
      getIsCompanyUpdate = false;
      ShowToast.errorToast(msg: model.message);
    }

    notifyListeners();
  }

  Future<CompanyDetailsModel> updateCompanyData(
    CompanyDetailsModel loginResponse,
    List<CompanyDetailsModel> agentCodeResponse,
  ) async {
    CompanyDetailsModel updateValue = CompanyDetailsModel.fromJson({});
    if (agentCodeResponse.isNotEmpty) {
      for (var element in agentCodeResponse) {
        updateValue = CompanyDetailsModel(
          userCode: loginResponse.userCode,
          loginName: loginResponse.loginName,
          password: loginResponse.password,
          userName: loginResponse.userName,
          createDateTime: loginResponse.createDateTime,
          isEnabled: loginResponse.isEnabled,
          databaseName: loginResponse.databaseName,
          companyName: loginResponse.companyName,
          panNo: loginResponse.panNo,
          deviceId: loginResponse.deviceId,
          agentCode: element.agentCode,
          userType: loginResponse.userType,
          createdBy: loginResponse.createdBy,
          createdDate: loginResponse.createdDate,
        );
      }
      return updateValue;
    }
    //
    else {
      return updateValue;
    }
  }

  updateSharePrefAndNavigate(
    BuildContext context, {
    required CompanyDetailsModel detailsModel,
    required bool automaticallyImplyLeading,
  }) async {
    late final NavigatorState navigator = Navigator.of(context);

    //final state = context.watch()<BranchState>();

 // late  BranchState state= Provider.of<BranchState>(context,listen: false).getContext = context;



    await SetAllPref.companySelected(value: true);
    await SetAllPref.companyDetail(value: detailsModel);
    CompanyDetailsModel value = await GetAllPref.companyDetail();

    CustomLog.errorLog(value: "\n\n\n\n\n${jsonEncode(value)}");

    if (context.mounted) {
      Provider.of<SaveMovementState>(context, listen: false)
          .saveMovementToDatabase(
        message: automaticallyImplyLeading == false
            ? 'Login And Company Selected Success'
            : 'Company Switched.',
      );
    }

    // Fluttertoast.showToast(msg: state.branchList.length.toString());
    // if(state.branchList.length > 0){
    //   return navigator.pushReplacementNamed(homePagePath);
    // }else{
      return navigator.pushReplacementNamed(branchPath);
  //  }


  }


  late List<CompanyDetailsModel> _companyList = [];
  List<CompanyDetailsModel> get companyList => _companyList;
  set getCompanyList(List<CompanyDetailsModel> value) {
    _companyList = value;
    notifyListeners();
  }

  String _imei="";
  String _macId="";
  String _deviceName="";
  getDeviceInfo() async {
    await DeviceInfo1.getDeviceInfo().then((value) {
       _imei = value["imei"];
       _macId = value["macId"];
       _deviceName = value["deviceName"];
    });
    CustomLog.actionLog(
    value: "{imei: $_imei, macId: $_macId, deviceName: $_deviceName}");
    notifyListeners();
  }
  String extractNumber(String input) {
    final RegExp regExp = RegExp(r'\d+');
    final Iterable<Match> matches = regExp.allMatches(input);
    return matches.map((m) => m.group(0)).join('');
  }

}
