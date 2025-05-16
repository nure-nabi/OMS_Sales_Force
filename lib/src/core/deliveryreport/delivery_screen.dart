import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:oms_salesforce/src/core/deliveryreport/model/delivery_model.dart';
import 'package:oms_salesforce/src/service/sharepref/get_all_pref.dart';
import 'package:oms_salesforce/src/utils/loading_indicator.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../service/sharepref/set_all_pref.dart';
import 'delivery_state.dart';

class DeliveryReportScreen extends StatefulWidget {
  const DeliveryReportScreen({super.key});

  @override
  State<DeliveryReportScreen> createState() => _DeliveryReportScreenState();
}

class _DeliveryReportScreenState extends State<DeliveryReportScreen> {
  double percentage = 0.0;
  @override
  void initState() {
    super.initState();
    Provider.of<DeliveryState>(context, listen: false).getContext = context;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        percentage += 0.1; // Update percentage value here
        if (percentage > 1.0) {
          percentage = 0.0; // Reset if needed
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DeliveryState>(builder: (context, state, child) {
      return Stack(
        children: [
          Scaffold(
            appBar: AppBar(title: const Text("Delivery Report"),
            actions: [
              IconButton(
                onPressed: () async {
                  await SetAllPref.setWhenHaveListDb(value: false);
                  await state.init();
                  percentage=0.0;
                  Timer.periodic( const Duration(seconds: 1), (timer) {
                    setState(() {
                      percentage += 0.1; // Update percentage value here
                      if (percentage > 1.0) {
                        percentage = 0.0;
                      }
                    });
                  });
                },
                icon: const Icon(Icons.upload_outlined),
              ),
              horizantalSpace(5),
              IconButton(
                onPressed: () {
                  ShowAlert(context).alert(
                    child: DatePickerWidget(
                      onConfirm: () async {
                        await state.onDatePickerConfirm();
                        state.setDateValue = true;
                        //state.getDateWiseReport();
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.calendar_month),
              ),
            ],
            ),
            body: Column(
              children: [
                ///
                TableHeaderWidget(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Date",
                          style: tableHeaderTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Amount",
                          style: tableHeaderTextStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                ///
                Flexible(
                  child: state.dateList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.dateList.length,
                          itemBuilder: (context, index) {
                            DeliveryReportDataModel indexData =
                                state.dateList[index];
                            return StatefulBuilder(
                              builder: (BuildContext context, setState) {
                                // return TableDataWidget(
                                //   onTap: () async {},
                                // child: Row(
                                //   children: [
                                //     Expanded(child: Text(indexData.vDate)),
                                //     const SizedBox(width: 10.0),
                                //     Expanded(
                                //       flex: 2,
                                //       child: Text(indexData.glDesc),
                                //     ),
                                //     Expanded(
                                //       child: Text(
                                //         "${indexData.netAmount}",
                                //         textAlign: TextAlign.end,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // );

                                return Container(
                                  decoration: ContainerDecoration.decoration(),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 5.0),
                                  child: InkWell(
                                    onTap: () {
                                      state.getSelectedDate = indexData;
                                      state.onDateSelected();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 12.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Flexible(
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 16.0,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                              "${indexData.vDate} (${indexData.vMiti})",
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                              indexData.netAmount,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : const NoDataWidget(),
                ),
              ],
            ),
          ),
          //if (state.isLoading) LoadingScreen.loadingScreenPending(context,percentage),
          if (state.isLoading) LoadingScreen.loadingScreen(),
        ],
      );
    });
  }
}
