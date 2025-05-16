import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/src/service/router/route_name.dart';
import 'package:oms_salesforce/src/service/sharepref/sharepref.dart';
import 'package:provider/provider.dart';

import '../homepage/home_state.dart';

class SplashState extends ChangeNotifier {
  SplashState();

  late BuildContext _context;
  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(_context);
  set getContext(BuildContext value) {
    _context = value;
    ///
    init();
  }

  init() async {
    await startTimer();
  }

  startTimer() {
    Future.delayed(const Duration(seconds: 2), () async {
      await navigateUser();
    });
  }

  navigateUser() async {
   // final state = Provider.of<HomeState>(context,listen: false);
    bool login = await GetAllPref.checkLogin();
    bool companySelected = await GetAllPref.checkCompanySelected();

    if (!login) {
      return navigator.pushReplacementNamed(loginPath);
    }
    //
    else if (!companySelected) {
      return navigator.pushReplacementNamed(loginPath);
    }
    //
    return navigator.pushReplacementNamed(homePagePath);
  }
}
