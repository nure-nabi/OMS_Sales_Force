import 'package:oms_salesforce/src/core/allreports/allreports.dart';
import 'package:oms_salesforce/src/core/allreports/questions/questions.dart';
import 'package:oms_salesforce/src/core/bill_by_vno/bill_by_vno.dart';
import 'package:oms_salesforce/src/core/coverageandproductivity/coverageandproductivity.dart';
import 'package:oms_salesforce/src/core/datepicker/datepicker.dart';
import 'package:oms_salesforce/src/core/deliveryreport/deliveryreport.dart';
import 'package:oms_salesforce/src/core/leavenotes/leavenotes_state.dart';
import 'package:oms_salesforce/src/core/orderreport/order_report_state.dart';
import 'package:oms_salesforce/src/core/productorder/productorder.dart';
import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/core/settings/setting_state.dart';
import 'package:oms_salesforce/src/core/targetandachivement/targetandachivement.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../src/core/allreports/save_product_availability/save_product_availability.dart';
import '../src/core/homepage/homepage.dart';
import '../src/core/imagepicker/imagepicker.dart';
import '../src/core/login/branch/branch_state_order.dart';
import '../src/core/login/login.dart';
import '../src/core/outletvisit/outletvisit.dart';
import '../src/core/pendingsync/pendingsync.dart';
import '../src/core/pendingverify/pending_verify_state.dart';
import '../src/core/productavailabilityreport/product_availability_report_state.dart';
import '../src/core/quickorder/quickorder.dart';
import '../src/core/savemovement/savemovement.dart';
import '../src/core/splash/splash.dart';
import '../src/core/todo/todo.dart';
import '../src/core/top_buying/top_buying.dart';

List<SingleChildWidget> myStateList = [
  ChangeNotifierProvider(create: (_) => SplashState()),
  ChangeNotifierProvider(create: (_) => LoginState()),
  ChangeNotifierProvider(create: (_) => SetAPIState()),
  ChangeNotifierProvider(create: (_) => BranchState()),
  ChangeNotifierProvider(create: (_) => BranchStateOrder()),

  ChangeNotifierProvider(create: (_) => DatePickerState()),

  ///
  ChangeNotifierProvider(create: (_) => HomeState()),
  ChangeNotifierProvider(create: (_) => PendingSyncState()),
  ChangeNotifierProvider(create: (_) => LeaveNotesState()),
  ChangeNotifierProvider(create: (_) => QuickOrderState()),
  ChangeNotifierProvider(create: (_) => PendingVerifyState()),
  ChangeNotifierProvider(create: (_) => ProductAvailabilityReportState()),

  ChangeNotifierProvider(create: (_) => ProductState()),
  ChangeNotifierProvider(create: (_) => ProductOrderState()),
  ChangeNotifierProvider(create: (_) => CoverageProductivityState()),
  ChangeNotifierProvider(create: (_) => TargetAndAchivementState()),
  ChangeNotifierProvider(create: (_) => DeliveryState()),

  ///
  ChangeNotifierProvider(create: (_) => ImagePickerState()),

  ///
  ChangeNotifierProvider(create: (_) => BillNoByVnoState()),

  /// ========== REPORT SECTION ========== ///
  ChangeNotifierProvider(create: (_) => AgingState()),
  ChangeNotifierProvider(create: (_) => LedgerReportState()),
  ChangeNotifierProvider(create: (_) => SalesHistoryState()),
  ChangeNotifierProvider(create: (_) => PDCState()),
  ChangeNotifierProvider(create: (_) => PDCEntriesState()),
  ChangeNotifierProvider(create: (_) => SaveCashBankState()),
  ChangeNotifierProvider(create: (_) => ClickImageState()),
  ChangeNotifierProvider(create: (_) => SaveJournalState()),
  ChangeNotifierProvider(create: (_) => SaveLedgetNotesState()),
  ChangeNotifierProvider(create: (_) => SalesReturnState()),
  ChangeNotifierProvider(create: (_) => ReportLinkState()),

  /// ========== REPORT SECTION ========== ///

  ChangeNotifierProvider(create: (_) => SaveMovementState()),

  ///
  ChangeNotifierProvider(create: (_) => SettingState()),
  ChangeNotifierProvider(create: (_) => OrderReportState()),

  ChangeNotifierProvider(create: (_) => QuestionState()),
  ChangeNotifierProvider(create: (_) => TopBuyingState()),
  ChangeNotifierProvider(create: (_) => TodoState()),
  ChangeNotifierProvider(create: (_) => OutletVisitState()),

  ///
  ChangeNotifierProvider(create: (_) => SaveProductAvailabilityState()),
];
