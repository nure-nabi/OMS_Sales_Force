import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/todo/model/ledger_model.dart';
import 'package:oms_salesforce/src/core/todo/todo.dart';
import 'package:provider/provider.dart';

import '../../../../theme/theme.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import 'multi_assign_user_section.dart';

class TodoFromScreen extends StatefulWidget {
  const TodoFromScreen({super.key});

  @override
  State<TodoFromScreen> createState() => _TodoFromScreenState();
}

class _TodoFromScreenState extends State<TodoFromScreen> {
  final _formKey = GlobalKey<FormState>();
  final frequencyType = ['Occasional', 'Daily'];
  final priorityLevel = ['Critical', 'High', 'Normal', 'Low'];
  final taskStatus = ['Pending', 'InProgress', 'Completed'];

  @override
  void initState() {
    super.initState();
    final state = context.read<TodoState>();
    state.formClear();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TodoState>();
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Task")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            TextFieldFormat(
              textFieldName: "Subject",
              textFormField: TextFormField(
                controller: state.subjectController,
                decoration: TextFormDecoration.decoration(hintText: ""),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "";
                  }
                  return null;
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Expanded(flex: 4, child: AssignUserSection()),
                if (state.dropdownDataLoading)
                  const Flexible(
                    child: SizedBox(
                      height: 30.0,
                      width: 40.0,
                      child: Center(child: CupertinoActivityIndicator()),
                    ),
                  ),
              ],
            ),
            verticalSpace(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 4,
                  child: _buildDropdown<TodoLedgerDataModel>(
                    title: "Ledger",
                    hint: "Select Ledger",
                    list: state.ledgerList,
                    onChanged: (value) {
                      state.ledgerController.text = value!.glCode;
                    },
                    child: (value) {
                      return Text(value.glDesc);
                    },
                  ),
                ),
                if (state.dropdownDataLoading)
                  const Flexible(
                    child: SizedBox(
                      height: 30.0,
                      width: 40.0,
                      child: Center(child: CupertinoActivityIndicator()),
                    ),
                  ),
              ],
            ),

            _buildDropdown<String>(
              title: "Agent",
              hint: "Select Agent",
              list: [],
              onChanged: (value) {
                state.agentController.text = value ?? "";
              },
              child: (value) {
                return Text(value);
              },
            ),
            _buildDropdown<String>(
              title: "Frequency Type",
              hint: "Select Frequency Type",
              list: frequencyType,
              onChanged: (value) {
                state.frequencyController.text = value ?? "";
              },
              validator: (value) {
                if (value == null) {
                  return "";
                }
                return null;
              },
              child: (value) {
                return Text(value);
              },
            ),

            Row(
              children: [
                Expanded(
                  child: TextFieldFormat(
                    textFieldName: "From Date",
                    textFormField: TextFormField(
                      readOnly: true,
                      onTap: () async {
                        state.fromDateController.text =
                            await MyDatePicker(context).englishDate();
                      },
                      controller: state.fromDateController,
                      decoration: TextFormDecoration.decoration(hintText: ""),
                    ),
                  ),
                ),
                Expanded(
                  child: TextFieldFormat(
                    textFieldName: "To Date",
                    textFormField: TextFormField(
                      readOnly: true,
                      onTap: () async {
                        state.toDateController.text =
                            await MyDatePicker(context).englishDate();
                      },
                      controller: state.toDateController,
                      decoration: TextFormDecoration.decoration(hintText: ""),
                    ),
                  ),
                ),
              ],
            ),

            _buildDropdown<String>(
              title: "Priority Level",
              hint: "Select Priority Level",
              list: priorityLevel,
              onChanged: (value) {
                state.priorityController.text = value ?? "";
              },
              validator: (value) {
                if (value == null) {
                  return "";
                }
                return null;
              },
              child: (value) {
                return Text(value);
              },
            ),

            ///
            TextFieldFormat(
              textFieldName: "Description",
              textFormField: TextFormField(
                maxLines: 5,
                controller: state.descriptionController,
                decoration: TextFormDecoration.decoration(hintText: ""),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "";
                  }
                  return null;
                },
              ),
            ),

            ///
            // _buildDropdown<String>(
            //   title: "Task Status",
            //   hint: "Select Task Status",
            //   list: taskStatus,
            //   onChanged: (value) {},
            //   child: (value) {
            //     return Text(value);
            //   },
            // ),

            ///
            verticalSpace(10),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await state.createTodoActivityFromRemote();
                }
              },
              child: const Text("Create"),
            ),

            ///
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String title,
    required String hint,
    required List<T> list,
    required void Function(T? value)? onChanged,
    String? Function(T?)? validator,
    required Widget Function(T value) child,
  }) {
    return TextFieldFormat(
      textFieldName: title,
      textFormField: CustomDropDown<T>(
        dropdownMaxHeight: 300,
        borderColor: borderColor,
        hint: hint,
        items: list.map((item) {
          return DropdownMenuItem(
            value: item,
            child: child(item),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
        primaryColor: primaryColor,
      ),
    );
  }
}
