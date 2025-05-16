
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/src/service/sharepref/get_all_pref.dart';
import 'package:oms_salesforce/src/widgets/mydropdown/dropdown_class.dart';
import 'package:dropdown_button2/dropdown_button2.dart' as dropdown_button2;
import 'package:flutter/material.dart';

import 'package:oms_salesforce/src/core/allreports/allreports.dart';
import 'package:oms_salesforce/src/core/bill_by_vno/bill_by_vno.dart';
import 'package:oms_salesforce/src/enum/enum.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

import 'package:oms_salesforce/src/service/sharepref/set_all_pref.dart';
import 'package:oms_salesforce/src/core/login/branch/branch_state_order.dart';
import 'package:oms_salesforce/src/core/productorder/product_order_screen.dart';

class LedgerReportScreen extends StatefulWidget {
  const LedgerReportScreen({super.key});

  @override
  State<LedgerReportScreen> createState() => _LedgerReportScreenState();
}

class _LedgerReportScreenState extends State<LedgerReportScreen> {

  bool _isMenuOpen = false;
  @override
  void initState() {
    super.initState();
    Provider.of<BranchStateOrder>(context, listen: false).context = context;
    Provider.of<LedgerReportState>(context, listen: false).getContext = context;
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }
  void _handleMenuSelection(String value) {
    print('Selected: $value');
    setState(() {
      _isMenuOpen = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BranchStateOrder>(context,listen: false);
    return Consumer<LedgerReportState>(builder: (context, state, child) {
      return Stack(
        children: [
          Scaffold(
            appBar: AppBar(title: const Text("Ledger Report"), actions: [
              ///
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      state.pdcIncluded ? "With PDC" : "Without PDC",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Switch(
                      activeColor: Colors.green,
                      value: state.pdcIncluded,
                      onChanged: (value) async {
                        state.getPdcIncluded = value;
                        await state.getAPICall();
                      },
                    ),
                  ),
                ],
              ),
              ///
              IconButton(
                onPressed: () {
                  ShowAlert(context).alert(
                    child: DatePickerWidget(
                      isNepaliPicker: true,
                      onConfirm: () async {
                        await state.onDatePickerConfirm();
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.calendar_month),
              ),
              horizantalSpace(10.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(state.showEnglishDate ? "Date" : "Miti"),
                  ),
                  Flexible(
                    child: Switch(
                      activeColor: successColor,
                      value: state.showEnglishDate,
                      onChanged: (value) {
                        state.getEnglishDate = value;
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      state.shareLedger();
                    },
                    icon: const Icon(Icons.share),
                  ),
                  provider.branchList.isNotEmpty ?
                  PopupMenuButton(
                    child: const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.assignment,
                        color: Colors.white,
                      ),
                    ),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'branch',
                        child: ShowBranch(),
                      )
                    ],

                    onSelected: (val) async {
                      if (val == 'branch') {
                      //  Fluttertoast.showToast(msg: GetAllPref.unitCode());
                      }
                    },
                  ) :  const SizedBox(),
                ],
              ),
            ]),

            body: Column(
              children: [
                ///
                TableHeaderWidget(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        state.productState.outletDetail.glDesc,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 3.0),
                        child: CustomDottedDivider(),
                      ),
                      Row(children: [
                        Expanded(
                          child: Text(
                            state.showEnglishDate ? "Date" : "Miti",
                            style: tableHeaderTextStyle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Dr",
                            style: tableHeaderTextStyle,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Cr",
                            style: tableHeaderTextStyle,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Balance",
                            style: tableHeaderTextStyle,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),

                ///
                ///
                Expanded(
                  child: state.dataList.isNotEmpty ? ListView.builder(
                      itemCount: state.dataList.length,
                      itemBuilder: (context, index) {
                        LedgerReportDataModel indexData = state.dataList[index];
                        // /// For Check and underLins
                        String mySource = indexData.source.toUpperCase();

                        /// For Check and underLins
                        bool checkVoucherType = (mySource == "SALES" ||
                            mySource == "SALES RETURN" ||
                            mySource == "PURCHASE" ||
                            mySource == "PURCHASE RETURN");
                        bool checkPDC = (mySource == "PDC");
                        bool checkCashBank = (mySource == "CASH BANK");
                        return InkWell(
                          onTap: () {
                            checkVoucherType
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BillDetailsByVnoScreen(
                                        vNo: indexData.vno,
                                        name: state.productState.outletDetail.glDesc,
                                        billPrintEnum: mySource ==
                                                "SALES RETURN"
                                            ? BillPrintEnum.salesReturn
                                            : mySource == "PURCHASE"
                                                ? BillPrintEnum.purchases
                                                : mySource == "PURCHASE RETURN"
                                                    ? BillPrintEnum
                                                        .purchasesReturn
                                                    : BillPrintEnum.none,
                                      ),
                                    ),
                                  )
                                : checkPDC
                                    ? context
                                        .read<PDCState>()
                                        .getPDCReportPrintFromAPI(
                                            vNo: indexData.vno,
                                            name: state.productState.outletDetail.glDesc)
                                    : checkCashBank
                                        ? state.getCashBankPrintFromAPI(
                                            vno: indexData.vno,
                                          )
                                        : null;
                          },
                          child: TableDataWidget(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.showEnglishDate
                                              ? indexData.date
                                              : indexData.miti,
                                          style: textFormTitleStyle,
                                          textAlign: TextAlign.start,
                                        ),
                                        const SizedBox(height: 5.0),
                                        Text(
                                          "${indexData.vno}\n${indexData.source}",
                                          style: checkVoucherType ||
                                                  checkPDC ||
                                                  checkCashBank
                                              ? const TextStyle(
                                                  color: Colors.blue,
                                                  decoration:
                                                      TextDecoration.underline,
                                                )
                                              : null,
                                          textAlign: TextAlign.start,
                                        )
                                      ]),
                                ),
                                Expanded(
                                  child: Text(
                                    indexData.dr,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    indexData.cr,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    indexData.total,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }) : const Center(child: Text("No data found!!"),)
                ),
              ],
            ),

            ///
            ///
            ///
            ///

            bottomNavigationBar: TableHeaderWidget(
              child: Row(children: [
                Expanded(
                  child: Text("Total", style: tableHeaderTextStyle),
                ),
                Expanded(
                  child: Text(
                    "${state.totalDebit}",
                    style: tableHeaderTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    "${state.totalCredit}",
                    style: tableHeaderTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    state.getTotalBalance(),
                    style: tableHeaderTextStyle,
                    textAlign: TextAlign.end,
                  ),
                ),
              ]),
            ),
          ),
          if (state.isLoading) LoadingScreen.loadingScreen()
        ],
      );
    });
  }

}

class ShowBranch extends StatefulWidget {

  const ShowBranch({super.key});

  @override
  State<ShowBranch> createState() => _ShowBranchState();
}

class _ShowBranchState extends State<ShowBranch> {

  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LedgerReportState>(context,listen: false);

    return Consumer<BranchStateOrder>(
        builder: (BuildContext context, state, Widget? child) {
          return DropdownButtonHideUnderline(
            child: dropdown_button2.DropdownButton2<String>(
              value: state.unitDesc,
              isDense: true,
              isExpanded: true,
              hint: Text(
                'Select Unit',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: state.branchList.map<DropdownMenuItem<String>>((party) {
                return DropdownMenuItem<String>(
                  value: party.unitDesc.toString(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius:   const BorderRadius.all(Radius.circular(12.0)),
                        color: Colors.grey[200],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(party.unitDesc.toString()),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),

              // Custom display of the selected item
              selectedItemBuilder: (BuildContext context) {
                return state.branchList.map((party)  {
                  return Text(
                    party.unitDesc,
                  );
                }).toList();
              },
              onChanged: (value) async {

               // setState(() async {
                  state.getUnitDesc = value.toString();
                  state.setSelectBranch = true;
                  int index = state.branchList.indexWhere((party) => party.unitDesc.toString() == value);
                  if (index != -1) {
                    String selectedGlCode =state.branchList[index].unitCode;
                    await SetAllPref.setBranch(value: selectedGlCode);
                    await provider.getAPICall();
                    state.getUnitDesc = null;
                    Navigator.of(context).pop();
                  } else {}
               // });
              },
              buttonStyleData: dropdown_button2.ButtonStyleData(
                height: 50,
                width: 350,
                padding: const EdgeInsets.only(left: 14, right: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color:  Colors.black26,
                  ),
                  // color: Colors.redAccent,
                ),
                // elevation: 2,
              ),
              dropdownStyleData: const dropdown_button2.DropdownStyleData(
                maxHeight: 500,
              ),
              menuItemStyleData:  const dropdown_button2.MenuItemStyleData(
                height: 60,
                padding: EdgeInsets.only(left: 14, right: 14),
              ),
              dropdownSearchData: dropdown_button2.DropdownSearchData(
                searchController: textEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search unit...',
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  String itemValue = item.value.toString();
                  String lowercaseItemValue = itemValue.toLowerCase();
                  String uppercaseItemValue = itemValue.toUpperCase();

                  String lowercaseSearchValue = searchValue.toLowerCase();
                  String uppercaseSearchValue = searchValue.toUpperCase();

                  return lowercaseItemValue
                      .contains(lowercaseSearchValue) ||
                      uppercaseItemValue.contains(uppercaseSearchValue) ||
                      itemValue.contains(searchValue);
                },
              ),
              //This to clear the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  textEditingController.clear();
                }
              },
            ),
          );
        });
  }
}

