import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/allreports/allreports.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

class SalesHistoryScreen extends StatefulWidget {
  const SalesHistoryScreen({super.key});

  @override
  State<SalesHistoryScreen> createState() => _SalesHistoryScreenState();
}

class _SalesHistoryScreenState extends State<SalesHistoryScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SalesHistoryState>(context, listen: false).getContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesHistoryState>(builder: (context, state, child) {
      return Stack(
        children: [
          Scaffold(
            appBar: AppBar(title: const Text("Sales History")),
            bottomNavigationBar: BottomNavigationWidget(
              child: Row(children: [
                Expanded(
                  child: Text("Total Qty", style: tableHeaderTextStyle),
                ),
                Expanded(
                  child: Text("${state.totalQty}",
                      style: tableHeaderTextStyle, textAlign: TextAlign.end),
                ),
              ]),
            ),
            body: Column(
              children: [
                ///
                TableHeaderWidget(
                  child: Row(children: [
                    Expanded(child: Text("SNo.", style: tableHeaderTextStyle)),
                    Expanded(
                      flex: 2,
                      child: Text("Product", style: tableHeaderTextStyle),
                    ),
                    Expanded(
                      child: Text("Quantity",
                          style: tableHeaderTextStyle,
                          textAlign: TextAlign.end),
                    ),
                  ]),
                ),

                ///
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.dataList.length,
                    itemBuilder: (context, index) {
                      SalesHistoryDataModel indexData = state.dataList[index];
                      return StatefulBuilder(
                        builder: (BuildContext context, setState) {
                          return TableDataWidget(
                            onTap: () async {},
                            child: Row(
                              children: [
                                Expanded(child: Text("${index + 1}")),
                                Expanded(
                                  flex: 2,
                                  child: Text(indexData.pDesc),
                                ),
                                Expanded(
                                  child: Text(
                                    indexData.qty,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),

            // body: Center(
            //   child: Stack(
            //     alignment: Alignment.topRight,
            //     children: [
            //       CustomAlertWidget(
            //         title: "AGEING REPORT",
            //         showCancle: true,
            //         child: Container(
            //           margin: const EdgeInsets.symmetric(vertical: 10.0),
            //           padding: const EdgeInsets.all(10.0),
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(10.0),
            //           ),
            //           child: Stack(
            //             alignment: Alignment.center,
            //             children: [
            //               Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 mainAxisSize: MainAxisSize.min,
            //                 children: [
            //                   TitleValueWidget(
            //                     title: '30 Days',
            //                     value: state.thirtyDaysTotal.toStringAsFixed(2),
            //                   ),
            //                   TitleValueWidget(
            //                     title: '60 Days',
            //                     value: state.sixtyDaysTotal.toStringAsFixed(2),
            //                   ),
            //                   TitleValueWidget(
            //                     title: '90 Days',
            //                     value: state.nintyDaysTotal.toStringAsFixed(2),
            //                   ),
            //                   TitleValueWidget(
            //                     title: '> 90 Days',
            //                     value: state.overNintyDaysTotal.toStringAsFixed(2),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.symmetric(vertical: 10.0),
            //                     child: Row(
            //                       children: [
            //                         Expanded(
            //                           child: Text(
            //                             "Total",
            //                             style: textFormTitleStyle,
            //                             textAlign: TextAlign.center,
            //                           ),
            //                         ),
            //                         Expanded(
            //                           child: Text(
            //                             state.totalBalance.toStringAsFixed(2),
            //                             style: textFormTitleStyle.copyWith(
            //                                 color: Colors.black),
            //                             textAlign: TextAlign.center,
            //                           ),
            //                         ),
            //                       ],
            //                     ),
          ),
          if (state.isLoading) LoadingScreen.loadingScreen()
        ],
      );
    });
  }
}
