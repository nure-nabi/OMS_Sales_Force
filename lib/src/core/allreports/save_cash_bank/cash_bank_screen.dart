import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oms_salesforce/src/core/allreports/save_cash_bank/cash_bank_state.dart';
import 'package:provider/provider.dart';

class SaveCashBankScreen extends StatefulWidget {
  const SaveCashBankScreen({super.key});

  @override
  State<SaveCashBankScreen> createState() => _SaveCashBankScreenState();
}

class _SaveCashBankScreenState extends State<SaveCashBankScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SaveCashBankState>(context, listen: false).getContext = context;
  }

  @override
  void dispose() {
    // Provider.of<SaveCashBankState>(context, listen: false).onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SaveCashBankState>(
      builder: (context, state, child) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Enter Details"),
            ),
            Row(children: [
              Expanded(
                child: TextFormField(
                  controller: state.recAmountController,
                  maxLength: 20,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,3}')),
                  ],
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (value) {
                    state.updateBoolean(value: value, from: "recAmount");
                    setState(() {});
                  },
                  readOnly: state.recAmountReadOnlyValue,
                  decoration: const InputDecoration(
                    labelText: "Rec Amount",
                    hintText: "Entry Rec Amount",
                    counter: Offstage(),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextFormField(
                  controller: state.payAmountController,
                  maxLength: 20,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,3}')),
                  ],
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    state.updateBoolean(value: value, from: "payAmount");
                    setState(() {});
                  },
                  readOnly: state.payAmountReadOnlyValue,
                  decoration: const InputDecoration(
                    labelText: "Pay Amount",
                    hintText: "Enter Pay Amount",
                    counter: Offstage(),
                  ),
                ),
              ),
            ]),
            TextFormField(
              controller: state.remarkController,
              // maxLength: 20,
              onChanged: (value) {},
              decoration: const InputDecoration(
                hintText: "Enter Remark",
                counter: Offstage(),
              ),
            ),
            Row(children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    await state.confirm();
                  },
                  child: const Text('CONFIRM'),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
              ),
            ])
          ]),
        );
      },
    );
  }
}
