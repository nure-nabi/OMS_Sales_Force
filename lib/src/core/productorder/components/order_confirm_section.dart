import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/src/service/router/router.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../../service/sharepref/get_all_pref.dart';
import '../../../service/sharepref/set_all_pref.dart';
import '../../../widgets/alert/show_alert.dart';
import '../../../widgets/container_decoration.dart';
import '../../../widgets/space.dart';
import '../../../widgets/text_field_decoration.dart';
import '../../login/branch/branch_state.dart';
import '../../login/branch/branch_state_order.dart';
import '../../pdf/pdf.dart';
import '../../pdf/product_order_pdf.dart';
import '../../savemovement/savemovement.dart';
import '../db/product_order_db.dart';
import '../db/temp_product_order_db.dart';
import '../model/product_order_model.dart';
import '../product_order_state.dart';

class OrderConfirmSection extends StatefulWidget {
  const OrderConfirmSection({super.key});

  @override
  State<OrderConfirmSection> createState() => _OrderConfirmSectionState();
}

class _OrderConfirmSectionState extends State<OrderConfirmSection> {
  late int value = 1;
  final TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<BranchState>().context = context;
    // });
    Provider.of<BranchStateOrder>(context, listen: false).context = context;
    Provider.of<ProductOrderState>(context, listen: false).onAddCommentInit();
  }
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductOrderState>();
    return Scaffold(
      appBar: AppBar(title: const Text("Add Comment")),
      bottomSheet: _noteSection(),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        children: [
          Form(
            key: state.commentKey,
            child: TextFormField(
              controller: state.comment,
              maxLines: 1,
              style: const TextStyle(fontSize: 15.0),
              onChanged: (value) {
                state.commentKey.currentState!.validate();
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "";
                }
                return null;
              },
              decoration: TextFormDecoration.decoration(
                hintText: "Comment",
                hintStyle: hintTextStyle.copyWith(fontSize: 20.0),
                containPadding: const EdgeInsets.all(20.0),
              ),
            ),
          ),

          ///
          ///
          ///
          optionsWidget(title: "By Visit", index: 1),
          optionsWidget(title: "By Phone/SMS", index: 2),

          ///
          verticalSpace(10.0),

          ///
          ///
          _buttonWidget(state),
        ],
      ),
    );
  }

  ///

  Widget optionsWidget({required String title, required int index}) {
    final state = context.watch<ProductOrderState>();
    return Container(
      decoration: ContainerDecoration.decoration(
        color: (value == index) ? borderColor : null,
      ),
      child: InkWell(
        onTap: () {
          value = index;
          state.getOrderOption = title;
          // CustomLog.actionLog(value: "VehicleType => $index");
          setState(() {});
        },
        child: ListTile(
          title: Text(title),
          trailing: (value == index) ? const Icon(Icons.check) : null,
        ),
      ),
    );
  }
  //http://myomsapi.globaltechsolution.com.np:802/api/User/GetCompanyUnits?DbName=BRANCH0101&Usercode=

  Widget _buttonWidget(ProductOrderState state) {
    bool flag = false;
    final provider = Provider.of<BranchStateOrder>(context,listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        provider.branchList.isNotEmpty ?
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<BranchStateOrder>(
                builder: (BuildContext context, state, Widget? child) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
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
                      onChanged: (value) {
                        setState(() async {
                          state.getUnitDesc = value.toString();
                          state.setSelectBranch = true;
                        //  state.getStatus = true;
                         // await SetAllPref.customerName(value: value.toString());

                          int index = state.branchList.indexWhere((party) => party.unitDesc.toString() == value);

                          if (index != -1) {
                            String selectedGlCode =state.branchList[index].unitCode;
                           await SetAllPref.setBranch(value: selectedGlCode);
                           // state.getUnitCode = selectedGlCode;

                            // Fluttertoast.showToast(msg: selectedGlCode);
                          } else {}
                        });
                      },

                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: 350,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: provider.selectBranch == false ? Colors.red : Colors.black26,
                          ),
                          // color: Colors.redAccent,
                        ),
                        // elevation: 2,
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        maxHeight: 500,
                      ),
                      menuItemStyleData:  const MenuItemStyleData(
                        height: 60,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                      dropdownSearchData: DropdownSearchData(
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
                }),
            const SizedBox(height: 7,),
            provider.selectBranch == false ?
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const ElevatedButton(
                  onPressed: null,
                  child: Text("Add Comment"),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("OR", style: titleTextStyle),
                  ),
                ),

                ///
                ElevatedButton.icon(
                  style: TextButton.styleFrom(backgroundColor: Colors.green),
                  icon: const Icon(Icons.print_rounded),
                  label: const Text("Add Comment And Print"),
                  onPressed: null,
                ),
              ],
            ) : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (state.commentKey.currentState!.validate()) {
                      if(provider.unitDesc!.isNotEmpty) {
                        provider.getUnitDesc = null;
                        await state.onFinalOrderSaveToDB().whenComplete(() {
                          context
                              .read<SaveMovementState>()
                              .saveMovementToDatabase(
                              message: 'Product Order Taken');
                          ShowAlert(context).alert(
                              child: Center(
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Your order has been saved successfully !!!",
                                          style: titleTextStyle.copyWith(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        verticalSpace(10.0),
                                        ElevatedButton(
                                          onPressed: () async {
                                          //  await TempProductOrderDatabase.instance.deleteData();
                                            Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              homePagePath,
                                                  (route) => false,
                                            );
                                          },
                                          child: const Text("OK"),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        });
                      }else{
                        Fluttertoast.showToast(msg: "Please select unit");
                      }
                    }
                  },
                  child: const Text("Add Comment"),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("OR", style: titleTextStyle),
                  ),
                ),

                ///
                ElevatedButton.icon(
                  style: TextButton.styleFrom(backgroundColor: Colors.green),
                  icon: const Icon(Icons.print_rounded),
                  label: const Text("Add Comment And Print"),
                  onPressed: () async {
                    if (state.commentKey.currentState!.validate()) {
                      await state.onFinalOrderSaveToDB().whenComplete(() {
                        context
                            .read<SaveMovementState>()
                            .saveMovementToDatabase(message: 'Product Order Taken');
                        ShowAlert(context).alert(
                            child: Center(
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Your order has been saved successfully !!!",
                                        style: titleTextStyle.copyWith(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      verticalSpace(10.0),
                                      ElevatedButton(
                                        onPressed: () async {
                                          // Navigator.of(context).pop();
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            homePagePath,
                                                (route) => false,
                                          );
                                          List<ProductOrderModel> productList =
                                          await ProductOrderDatabase.instance
                                              .getOrderByOutletAndRoute(
                                            outletCode:
                                            state.productState.outletDetail.glCode,
                                            routeCode:
                                            state.productState.outletDetail.routeCode,
                                          );

                                          final pdfFile = await OrderProductPdfApi.generate(
                                            companyDetails: state.companyDetail,
                                            outletDetails: state.productState.outletDetail,
                                            productList: productList,
                                          );
                                          ////  opening the pdf file
                                          FileHandleApi.openFile(pdfFile);
                                        },
                                        child: const Text("OK"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      });
                    }
                  },
                ),
              ],
            ),
          ],
        ) :


        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                if (state.commentKey.currentState!.validate()) {
                  await state.onFinalOrderSaveToDB().whenComplete(() {
                    context
                        .read<SaveMovementState>()
                        .saveMovementToDatabase(message: 'Product Order Taken');
                    ShowAlert(context).alert(
                        child: Center(
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Your order has been saved successfully !!!",
                                    style: titleTextStyle.copyWith(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  verticalSpace(10.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        homePagePath,
                                            (route) => false,
                                      );
                                    },
                                    child: const Text("OK"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
                  });

                }
              },
              child: const Text("Add Comment"),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("OR", style: titleTextStyle),
              ),
            ),

            ///
            ElevatedButton.icon(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              icon: const Icon(Icons.print_rounded),
              label: const Text("Add Comment And Print"),
              onPressed: () async {
                if (state.commentKey.currentState!.validate()) {
                  await state.onFinalOrderSaveToDB().whenComplete(() {
                    context
                        .read<SaveMovementState>()
                        .saveMovementToDatabase(message: 'Product Order Taken');
                    ShowAlert(context).alert(
                        child: Center(
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Your order has been saved successfully !!!",
                                    style: titleTextStyle.copyWith(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  verticalSpace(10.0),
                                  ElevatedButton(
                                    onPressed: () async {

                                      // Navigator.of(context).pop();
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        homePagePath,
                                            (route) => false,
                                      );
                                      List<ProductOrderModel> productList =
                                      await ProductOrderDatabase.instance
                                          .getOrderByOutletAndRoute(
                                        outletCode:
                                        state.productState.outletDetail.glCode,
                                        routeCode:
                                        state.productState.outletDetail.routeCode,
                                      );

                                      final pdfFile = await OrderProductPdfApi.generate(
                                        companyDetails: state.companyDetail,
                                        outletDetails: state.productState.outletDetail,
                                        productList: productList,
                                      );
                                      ////  opening the pdf file
                                      FileHandleApi.openFile(pdfFile);
                                    },
                                    child: const Text("OK"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
                  });
                }
              },
            ),
          ],
        ),

    //     provider.branchList.isNotEmpty ?
    //     Container(
    //   height: 50,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(10),
    //     border: Border.all(color: Colors.grey, width: 1),
    //   ),
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: DropdownButton<String>(
    //       value: provider.selectedUnit,
    //       hint:  const Text('Select Unit',),
    //       isExpanded: true,
    //       icon: const Icon(Icons.keyboard_arrow_down),
    //       style: const TextStyle(color: Colors.black),
    //       underline: Container(
    //         height: 0.0,
    //       ),
    //       items: provider.branchList.map((unit) {
    //         return DropdownMenuItem<String>(
    //           value: unit.unitDesc,
    //           child: Text(unit.unitDesc,),
    //         );
    //       }).toList(),
    //       onChanged: (value) {
    //         setState(() {
    //           provider.selectedUnit = value!;
    //           Fluttertoast.showToast(msg: value.toString());
    //
    //         });
    //       },
    //     ),
    //   ),
    // )
    //         : SizedBox(),
    //     const SizedBox(height: 5,),
    //     provider.branchList.isNotEmpty ?
    //     ElevatedButton(
    //       onPressed:  () async {
    //         if (state.commentKey.currentState!.validate()) {
    //          // Fluttertoast.showToast(msg: provider.selectedUnit);
    //           if(provider.selectedUnit!.isEmpty){
    //             Fluttertoast.showToast(msg: "Please select branch unit");
    //           }else{
    //           await state.onFinalOrderSaveToDB().whenComplete(() {
    //             context
    //                 .read<SaveMovementState>()
    //                 .saveMovementToDatabase(message: 'Product Order Taken');
    //             ShowAlert(context).alert(
    //                 child: Center(
    //               child: Container(
    //                 color: Colors.white,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(15.0),
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: [
    //                       Text(
    //                         "Your order has been saved successfully !!!",
    //                         style: titleTextStyle.copyWith(
    //                           color: Colors.black,
    //                           fontSize: 14.0,
    //                           fontWeight: FontWeight.normal,
    //                         ),
    //                       ),
    //                       verticalSpace(10.0),
    //                       ElevatedButton(
    //                         onPressed: () {
    //                           Navigator.pushNamedAndRemoveUntil(
    //                             context,
    //                             homePagePath,
    //                             (route) => false,
    //                           );
    //                         },
    //                         child: const Text("OK"),
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ));
    //           });
    //         }
    //           }
    //       } ,
    //       child: const Text("Add Comment"),
    //     ) :
    //          ElevatedButton(
    //       onPressed: () async {
    //         if (state.commentKey.currentState!.validate()) {
    //             await state.onFinalOrderSaveToDB().whenComplete(() {
    //               context
    //                   .read<SaveMovementState>()
    //                   .saveMovementToDatabase(message: 'Product Order Taken');
    //               ShowAlert(context).alert(
    //                   child: Center(
    //                     child: Container(
    //                       color: Colors.white,
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(15.0),
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           crossAxisAlignment: CrossAxisAlignment.center,
    //                           mainAxisSize: MainAxisSize.min,
    //                           children: [
    //                             Text(
    //                               "Your order has been saved successfully !!!",
    //                               style: titleTextStyle.copyWith(
    //                                 color: Colors.black,
    //                                 fontSize: 14.0,
    //                                 fontWeight: FontWeight.normal,
    //                               ),
    //                             ),
    //                             verticalSpace(10.0),
    //                             ElevatedButton(
    //                               onPressed: () {
    //                                 Navigator.pushNamedAndRemoveUntil(
    //                                   context,
    //                                   homePagePath,
    //                                       (route) => false,
    //                                 );
    //                               },
    //                               child: const Text("OK"),
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ));
    //             });
    //
    //         }
    //       },
    //       child: const Text("Add Comment"),
    //     ),



        ///
      ],
    );
  }

  Widget _noteSection() {
    return Container(
      decoration: ContainerDecoration.decoration(
        bColor: Colors.red,
        color: Colors.red,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: RichText(
          textAlign: TextAlign.start,
          text: const TextSpan(
            style: TextStyle(color: Colors.white, fontSize: 14.0),
            children: <TextSpan>[
              TextSpan(
                text: 'Note : ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Orders are saved locally. Sync from the home page to upload.',
              ),
            ],
          ),
          textScaler: const TextScaler.linear(1),
        ),
      ),
    );
  }
}
