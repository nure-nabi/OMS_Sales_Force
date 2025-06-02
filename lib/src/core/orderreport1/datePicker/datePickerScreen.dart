import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/utils/custom_date_picker.dart';
import 'package:oms_salesforce/src/widgets/container_decoration.dart';
import 'package:oms_salesforce/src/widgets/text_form_format.dart';
import 'package:oms_salesforce/theme/colors.dart';
import 'package:provider/provider.dart';

import '../order_report.dart';

class DatePickerWidget1 extends StatefulWidget {
  final Function onConfirm;

  const DatePickerWidget1({super.key, required this.onConfirm});

  @override
  State<DatePickerWidget1> createState() => _DatePickerWidget1State();
}

class _DatePickerWidget1State extends State<DatePickerWidget1> {
  @override
  void initState() {
    super.initState();
    Provider.of<DatePickerState1>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DatePickerState1>(
      builder: (context, state, child) {
        return Container(
          decoration: ContainerDecoration.decoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(15.0),
                color: primaryColor,
                child: const Center(
                  child: Text(
                    "Select Date",
                    style: TextStyle(
                      fontSize: 15.0,
                      wordSpacing: 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          state.getFromDate =
                          await MyDatePicker(context).englishDate();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: ContainerDecoration.decoration(
                              color: Colors.grey.shade100),
                          child: TextFieldFormat(
                            textFieldName: 'From Date',
                            textFormField: Container(
                              decoration: ContainerDecoration.decoration(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10.0),
                                child: Text(
                                  state.fromDate.replaceAll("-", "/"),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Expanded(
                        child: InkWell(
                          onTap: () async {
                            state.getToDate =
                            await MyDatePicker(context).englishDate();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: ContainerDecoration.decoration(
                                color: Colors.grey.shade100),
                            child: TextFieldFormat(
                              textFieldName: 'To Date',
                              textFormField: Container(
                                decoration: ContainerDecoration.decoration(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                  child: Text(
                                    state.toDate.replaceAll("-", "/"),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("CANCEL"),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          widget.onConfirm();
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: const Text("CONFIRM"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
