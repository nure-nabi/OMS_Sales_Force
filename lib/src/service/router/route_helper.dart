import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/allreports/allreports.dart';
import 'package:oms_salesforce/src/core/allreports/questions/ui/questions_screen.dart';
import 'package:oms_salesforce/src/core/coverageandproductivity/coverage_productivity_screen.dart';
import 'package:oms_salesforce/src/core/deliveryreport/deliveryreport.dart';
import 'package:oms_salesforce/src/core/homepage/homepage.dart';
import 'package:oms_salesforce/src/core/leavenotes/leavenotes_screen.dart';
import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:oms_salesforce/src/core/productavailabilityreport/product_availability_product_screen.dart';
import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/core/quickorder/quickorder.dart';
import 'package:oms_salesforce/src/core/settings/setting_screen.dart';
import 'package:oms_salesforce/src/core/splash/splash.dart';
import 'package:oms_salesforce/src/core/targetandachivement/targetandachivement.dart';
import 'package:page_transition/page_transition.dart';

import '../../core/allreports/save_product_availability/save_product_availability.dart';
import '../../core/orderreport/orderreport.dart';
import '../../core/outletvisit/outletvisit.dart';
import '../../core/pendingsync/pendingsync.dart';
import '../../core/pendingverify/pendingverify.dart';
import '../../core/productavailabilityreport/product_list.dart';
import '../../core/productorder/productorder.dart';
import '../../core/todo/todo.dart';
import '../../core/top_buying/top_buying.dart';
import 'route_name.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SplashScreen(),
        );
      case loginPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const LoginScreen(),
        );
      case branchPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const BranchScreen(),
        );
      case homePagePath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const HomePage(),
        );

      ///
      case leaveNotePath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const LeaveNotesScreen(),
        );
      case quickOrderPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const QuickOrderScreen(),
        );
      case quickOrderOultetListPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const OutletListScreen(),
        );
      case orderConfirmPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const OrderConfirmSection(),
        );
      case addOutletPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const AddOutletScreen(),
        );

      ///
      case productGroupListPath:
        FilterOutletInfoModel value =
            settings.arguments as FilterOutletInfoModel;
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: ProductScreen(outletDetails: value),
        );
      case productListPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const ProductListScreen(),
        );
      case productListAvailabilityScreen:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const ProductListAvailabilityScreen(),
        );
      ///
      case pendingSyncPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const PendingSyncScreen(),
        );
      case pendingVerifyPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const PendingVerifyScreen(),
        );
      case coverageProductivityPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const CoverageProductivityScreen(),
        );
      case targetAndAchivementPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const TargetAndAchivementScreen(),
        );
      case deliveryReportPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const DeliveryReportScreen(),
        );
      case deliveryOutletSectionPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const DeliveryOutletSection(),
        );

      /// ALL REPORT
      case salesHistoryPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SalesHistoryScreen(),
        );
      case ledgerReportPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const LedgerReportScreen(),
        );
      case pdcReportPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const PDCScreen(),
        );
      case pdcEntriesPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const PDCEntriesScreen(),
        );

      ///
      case saveJournalPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SaveJournalScreen(),
        );
      case saveNotesPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SaveLedgerNotesScreen(),
        );
      case salesReturnPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SalesReturnScreen(),
        );
      case linkReportPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const ReportLinkScreen(),
        );

      ///
      case settingPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SettingScreen(),
        );
      case orderReportPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const OrderReportScreen(),
        );
      case questionPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const QuestionScreen(),
        );
      case topBuyingPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const TopBuyingScreen(),
        );
      case todoList:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const TodoScreen(),
        );
      case todoFromPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const TodoFromScreen(),
        );
      case outletVisitPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const OutletVisitScreen(),
        );
      case saveProductAvailabilityPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SaveProductAvailabilityScreen(),
        );

      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return PageTransition(
      type: PageTransitionType.rightToLeft,
      child: Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('ERROR ROUTE')),
      ),
    );
  }
}
