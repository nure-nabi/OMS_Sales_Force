import 'package:flutter/material.dart';
import 'package:oms_salesforce/theme/theme.dart';

class TextFieldFormat extends StatelessWidget {
  final String textFieldName;
  final Widget textFormField;

  const TextFieldFormat(
      {super.key, required this.textFieldName, required this.textFormField,});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            textFieldName,
            style: textFormTitleStyle.copyWith(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        const SizedBox(height: 5.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: textFormField,
        ),
      ],
    );
  }
}
