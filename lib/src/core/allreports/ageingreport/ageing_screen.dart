import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

import 'ageing_state.dart';

class AgingReportScreen extends StatefulWidget {
  const AgingReportScreen({super.key});

  @override
  State<AgingReportScreen> createState() => _AgingReportScreenState();
}

class _AgingReportScreenState extends State<AgingReportScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AgingState>(context, listen: false).getContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AgingState>(builder: (context, state, child) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              CustomAlertWidget(
                title: "AGEING REPORT",
                showCancle: true,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TitleValueWidget(
                            title: '30 Days',
                            value: state.thirtyDaysTotal.toStringAsFixed(2),
                          ),
                          TitleValueWidget(
                            title: '60 Days',
                            value: state.sixtyDaysTotal.toStringAsFixed(2),
                          ),
                          TitleValueWidget(
                            title: '90 Days',
                            value: state.nintyDaysTotal.toStringAsFixed(2),
                          ),
                          TitleValueWidget(
                            title: '> 90 Days',
                            value: state.overNintyDaysTotal.toStringAsFixed(2),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Total",
                                    style: textFormTitleStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    state.totalBalance.toStringAsFixed(2),
                                    style: textFormTitleStyle.copyWith(
                                        color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (state.isLoading) LoadingScreen.dataLoading(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
