import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../theme/theme.dart';
import '../../../utils/utils.dart';

import '../../../widgets/mydropdown/dropdown_class.dart';
import '../../../widgets/mydropdown/dropdown_menu_text.dart';
import '../../../widgets/space.dart';
import '../../../widgets/text_field_decoration.dart';
import '../../../widgets/text_form_format.dart';
import '../leavenotes_state.dart';
import '../model/leave_type_model.dart';

class LeaveNotesForm extends StatelessWidget {
  const LeaveNotesForm({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LeaveNotesState>();
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: [
        Visibility(
          visible: !state.typeLoading,
          replacement: LoadingScreen.dataLoading(),
          child: TextFieldFormat(
            textFieldName: "Leave Type",
            textFormField: CustomDropDown<LeaveTypeDataModel>(
              borderColor: borderColor,
              hint: 'Select Leave Type',
              items: state.typeList.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: DropDownMenuText(
                    item: item.leaveDesc,
                  ),
                );
              }).toList(),
              onChanged: (LeaveTypeDataModel? value) {
                state.getTypeDetails = value!;
              },
              primaryColor: primaryColor,
            ),
          ),
        ),
        verticalSpace(10),
        TextFieldFormat(
          textFieldName: "Purpose",
          textFormField: TextFormField(
            controller: state.reason,
            maxLines: 5,
            // autofocus: true,
            decoration: TextFormDecoration.decoration(hintText: ""),
          ),
        ),
        verticalSpace(10),
        Row(children: [
          Expanded(
            child: TextFieldFormat(
              textFieldName: "From",
              textFormField: TextFormField(
                controller: state.fromDate,
                readOnly: true,
                onTap: () async {
                  state.getFromDate = await MyDatePicker(context).nepaliDate();
                },
                decoration: TextFormDecoration.decoration(
                  hintText: "Select Date",
                ),
              ),
            ),
          ),
          Expanded(
            child: TextFieldFormat(
              textFieldName: "To",
              textFormField: TextFormField(
                controller: state.toDate,
                readOnly: true,
                onTap: () async {
                  state.getToDate = await MyDatePicker(context).nepaliDate();
                },
                decoration: TextFormDecoration.decoration(
                  hintText: "Select Date",
                ),
              ),
            ),
          ),
        ]),
        verticalSpace(10),
        TextFieldFormat(
          textFieldName: "Day(s) Count",
          textFormField: Text("${state.daysCount} Days"),
        ),
        verticalSpace(15),
        ElevatedButton(
          onPressed: () async {
            await state.postLeave();
          },
          child: const Text("SUBMIT"),
        )
      ],
    );
  }
}
