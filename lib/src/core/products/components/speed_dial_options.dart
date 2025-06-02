import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../theme/theme.dart';
import '../../../service/router/router.dart';
import '../../../service/sharepref/set_all_pref.dart';
import '../../../widgets/widgets.dart';
import '../../allreports/allreports.dart';
import '../../allreports/questions/questions.dart';
import '../../deliveryreport/deliveryreport.dart';
import '../../top_buying/top_buying.dart';

class SpeedDialOptionsWidget extends StatelessWidget {
  const SpeedDialOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "CLOSE TAG",
              backgroundColor: Colors.red,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.close),
            ),
          ],
        ),
      ),
      body: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                _optionListOne(context),
                _optionListTwo(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget _optionListOne(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildOptions(
            icon: Icons.notes,
            label: "Save Notes",
            onTap: () {
              _navigateTo(context, routeName: saveNotesPath);
            },
          ),
          _buildOptions(
            icon: Icons.save,
            label: "Save Journal",
            onTap: () {
              _navigateTo(context, routeName: saveJournalPath);
            },
          ),
          _buildOptions(
            icon: Icons.camera_alt,
            label: "Click Image",
            onTap: () {
              _showPopUp(context, screen: const ClickImageScreen());
            },
          ),
        ],
      ),
    );
  }

  ///
  ///
  ///
  ///
  Widget _optionListTwo(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // _buildOptions(
          //   icon: Icons.sell_outlined,
          //   label: "Sales History",
          //   onTap: () {
          //     _navigateTo(context, routeName: salesHistoryPath);
          //   },
          // ),
          _buildOptions(
            icon: Icons.sort,
            label: "Ledger Report",
            onTap: () async{
              await SetAllPref.setBranch(value: "");
              _navigateTo(context, routeName: ledgerReportPath);
            },
          ),
          _buildOptions(
            icon: Icons.delivery_dining_outlined,
            label: "Delivered Report",
            onTap: () {
              context.read<DeliveryState>().getIsFromIndex = false;
              _navigateTo(context, routeName: deliveryReportCustomerScreen);
            },
          ),
          // SpeedDialChild(
          //   child: const Icon(Icons.monetization_on_outlined),
          //   backgroundColor: Colors.teal,
          //   foregroundColor: Colors.white,
          //   labelBackgroundColor: Colors.teal,
          //   labelStyle: whiteTextStyle.copyWith(fontSize: 16.0),
          //   label: 'Cash Report',
          //   onTap: () {},
          // ),
          _buildOptions(
            icon: Icons.report_outlined,
            label: "Ageing Report",
            onTap: () {
              _showPopUp(context, screen: const AgingReportScreen());
            },
          ),
          _buildOptions(
            icon: Icons.report,
            label: "Link Report",
            onTap: () {
              _navigateTo(context, routeName: linkReportPath);
            },
          ),
          _buildOptions(
            icon: Icons.monetization_on,
            label: "Sales Return",
            onTap: () {
              _navigateTo(context, routeName: salesReturnPath);
            },
          ),
          // SpeedDialChild(
          //   child: const Icon(Icons.attach_money),
          //   backgroundColor: Colors.teal,
          //   foregroundColor: Colors.white,
          // labelBackgroundColor: Colors.teal,
          // labelStyle: whiteTextStyle.copyWith(fontSize: 16.0),
          //   label: 'Save Cash Bank',
          //   onTap: () {
          //     ShowAlert(context).alert(
          //       child: const CashBankDetailSection(),
          //     );
          //   },
          // ),
          _buildOptions(
            icon: Icons.attach_money,
            label: "Cash Entry",
            onTap: () {
              _showPopUp(context, screen: const SaveCashBankScreen());
            },
          ),
          _buildOptions(
            icon: Icons.settings_accessibility,
            label: "PDC Report",
            onTap: () {
              context.read<PDCState>().getCustomerFilter = true;
              _navigateTo(context, routeName: pdcReportPath);
            },
          ),
          _buildOptions(
            icon: Icons.accessibility,
            label: "PDC Entry",
            onTap: () {
              _navigateTo(context, routeName: pdcEntriesPath);
            },
          ),
          _buildOptions(
            icon: Icons.question_answer,
            label: "Questions",
            onTap: () {
              context.read<QuestionState>().isFromIndex = false;
              _navigateTo(context, routeName: questionPath);
            },
          ),
          _buildOptions(
            icon: Icons.monetization_on_outlined,
            label: "Top Buying",
            onTap: () {
              context.read<TopBuyingState>().isFromIndex = false;
              _navigateTo(context, routeName: topBuyingPath);
            },
          ),
          _buildOptions(
            icon: Icons.post_add,
            label: "Product Availability",
            onTap: () {
              _navigateTo(context, routeName: saveProductAvailabilityPath);
            },
          ),
        ],
      ),
    );
  }

  ///
  ///
  ///
  ///
  ///
  ///

  void _navigateTo(context, {required String routeName}) {
    Navigator.popAndPushNamed(context, routeName);
  }

  void _showPopUp(context, {required Widget screen}) {
    Navigator.pop(context);
    ShowAlert(context).alert(child: screen);
  }

  Widget _buildOptions({
    required IconData icon,
    required String label,
    required void Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 3,
                child: Container(
                  decoration: ContainerDecoration.decoration(
                    color: Colors.teal,
                    bColor: Colors.teal,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      label,
                      style: subTitleTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 3.0),
              Flexible(
                child: CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Icon(icon),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
