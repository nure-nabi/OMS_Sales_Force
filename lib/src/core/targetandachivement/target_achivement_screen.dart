import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:oms_salesforce/src/utils/loading_indicator.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

import 'model/target_achivement_model.dart';
import 'target_achivement_state.dart';

class TargetAndAchivementScreen extends StatefulWidget {
  const TargetAndAchivementScreen({super.key});

  @override
  State<TargetAndAchivementScreen> createState() =>
      _TargetAndAchivementScreenState();
}

class _TargetAndAchivementScreenState extends State<TargetAndAchivementScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<TargetAndAchivementState>(context, listen: false).getContext =
        context;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TargetAndAchivementState>(
      builder: (context, state, child) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(title: const Text("Target And Achievement")),
              body: state.reportList.isNotEmpty
                  ? GroupedListView<TargetAndAchivementDataModel, String>(
                      elements: state.reportList,
                      groupBy: (element) => element.nepaliMonth,
                      groupComparator: (String value1, String value2) {
                        final List<String> nepaliMonthsOrder = [
                          'Baishakh',
                          'Jestha',
                          'Ashadh',
                          'Shrawan',
                          'Bhadra',
                          'Ashwin',
                          'Kartik',
                          'Mangsir',
                          'Poush',
                          'Magh',
                          'Falgun',
                          'Chaitra',
                        ];

                        final int index1 = nepaliMonthsOrder.indexOf(value1);
                        final int index2 = nepaliMonthsOrder.indexOf(value2);

                        // Compare the indices to determine the order
                        return index1.compareTo(index2);
                      },
                      groupSeparatorBuilder: (String groupByValue) {
                        int index = state.reportList.indexWhere(
                            (element) => element.nepaliMonth == groupByValue);
                        return TableHeaderWidget(
                          color: Colors.green.shade300,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                state.isShowItemBuilder[index] =
                                    !state.isShowItemBuilder[index];
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(groupByValue, style: tableHeaderTextStyle),
                                Icon(
                                  state.isShowItemBuilder[index]
                                      ? Icons.keyboard_arrow_down_rounded
                                      : Icons.keyboard_arrow_up_rounded,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemBuilder:
                          (context, TargetAndAchivementDataModel element) {
                        int index = state.reportList.indexWhere(
                            (e) => e.nepaliMonth == element.nepaliMonth);
                        if (state.isShowItemBuilder[index]) {
                          TargetAndAchivementDataModel indexData = element;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Container(
                              decoration: ContainerDecoration.decoration(
                                color: Colors.blue.shade50,
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 3.0),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Column(
                                children: [
                                  _buildData("Target Qty", indexData.targetQty),
                                  _buildData(
                                    "Achieve Qty",
                                    indexData.achieveQty,
                                  ),
                                  _buildData(
                                    "Variance Qty %",
                                    state.getAchivePercentQty(
                                      achieveQty: indexData.achieveQty,
                                      targetQty: indexData.targetQty,
                                    ),
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(height: 5.0),

                                  ///
                                  _buildData(
                                    "Target Amt",
                                    indexData.targetAmount,
                                  ),
                                  _buildData(
                                    "Achieve Amt",
                                    indexData.achieveAmount,
                                  ),
                                  _buildData(
                                    "Variance Amt %",
                                    state.getAchivePercentAmt(
                                      achieveAmt: indexData.achieveAmount,
                                      targetAmt: indexData.targetAmount,
                                    ),
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    )
                  : const NoDataWidget(),
            ),
            if (state.isLoading) LoadingScreen.loadingScreen(),
          ],
        );
      },
    );
  }

  Widget _buildData(title, value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Row(children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: textFormTitleStyle.copyWith(color: color),
            textAlign: TextAlign.start,
          ),
        ),
        const Expanded(child: Text(":", textAlign: TextAlign.center)),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: TextStyle(color: color),
            textAlign: TextAlign.start,
          ),
        ),
      ]),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:grouped_list/grouped_list.dart';
// import 'package:oms_salesforce/src/utils/loading_indicator.dart';
// import 'package:oms_salesforce/src/widgets/widgets.dart';
// import 'package:oms_salesforce/theme/theme.dart';
// import 'package:provider/provider.dart';

// import 'model/target_achivement_model.dart';
// import 'target_achivement_state.dart';

// class TargetAndAchivementScreen extends StatefulWidget {
//   const TargetAndAchivementScreen({super.key});

//   @override
//   State<TargetAndAchivementScreen> createState() =>
//       _TargetAndAchivementScreenState();
// }

// class _TargetAndAchivementScreenState extends State<TargetAndAchivementScreen> {
//   late List<bool> toggleBuilder = [];
//   @override
//   void initState() {
//     super.initState();

//     Provider.of<TargetAndAchivementState>(context, listen: false).getContext =
//         context;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<TargetAndAchivementState>(
//       builder: (context, state, child) {
//         return Stack(
//           children: [
//             Scaffold(
//               appBar: AppBar(title: const Text("Target And Achivement")),
//               body: state.reportList.isNotEmpty
//                   ? GroupedListView<TargetAndAchivementDataModel, String>(
//                       elements: state.reportList,
//                       groupBy: (element) => element.nepaliMonth,
//                       groupSeparatorBuilder: (String groupByValue) {
//                         int index = state.reportList.indexWhere(
//                           (element) => element.nepaliMonth == groupByValue,
//                         );
//                         toggleBuilder.add(false);
//                         return TableHeaderWidget(
//                           child: InkWell(
//                             onTap: () {
//                               setState(() {
//                                 toggleBuilder[index] = !toggleBuilder[index];
//                               });
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   groupByValue,
//                                   style: tableHeaderTextStyle,
//                                 ),
//                                 Icon(
//                                   toggleBuilder[index]
//                                       ? Icons.keyboard_arrow_down_rounded
//                                       : Icons.keyboard_arrow_up_rounded,
//                                   color: Colors.white,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                       itemBuilder:
//                           (context, TargetAndAchivementDataModel element) {
//                         int index = state.reportList.indexWhere(
//                             (e) => e.nepaliMonth == element.nepaliMonth);
//                         if (toggleBuilder[index]) {
//                           TargetAndAchivementDataModel indexData = element;
//                           return Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 10.0),
//                             child: Container(
//                               decoration: ContainerDecoration.decoration(),
//                               margin: const EdgeInsets.symmetric(vertical: 3.0),
//                               padding:
//                                   const EdgeInsets.symmetric(vertical: 8.0),
//                               child: Column(
//                                 children: [
//                                   // _buildData("Name", indexData.salesmanName),
//                                   _buildData("Target Qty", indexData.targetQty),
//                                   _buildData(
//                                     "Target Amt",
//                                     indexData.targetAmount,
//                                   ),
//                                   _buildData(
//                                     "Achieve Qty",
//                                     indexData.achieveQty,
//                                   ),
//                                   _buildData(
//                                     "Achieve Amount",
//                                     indexData.achieveAmount,
//                                   ),
//                                   _buildData(
//                                     "%Achieve Qty",
//                                     state.getAchivePercentQty(
//                                       achieveQty: indexData.achieveQty,
//                                       targetQty: indexData.targetQty,
//                                     ),
//                                   ),
//                                   _buildData(
//                                     "%Achieve Amt",
//                                     state.getAchivePercentAmt(
//                                       achieveAmt: indexData.achieveAmount,
//                                       targetAmt: indexData.targetAmount,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         } else {
//                           return const SizedBox.shrink();
//                         }
//                       },
//                       // itemComparator: (item1, item2) =>
//                       //     item1['name'].compareTo(item2['name']), // optional
//                       // useStickyGroupSeparators: true, // optional
//                       // floatingHeader: true, // optional
//                       // order: GroupedListOrder.ASC, // optional
//                     )
//                   : const NoDataWidget(),
//             ),
//             if (state.isLoading) LoadingScreen.loadingScreen(),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildData(title, value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
//       child: Row(children: [
//         Expanded(
//           flex: 2,
//           child: Text(
//             title,
//             style: textFormTitleStyle,
//             textAlign: TextAlign.start,
//           ),
//         ),
//         const Expanded(child: Text(":", textAlign: TextAlign.center)),
//         Expanded(
//           flex: 2,
//           child: Text(
//             value,
//             textAlign: TextAlign.start,
//           ),
//         ),
//       ]),
//     );
//   }
// }
