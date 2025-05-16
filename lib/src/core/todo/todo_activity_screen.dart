import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme.dart';
import '../../widgets/widgets.dart';
import 'todo.dart';

class ToDoActivityScreen extends StatelessWidget {
  const ToDoActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TodoState>();
    return Scaffold(
      appBar: AppBar(title: Text("${state.selectedToDo.taskStatus} Details")),
      body: state.activityDataList.isNotEmpty
          ? StatefulBuilder(
              builder: (BuildContext context, setState) {
                return GroupedListView<TodoActivityDataModel, String>(
                  elements: state.activityDataList,
                  groupBy: (element) =>
                      element.activityCreatedon.substring(0, 10),
                  groupSeparatorBuilder: (String groupByValue) {
                    int index = state.activityDataList.indexWhere((element) =>
                        element.activityCreatedon.substring(0, 10) ==
                        groupByValue);
                    return TableHeaderWidget(
                      color: state.selectedToDo.taskStatus == "Completed"
                          ? Colors.purple
                          : state.selectedToDo.taskStatus == 'InProgress'
                              ? Colors.amber
                              : Colors.green,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            state.isShowActivityItemBuilder[index] =
                                !state.isShowActivityItemBuilder[index];
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
                  itemBuilder: (context, TodoActivityDataModel element) {
                    int index = state.activityDataList.indexWhere((e) {
                      return e.activityCreatedon.substring(0, 10) ==
                          element.activityCreatedon.substring(0, 10);
                    });

                    ///
                    if (state.isShowActivityItemBuilder[index]) {
                      TodoActivityDataModel indexData = element;
                      return _buildListInfo(indexData);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                );
              },
            )
          : const NoDataWidget(),
    );
  }

  Widget _buildListInfo(TodoActivityDataModel indexData) {
    Color priorityColor = indexData.priorityLevel == "Critical"
        ? Colors.red
        : indexData.priorityLevel == "High"
            ? Colors.orange
            : indexData.priorityLevel == "Normal"
                ? Colors.yellow
                : Colors.blue;
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: ContainerDecoration.decoration(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildInfo("Frequency", indexData.frequencyType),
            _buildInfo(
              "Priority",
              indexData.priorityLevel,
              style: subTitleTextStyle.copyWith(color: priorityColor),
            ),
            _buildInfo(
              "Subject",
              indexData.toDoItems,
              style: subTitleTextStyle.copyWith(color: priorityColor),
            ),
            _buildInfo(
              "Action",
              indexData.description,
              style: subTitleTextStyle.copyWith(color: primaryColor),
            ),
            _buildInfo(
              "Activity",
              indexData.activityDescription,
              style: titleTextStyle.copyWith(color: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(String title, String value, {TextStyle? style}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: Text(title, style: style, textAlign: TextAlign.start),
          ),
          const Expanded(child: Text(":", textAlign: TextAlign.center)),
          Expanded(
            flex: 6,
            child: Text(value, style: style, textAlign: TextAlign.justify),
          ),
        ],
      ),
    );
  }
}
