import 'package:flutter/cupertino.dart';
import 'package:oms_salesforce/src/core/quickorder/quickorder.dart';
import 'package:oms_salesforce/src/enum/enum.dart';
import 'package:oms_salesforce/src/utils/custom_log.dart';
import 'package:provider/provider.dart';

import 'route_name.dart';

class NavigationHelper {
  BuildContext context;
  NavigationHelper(this.context);

  ///
  indexNavigation({required HomePageGridEnum indexEnum}) async {
    CustomLog.actionLog(value: "Clicked Value => $indexEnum");
    try {
      switch (indexEnum) {
        case HomePageGridEnum.addLeave:
          Navigator.pushNamed(context, leaveNotePath);
          break;
        case HomePageGridEnum.quickOrder:
          context.read<QuickOrderState>().getIsAreaShow = true;
          Navigator.pushNamed(context, quickOrderPath);
          break;
        case HomePageGridEnum.smartOrder:
          context.read<QuickOrderState>().getIsAreaShow = false;
          context.read<QuickOrderState>().veriableClear();
          context.read<QuickOrderState>().listClear();
          context.read<QuickOrderState>().init();
          Navigator.pushNamed(context, quickOrderOultetListPath);
          await context.read<QuickOrderState>().getOutletListFromDB();
          break;
        case HomePageGridEnum.pendingSync:
          Navigator.pushNamed(context, pendingSyncPath);
          break;
        case HomePageGridEnum.pendingVerify:
          Navigator.pushNamed(context, pendingVerifyPath);
          break;
        case HomePageGridEnum.targetAndAchivement:
          Navigator.pushNamed(context, targetAndAchivementPath);
          break;
        case HomePageGridEnum.coverageAndProductivity:
          Navigator.pushNamed(context, coverageProductivityPath);
          break;
        case HomePageGridEnum.deliveredReport:
          Navigator.pushNamed(context, deliveryReportPath);
          break;
        case HomePageGridEnum.orderReport:
          Navigator.pushNamed(context, orderReportPath);
          break;
        case HomePageGridEnum.movementGps:
          //
          break;
        case HomePageGridEnum.activityGps:
          //
          break;
        case HomePageGridEnum.topBuying:
          Navigator.pushNamed(context, topBuyingPath);
          break;
      }
    } catch (e) {
      CustomLog.errorLog(value: "Error Catch on Navigation => $e ");
    }
  }
}
