import 'package:flutter/material.dart';
import 'package:oms_salesforce/config/app_detail.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import 'splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<SplashState>(context, listen: false).getContext = context;
    return Consumer<SplashState>(
      builder: (context, state, child) {
        return GredientContainer(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppDetails.organizeBy,
                style: subTitleTextStyle.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            body: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Image.asset(
                        AssetsList.appIcon,
                        width: 90.0,
                      ),
                    ),
                  ),
                  verticalSpace(10),
                  Text(
                    AppDetails.appName,
                    textAlign: TextAlign.center,
                    style: appDetailText,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
