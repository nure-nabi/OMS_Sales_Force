import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:oms_salesforce/theme/colors.dart';
import 'package:oms_salesforce/theme/fonts_style.dart';
import 'package:provider/provider.dart';

import '../../../widgets/widgets.dart';
import '../leavenotes_state.dart';
import '../model/leave_report_model.dart';

class LeaveNotesReports extends StatelessWidget {
  const LeaveNotesReports({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LeaveNotesState>();
    // return ListView.builder(
    //   itemCount: state.reportList.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     LeaveReportDataModel indexData = state.reportList[index];
    //     // return Text(indexData.agentDesc);
    //     return _buildListData(indexData);
    //   },
    // );
    return state.reportList.isNotEmpty
        ? StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return GroupedListView<LeaveReportDataModel, String>(
                elements: state.reportList,
                groupBy: (element) => element.leaveDesc,
                groupSeparatorBuilder: (String groupByValue) {
                  int index = state.reportList.indexWhere(
                    (element) => element.leaveDesc == groupByValue,
                  );
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
                itemBuilder: (context, LeaveReportDataModel element) {
                  int index = state.reportList.indexWhere(
                    (e) => e.leaveDesc == element.leaveDesc,
                  );

                  ///
                  if (state.isShowItemBuilder[index]) {
                    LeaveReportDataModel indexData = element;
                    return _buildListData(indexData);
                    // return Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 10.0,
                    //   ),
                    //   child: Container(
                    //     decoration: ContainerDecoration.decoration(),
                    //     margin: const EdgeInsets.symmetric(vertical: 3.0),
                    //     padding: const EdgeInsets.symmetric(
                    //       vertical: 8.0,
                    //     ),
                    //     child: Column(
                    //       children: [
                    //         _buildData("Client", indexData.glDesc),
                    //         _buildData("Qty", "${indexData.qty}"),
                    //         _buildData("Amount", "${indexData.amt}"),
                    //         //
                    //         _buildData("Visit Count", "${indexData.visitTime}"),
                    //         //
                    //         _buildData("Visit By", indexData.agentDesc),
                    //       ],
                    //     ),
                    //   ),
                    // );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              );
            },
          )
        : const NoDataWidget();
  }

  Widget _buildListData(LeaveReportDataModel leaveInfo) {
    return Container(
      decoration: ContainerDecoration.decoration(
        color: leaveInfo.approvedBy == ""
            ? errorColor.withOpacity(.1)
            : successColor.withOpacity(.1),
      ),
      margin: const EdgeInsets.all(5.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                children: [
                  if (leaveInfo.dateFrom.isNotEmpty)
                    Expanded(
                      child: Text(
                        "From : ${_fromatDate(leaveInfo.dateFrom)}",
                      ),
                    ),
                  if (leaveInfo.dateTo.isNotEmpty)
                    Expanded(
                      child: Text(
                        "To : ${_fromatDate(leaveInfo.dateTo)}",
                      ),
                    ),
                ],
              ),
            ),
            verticalSpace(3.0),

            Row(
              children: [
                if (leaveInfo.noofdays != 0)
                  Expanded(
                    child: Text(
                      "No. of Day(s) : ${leaveInfo.noofdays}",
                      style: hintTextStyle,
                    ),
                  ),
                if (leaveInfo.balanceLeave != 0)
                  Expanded(
                    child: Text(
                      "Reamining Day(s) : ${leaveInfo.balanceLeave}",
                      style: hintTextStyle,
                    ),
                  ),
              ],
            ),
            verticalSpace(12.0),

            ///
            Text(
              leaveInfo.reason,
              style: titleTextStyle,
              textAlign: TextAlign.justify,
            ),
            verticalSpace(8.0),

            ///

            verticalSpace(5.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Approved By : ${leaveInfo.approvedBy.isEmpty ? "Not approved yet!" : leaveInfo.approvedBy}",
                    style: subTitleTextStyle.copyWith(color: Colors.purple),
                  ),
                ),
                if (leaveInfo.approveRemarks.isNotEmpty)
                  Expanded(
                    child: Text(
                      "Remarks : ${leaveInfo.approveRemarks}",
                      style: subTitleTextStyle,
                    ),
                  ),
              ],
            ),

            ///
          ],
        ),
      ),
    );
  }

  _fromatDate(String date) {
    if (date.isEmpty) return "";
    return date.substring(0, 10);
  }
}
