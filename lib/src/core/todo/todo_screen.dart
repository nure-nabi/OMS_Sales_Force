import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:oms_salesforce/src/utils/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme.dart';
import '../../service/router/router.dart';
import '../../widgets/widgets.dart';
import 'todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoState>().context = context;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoState>(
      builder: (BuildContext context, state, Widget? child) {
        return Stack(
          children: [
            Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pushNamed(context, todoFromPath);
                },
                label: const Text("Add Task"),
                icon: const Icon(Icons.add),
              ),
              appBar: AppBar(title: const Text("Todo Notification")),
              body: state.dataList.isNotEmpty
                  ? GroupedListView<TodoDataModel, String>(
                      elements: state.dataList,
                      // groupBy: (element) => element.lDate.substring(0, 10),
                      groupBy: (element) => element.taskStatus,
                      groupComparator: (String value1, String value2) {
                        final List<String> filterOrder = [
                          'Pending',
                          'InProgress',
                          'Completed',
                        ];

                        final int index1 = filterOrder.indexOf(value1);
                        final int index2 = filterOrder.indexOf(value2);

                        // Compare the indices to determine the order
                        return index1.compareTo(index2);
                      },
                      groupSeparatorBuilder: (String groupByValue) {
                        int index = state.dataList.indexWhere(
                            (element) => element.taskStatus == groupByValue);
                        return TableHeaderWidget(
                          color: groupByValue == "Completed"
                              ? Colors.purple
                              : groupByValue == 'InProgress'
                                  ? Colors.amber
                                  : Colors.green,
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
                      itemBuilder: (context, TodoDataModel element) {
                        int index = state.dataList.indexWhere(
                            (e) => e.taskStatus == element.taskStatus);

                        ///
                        if (state.isShowItemBuilder[index]) {
                          TodoDataModel indexData = element;

                          return Container(
                            decoration: ContainerDecoration.decoration(
                              bColor: Colors.blueGrey.shade400,
                            ),
                            margin: const EdgeInsets.symmetric(
                              vertical: 3.0,
                              horizontal: 5.0,
                            ),
                            child: InkWell(
                              onTap: () async {
                                state.selectedToDo = indexData;
                                await state.getToDoDetailsDataFromRemote();
                              },
                              child: _buildListInfo(indexData),
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

  Widget _buildListInfo(TodoDataModel indexData) {
    Color priorityColor = indexData.priorityLevel == "Critical"
        ? Colors.red
        : indexData.priorityLevel == "High"
            ? Colors.orange
            : indexData.priorityLevel == "Normal"
                ? Colors.yellow
                : Colors.blue;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildInfo(
            "From",
            indexData.fromDate.substring(0, 10),
            style: subTitleTextStyle,
          ),
          _buildInfo(
            "To",
            indexData.toDate.substring(0, 10),
            style: subTitleTextStyle,
          ),
          verticalSpace(5.0),
          _buildInfo(
            "Priority",
            indexData.priorityLevel,
            style: subTitleTextStyle.copyWith(color: priorityColor),
          ),
          _buildInfo(
            "Frequency",
            indexData.frequencyType,
            style: subTitleTextStyle,
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
          _buildInfo("Created On", indexData.createdon.substring(0, 10)),
          _buildInfo("Assign To", indexData.assignedTo),
          _buildInfo("Created By", indexData.createdBy),
        ],
      ),
    );
  }

  Widget _buildInfo(String title, String value,
      {TextStyle style = const TextStyle()}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: style.copyWith(fontSize: 14.0),
              textAlign: TextAlign.start,
            ),
          ),
          const Expanded(child: Text(":", textAlign: TextAlign.center)),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: style.copyWith(fontSize: 14.0),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
