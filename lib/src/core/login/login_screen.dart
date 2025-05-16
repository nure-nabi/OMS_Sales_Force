


import 'package:device_imei/device_imei.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/config/app_detail.dart';
import 'package:oms_salesforce/src/constant/constant.dart';
import 'package:oms_salesforce/src/service/sharepref/set_all_pref.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../homepage/home_state.dart';
import 'login_state.dart';
import 'setapi/setapi_screen.dart';

import 'package:permission_handler/permission_handler.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    compareDates();
    Provider
        .of<LoginState>(context, listen: false)
        .getContext = context;
  }

  final _deviceImeiPlugin = DeviceImei();

  void compareDates() async{
  //  final state = context.watch<HomeState>();
    // Get today's date
    DateTime today = DateTime.now();

    // Get yesterday's date
    DateTime yesterday = today.subtract(Duration(days: 1));

    await SetAllPref.setDate(value: "5");

    // Compare the dates
    if (yesterday.isBefore(today)) {
      print("Yesterday's date (${yesterday.toLocal()}) is before today's date (${today.toLocal()}).");
    } else if (yesterday.isAfter(today)) {
      print("Yesterday's date (${yesterday.toLocal()}) is after today's date (${today.toLocal()}).");
    } else {
      print("Yesterday's date (${yesterday.toLocal()}) is the same as today's date (${today.toLocal()}).");
    }
  }

  onBack() async {
    return SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return onBack();
      },
      child: Consumer<LoginState>(
        builder: (BuildContext context, state, Widget? child) {
          return Stack(
            children: [
              GredientContainer(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  ///
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    centerTitle: true,
                    title: Text(
                      AppDetails.appName,
                      style: titleTextStyle,
                    ),
                  ),

                  ///
                  body: Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Stack(alignment: Alignment.topCenter, children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 15.0),
                          margin: const EdgeInsets.only(top: 40.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Form(
                            key: loginKey,
                            child: SingleChildScrollView(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 20.0),
                                    TextFormField(
                                      controller: state.userNameController,
                                      decoration: InputDecoration(
                                        counter: const Offstage(),
                                        hintText: 'Enter Username',
                                        hintStyle: hintTextStyle,
                                        labelText: 'Username',
                                        labelStyle: labelTextStyle,
                                      ),
                                      maxLength: 10,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      onChanged: (text) {
                                        loginKey.currentState!.validate();
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return '* required';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    TextFormField(
                                      controller: state.passwordController,
                                      obscureText: state.isPasswordHidden,
                                      decoration: InputDecoration(
                                        counter: const Offstage(),
                                        suffixIcon: (state.isPasswordHidden)
                                            ? GestureDetector(
                                                onTap: () {
                                                  state.showHidePassword =
                                                      false;
                                                },
                                                child: const Icon(
                                                    Icons.visibility),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  state.showHidePassword = true;
                                                },
                                                child: const Icon(
                                                    Icons.visibility_off),
                                              ),
                                        hintText: 'Enter password',
                                        hintStyle: hintTextStyle,
                                        labelText: 'Password',
                                        labelStyle: labelTextStyle,
                                      ),
                                      maxLength: 10,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      onChanged: (text) {
                                        loginKey.currentState!.validate();
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return '* required';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 15.0),
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (loginKey.currentState!.validate()) {
                                          // await isOnline();
                                          await state.permissionHandler();
                                        }
                                      },
                                      child: const Text("LOGIN"),
                                    ),
                                    const Text(
                                      "OR",
                                      style: labelTextStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Colors.grey.shade500,
                                        ),
                                      ),
                                      onPressed: () {
                                        state.apiController.text = "";

                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: const SetAPISection(),
                                          ),
                                        );
                                      },
                                      child: const Text("Click Set API"),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 20.0,
                          shape: const CircleBorder(),
                          clipBehavior: Clip.antiAlias,
                          child: CircleAvatar(
                            maxRadius: 40.0,
                            backgroundImage: AssetImage(
                              AssetsList.appIcon,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),

              ///
              if (state.isLoading) Center(child: LoadingScreen.loadingScreen())
            ],
          );
        },
      ),
    );
  }
}
