import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:oms_salesforce/src/utils/loading_indicator.dart';
import 'package:oms_salesforce/theme/fonts_style.dart';
import 'package:provider/provider.dart';

import '../../widgets/widgets.dart';
import 'outletvisit.dart';

class OutletVisitScreen extends StatefulWidget {
  const OutletVisitScreen({super.key});

  @override
  State<OutletVisitScreen> createState() => _OutletVisitScreenState();
}

class _OutletVisitScreenState extends State<OutletVisitScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OutletVisitState>().context = context;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OutletVisitState>(
      builder: (BuildContext context, state, Widget? child) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: const Text("Outlet Visit"),
                actions: [
                  IconButton(
                    onPressed: () {
                      ShowAlert(context).alert(
                        child: DatePickerWidget(
                          onConfirm: () async {
                            await state.onDatePickerConfirm();
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),

              // body: GroupedListView<OutletVisitDataModel, String>(
              //   elements: state.outletVisitList,
              //   groupBy: (element) => element.lDate.substring(0, 10),
              //   groupSeparatorBuilder: (String groupByValue) {
              //     return Text(groupByValue);
              //   },
              //   groupHeaderBuilder: (element) {
              //     return Container(
              //       decoration: ContainerDecoration.decoration(),
              //       margin: const EdgeInsets.symmetric(
              //         vertical: 2.0,
              //         horizontal: 5.0,
              //       ),
              //       child: InkWell(
              //         onTap: () {
              //           state.selectedArea = element;
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (_) => _OutletListScreen(),
              //             ),
              //           );
              //         },
              //         child: Padding(
              //           padding: const EdgeInsets.all(15.0),
              //           child: ArrowListWidget(
              //             child: Text(
              //               element.lDate.substring(0, 10),
              //               style: titleTextStyle.copyWith(fontSize: 16.0),
              //             ),
              //           ),
              //         ),
              //       ),
              //     );
              //   },
              //   itemBuilder: (context, dynamic element) {
              //     return const SizedBox.shrink();
              //   },
              // ),

              body: state.outletVisitList.isNotEmpty
                  ? GroupedListView<OutletVisitDataModel, String>(
                      elements: state.outletVisitList,
                      // groupBy: (element) => element.lDate.substring(0, 10),
                      groupBy: (element) => element.areaDesc,
                      groupSeparatorBuilder: (String groupByValue) {
                        int index = state.outletVisitList.indexWhere(
                            (element) => element.areaDesc == groupByValue);
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
                                Text(
                                  groupByValue,
                                  style: tableHeaderTextStyle,
                                ),
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
                      itemBuilder: (context, OutletVisitDataModel element) {
                        int index = state.outletVisitList
                            .indexWhere((e) => e.areaDesc == element.areaDesc);

                        ///
                        if (state.isShowItemBuilder[index]) {
                          OutletVisitDataModel indexData = element;
                          return Container(
                            decoration: ContainerDecoration.decoration(
                              color: index % 2 == 0
                                  ? Colors.white
                                  : Colors.blueGrey.shade100,
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 3.0),
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                            ),
                            child: InkWell(
                              onTap: () async {
                                state.selectedOutlet = indexData;
                                await state.getOutletVisitMoreFromRemote();
                              },
                              child: Column(
                                children: [
                                  _buildData(
                                    "Last Visit Date",
                                    indexData.lDate.substring(0, 10),
                                  ),
                                  _buildData("Outlet", indexData.glDesc),
                                  _buildData(
                                      "No. Of Visit", indexData.visitTime),
                                  _buildData("Sales Qty", "${indexData.qty}"),
                                  _buildData("Sales Amt", "${indexData.amt}"),
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

  Widget _buildData(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: textFormTitleStyle,
            textAlign: TextAlign.start,
          ),
        ),
        const Expanded(child: Text(":", textAlign: TextAlign.center)),
        Expanded(
          flex: 4,
          child: Text(
            value,
            textAlign: TextAlign.start,
          ),
        ),
      ]),
    );
  }
}

// class _OutletListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final state = context.watch<OutletVisitState>();
//     return Scaffold(
//       appBar: AppBar(title: const Text("Outlet Visit")),
//       body: GroupedListView<OutletVisitDataModel, String>(
//         elements: state.outletVisitList,
//         groupBy: (element) => element.glCode,
//         groupSeparatorBuilder: (String groupByValue) {
//           return Text(groupByValue);
//         },
//         groupHeaderBuilder: (element) {
//           return Container(
//             decoration: ContainerDecoration.decoration(),
//             margin: const EdgeInsets.symmetric(
//               vertical: 2.0,
//               horizontal: 5.0,
//             ),
//             child: InkWell(
//               onTap: () {},
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: ArrowListWidget(child: Text(element.glDesc)),
//               ),
//             ),
//           );
//         },
//         itemBuilder: (context, dynamic element) {
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }
