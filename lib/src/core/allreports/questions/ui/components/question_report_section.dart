import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:oms_salesforce/theme/fonts_style.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/widgets.dart';
import '../../model/question_report_model.dart';
import '../../questions.dart';

class QuestioReportSection extends StatelessWidget {
  const QuestioReportSection({super.key});
  @override
  Widget build(BuildContext context) {
    final state = context.watch<QuestionState>();
    // return (state.questionReportList.isNotEmpty)
    //     ? ListView.builder(
    //         padding: const EdgeInsets.all(10.0),
    //         itemCount: state.questionReportList.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           final question = state.questionReportList[index];
    //           return buildQuestionItem(question, index);
    //         },
    //       )
    // : const NoDataWidget();
    return state.questionReportList.isNotEmpty
        ? StatefulBuilder(
            builder: (BuildContext context, setState) {
              return GroupedListView<QuestionReportDataModel, String>(
                elements: state.questionReportList,
                groupBy: (element) => element.createdDate.substring(0, 10),
                groupSeparatorBuilder: (String groupByValue) {
                  //
                  int index = state.questionReportList.indexWhere((element) {
                    return element.createdDate.substring(0, 10) == groupByValue;
                  });

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
                itemBuilder: (context, QuestionReportDataModel element) {
                  int index = state.questionReportList.indexWhere((e) =>
                      e.createdDate.substring(0, 10) ==
                      element.createdDate.substring(0, 10));

                  ///
                  if (state.isShowItemBuilder[index]) {
                    QuestionReportDataModel indexData = element;
                    return buildQuestionItem(state, indexData, index);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              );
            },
          )
        : const NoDataWidget();
  }

  Widget buildQuestionItem(
      QuestionState state, QuestionReportDataModel question, int index) {
    return Container(
      decoration: ContainerDecoration.decoration(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTitleDescWdiget(
                "Date", question.createdDate.substring(0, 10)),
            verticalSpace(5.0),
            if (state.isFromIndex)
              _buildTitleDescWdiget("Customer", question.gldesc),
            verticalSpace(10.0),
            Text("Question :  ${question.question}", style: titleTextStyle),
            verticalSpace(5.0),
            Text("Answer :  ${question.answer}",
                style: subTitleTextStyle.copyWith(color: Colors.red)),
            verticalSpace(10.0),
            // _buildTitleDescWdiget("Agent Name", question.agentDesc),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleDescWdiget(String title, String desc) {
    return Row(
      children: [
        Expanded(child: Text(title)),
        Expanded(flex: 2, child: Text(desc)),
      ],
    );
  }
}
