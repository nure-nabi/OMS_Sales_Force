import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../allreports.dart';

class ReportLinkScreen extends StatefulWidget {
  const ReportLinkScreen({super.key});

  @override
  State<ReportLinkScreen> createState() => _ReportLinkScreenState();
}

class _ReportLinkScreenState extends State<ReportLinkScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ReportLinkState>(context, listen: false).getContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportLinkState>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Report Link"),
            actions: [
              IconButton(
                onPressed: () {
                  ShowAlert(context).alert(
                    child: DatePickerWidget(
                      isNepaliPicker: false,
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
          body: ListView.builder(
            itemCount: state.reportLinkList.length,
            itemBuilder: (context, index) {
              LinkReportModel indexData = state.reportLinkList[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () async {
                      await state.openURL(indexData);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        indexData.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                  Container(height: 1, color: Colors.black12)
                ],
              );
            },
          ),
        );
      },
    );
  }
}
