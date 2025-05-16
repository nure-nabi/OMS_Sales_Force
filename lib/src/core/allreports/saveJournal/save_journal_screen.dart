import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:provider/provider.dart';

import 'model/ledger_model.dart';
import 'save_journal_state.dart';

class SaveJournalScreen extends StatefulWidget {
  const SaveJournalScreen({super.key});

  @override
  State<SaveJournalScreen> createState() => _SaveJournalScreenState();
}

class _SaveJournalScreenState extends State<SaveJournalScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<SaveJournalState>(context, listen: false).getContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SaveJournalState>(
      builder: (context, state, child) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(title: const Text("Save Journal")),
              body: ListView(
                padding: const EdgeInsets.all(10.0),
                children: [
                  ///
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      state.productState.outletDetail.glDesc,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),

                  ///
                  // CustomDropDown<JournalLedgerDataModel>(
                  //   items: state.ledgerList
                  //       .map((item) => DropdownMenuItem<JournalLedgerDataModel>(
                  //           value: item,
                  //           child: Text(
                  //             item.glDesc,
                  //             style: const TextStyle(fontSize: 14),
                  //           )))
                  //       .toList(),
                  //   hint: "Choose Ledger",
                  //   dropdownMaxHeight: 400.0,
                  //   primaryColor: primaryColor,
                  //   borderColor: Colors.grey.shade200,
                  //   onChanged: (JournalLedgerDataModel? value) {
                  //     state.getSelectedLedgerList = value!;
                  //   },
                  // ),

                  ///
                  ///
                  if (state.ledgerList.isNotEmpty)
                    CustomDropdown<JournalLedgerDataModel>.search(
                      hintText: 'Choose Ledger',
                      items: state.ledgerList,
                      excludeSelected: false,
                      listItemBuilder: (_, item, isSelected, onItemSelect) {
                        return Text(item.glDesc);
                      },
                      headerBuilder: (_, item) {
                        return Text(item.glDesc);
                      },
                      overlayHeight: 400,
                      onChanged: (value) {
                        state.getSelectedLedgerList = value;
                      },
                    ),
                  // CustomSearchableDropDown(
                  //   items: state.ledgerList,
                  //   label: 'Choose Ledger',
                  //   decoration: ContainerDecoration.decoration(
                  //     color: Colors.white,
                  //     bColor: Colors.white,
                  //   ),
                  //   prefixIcon: const Padding(
                  //     padding: EdgeInsets.all(0.0),
                  //     child: Icon(Icons.search),
                  //   ),
                  //   dropDownMenuItems: state.ledgerList.map((item) {
                  //     return item.glDesc;
                  //   }).toList(),
                  //   onChanged: (value) {
                  //     if (value != null) {
                  //       state.getSelectedLedgerList = value!;
                  //     } else {
                  //       state.getSelectedLedgerList =
                  //           JournalLedgerDataModel.fromJson({});
                  //     }
                  //   },
                  // ),

                  ///
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: state.debit,
                          maxLength: 20,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,3}')),
                          ],
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          onChanged: (value) {
                            state.updateBoolean(value: value, from: "debit");
                            setState(() {});
                          },
                          readOnly: state.debitBool,
                          decoration: const InputDecoration(
                            labelText: "Debit Amount",
                            hintText: "Entry Debit Amount",
                            counter: Offstage(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: TextFormField(
                          controller: state.credit,
                          maxLength: 20,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,3}')),
                          ],
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          onChanged: (value) {
                            state.updateBoolean(value: value, from: "credit");
                            setState(() {});
                          },
                          readOnly: state.creditBool,
                          decoration: const InputDecoration(
                            labelText: "Credit Amount",
                            hintText: "Enter Credit Amount",
                            counter: Offstage(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: state.remarks,
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      hintText: "Enter Remark",
                      counter: Offstage(),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            ///
                            await state.saveJournal();
                          },
                          child: const Text('CONFIRM'),
                        ),
                      ),
                      // const SizedBox(width: 10.0),
                      // Expanded(
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.pop(context);
                      //     },
                      //     child: const Text('CANCEL'),
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),
            if (state.isLoading) LoadingScreen.loadingScreen()
          ],
        );
      },
    );
  }
}
