import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

import '../model/ledger_notes_model.dart';
import 'save_ledger_notes_state.dart';

class SaveLedgerNotesScreen extends StatefulWidget {
  const SaveLedgerNotesScreen({super.key});

  @override
  State<SaveLedgerNotesScreen> createState() => _SaveLedgerNotesScreenState();
}

class _SaveLedgerNotesScreenState extends State<SaveLedgerNotesScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<SaveLedgetNotesState>(context, listen: false).getContext =
        context;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SaveLedgetNotesState>(
      builder: (context, state, child) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(title: const Text("Notes")),
              body: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(10.0),
                children: [
                  Form(
                    key: state.remarkKey,
                    child: TextFormField(
                      controller: state.remarks,
                      decoration: TextFormDecoration.decoration(
                        hintText: "Remarks",
                        hintStyle: hintTextStyle,
                      ),
                      maxLines: 10,
                      onChanged: (text) {
                        state.remarkKey.currentState!.validate();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '* required';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (state.remarkKey.currentState!.validate()) {
                        await state.saveNotesToAPI();
                      }
                    },
                    child: const Text("Submit"),
                  ),

                  ///
                  ///
                  if (state.notesList.isNotEmpty) ...[
                    const SizedBox(height: 10.0),
                    const CustomDottedDivider(color: Colors.black),
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "My Recent's Notes",
                                style: titleTextStyle.copyWith(
                                    color: Colors.black),
                              ),
                            ),
                            // const CustomDottedDivider(color: Colors.black),

                            TableHeaderWidget(
                              color: Colors.teal.shade300,
                              child: Row(children: [
                                Expanded(
                                  child:
                                      Text("Date", style: tableHeaderTextStyle),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Note Details",
                                    style: tableHeaderTextStyle,
                                  ),
                                ),
                              ]),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.notesList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                LedgerNoteDataModel indexData =
                                    state.notesList[index];
                                return TableDataWidget(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          indexData.noteDate.substring(0, 10),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(indexData.noteDEtails),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  ///
                ],
              ),
            ),
            if (state.isLoading) LoadingScreen.loadingScreen(),
          ],
        );
      },
    );
  }
}
