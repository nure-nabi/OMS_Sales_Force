import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/service/sharepref/set_all_pref.dart';
import 'package:oms_salesforce/src/utils/show_toast.dart';

import '../../../service/router/route_name.dart';

class SetAPIState extends ChangeNotifier {
  SetAPIState();

  late BuildContext _context;
  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(_context);
  set getContext(BuildContext value) {
    _context = value;

    ///
    init();
  }

  late bool _isLoading = false;
  bool get isLoading => _isLoading;
  set getLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  late bool _isShowConfirmHost = false;
  bool get isShowConfirmHost => _isShowConfirmHost;
  set isShowConfirmHost(bool value) {
    _isShowConfirmHost = value;
    notifyListeners();
  }

  init() async {
    await clean();
  }

  clean() async {
    _isLoading = false;
    _isShowConfirmHost = false;

    _hostController = TextEditingController(text: "");
    _confirmHostController = TextEditingController(text: "");
    _selectedDomain = "";
  }

  ///
  late final GlobalKey<FormState> _hostKey = GlobalKey<FormState>();
  GlobalKey<FormState> get hostKey => _hostKey;
  late TextEditingController _hostController = TextEditingController(text: "");
  TextEditingController get hostController => _hostController;

  ///
  late TextEditingController _confirmHostController =
      TextEditingController(text: "");
  TextEditingController get confirmHostController => _confirmHostController;
  late final TextEditingController _confirmLinkController =
      TextEditingController(text: "");
  TextEditingController get confirmLinkController => _confirmLinkController;

  //
  final myDomainList = [
    'globaltechsolution.com.np',
    'globaltech.com.np',
    'omsird.com',
    'karmacharyagroup.com',
    'globaltechnepal.com',
    'omsnepal.com'
  ];

  late String _selectedDomain = "";
  String get selectedDomain => _selectedDomain;
  set getMyDomain(String value) {
    _selectedDomain = value;
    notifyListeners();
  }

  checkHost() {
    FocusManager.instance.primaryFocus?.unfocus();
    _isShowConfirmHost = true;
    _confirmHostController.text =
        "http://${hostController.text.trim()}.$_selectedDomain:802/api/";

    _confirmLinkController.text = _confirmHostController.text
        .replaceAll("api", "")
        .replaceAll(":802/", "");

    ///
    notifyListeners();
  }

  Future setAPI() async {
    await SetAllPref.baseURL(value: _confirmHostController.text.trim());
    await SetAllPref.imageURL(value: _confirmLinkController.text.trim());
    ShowToast.successToast(msg: "API Set Successfully");

    navigator.pushNamedAndRemoveUntil(
        loginPath, (Route<dynamic> route) => false);

    notifyListeners();
  }
}
