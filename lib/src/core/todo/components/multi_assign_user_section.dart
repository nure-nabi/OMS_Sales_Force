import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../theme/theme.dart';
import '../../../widgets/widgets.dart';
import '../todo.dart';

class AssignUserSection extends StatelessWidget {
  const AssignUserSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TodoState>();

    final size = MediaQuery.sizeOf(context);
    return TextFieldFormat(
      textFieldName: "Assign To",
      textFormField: MultiSelectDialogField<String>(
        items: state.dropdownItems,
        title: const Text("Assign To"),
        selectedColor: primaryColor,
        decoration: ContainerDecoration.decoration(
          color: textFormFieldColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        buttonIcon: const Icon(Icons.arrow_drop_down_rounded),
        buttonText: Text("Select Assign To", style: hintTextStyle),
        chipDisplay: MultiSelectChipDisplay(
          textStyle: labelTextStyle.copyWith(fontSize: 11.0),
          chipColor: primaryColor.withOpacity(.2),
        ),
        onConfirm: (results) {
          state.assignToUserList = results;
        },
        validator: (values) {
          if (values == null || values.isEmpty) {
            return "* Required";
          }
          return null;
        },
        dialogHeight: size.height / 2,
        dialogWidth: size.width * .8,
      ),
    );
  }
}
