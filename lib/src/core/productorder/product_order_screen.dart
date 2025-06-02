import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

import 'components/order_list_section.dart';
import 'product_order_state.dart';

class ProductOrderScreen extends StatefulWidget {
  const ProductOrderScreen({super.key});

  @override
  State<ProductOrderScreen> createState() => _ProductOrderScreenState();
}

class _ProductOrderScreenState extends State<ProductOrderScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductOrderState>(context, listen: false).getContext = context;
  }

  @override
  Widget build(BuildContext context) {
   final orderProvider = Provider.of<ProductOrderState>(context, listen: false);
    return Consumer<ProductOrderState>(
      builder: (context, state, child) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return CustomAlertWidget(
              title: state.productDetail.pDesc,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(5.0),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Form(
                    key: state.orderFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        verticalSpace(10.0),

                        RowDataWidget(
                          valueFlex: 2,
                          title: "Code",
                          titleBold: true,
                          valueBold: true,
                          value: state.productDetail.pShortName.isNotEmpty
                              ? state.productDetail.pShortName
                              : state.productDetail.pCode,
                        ),
                        RowDataWidget(
                          valueFlex: 2,
                          title: "Group",
                          titleBold: true,
                          valueBold: true,
                          value: state.productDetail.grpDesc,
                        ),
                        // RowDataWidget(
                        //   valueFlex: 2,
                        //   title: "Buy Rate",
                        //   titleBold: true,
                        //   valueBold: true,
                        //   value: state.productDetail.buyRate,
                        // ),
                        RowDataWidget(
                          valueFlex: 2,
                          title: "MRP",
                          titleBold: true,
                          valueBold: true,
                          value: state.productDetail.mrp,
                        ),
                        double.parse(state.productDetail.altQty) > 0? RowDataWidget(
                          valueFlex: 2,
                          title: "Unit Code",
                          titleBold: true,
                          valueBold: true,
                          value: state.productDetail.unitCode,
                        ):const SizedBox.shrink(),
                        // RowDataWidget(
                        //   valueFlex: 2,
                        //   title: "Alt Qty Conversion",
                        //   titleBold: true,
                        //   valueBold: true,
                        //   value: state.productDetail.altQty,
                        // ),

                        ///
                        Divider(color: hintColor),

                        ///
                        ///
                        //AlQty
                        double.parse(state.productDetail.altQty) > 0?
                        Container(
                          margin: const EdgeInsets.all(3.0),
                          child: Row(children: [
                            const Expanded(
                              flex: 3,
                              child: Text(
                                "Alt Qty",
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                            const Expanded(
                                child:
                                Text(' : ', textAlign: TextAlign.center)),
                            Expanded(
                              flex: 5,
                              // child: TextFormField(
                              //   controller: state.quantity,
                              //   onTap: () {
                              //     state.quantity.text = "";
                              //   },
                              //   onChanged: (text) {
                              //     state.calculate();
                              //     setState(() {});
                              //   },
                              //   validator: (value) {
                              //     if (value!.isEmpty) {
                              //       return "";
                              //     } else {
                              //       return null;
                              //     }
                              //   },
                              //   keyboardType: TextInputType.number,
                              //   inputFormatters: <TextInputFormatter>[
                              //     FilteringTextInputFormatter.allow(
                              //         RegExp(r"[0-9.]")),
                              //   ],
                              //   maxLength: 10,
                              //   maxLines: 1,
                              //   decoration: InputDecoration(
                              //     counter: const Offstage(),
                              //     hintText: 'Enter Quantity',
                              //     contentPadding: const EdgeInsets.symmetric(
                              //         vertical: 10.0, horizontal: 10.0),
                              //     focusedBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(5.0),
                              //         borderSide:
                              //             const BorderSide(color: Colors.blue)),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(5.0),
                              //       borderSide:
                              //           BorderSide(color: Colors.grey.shade300),
                              //     ),
                              //     border: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(5.0),
                              //     ),
                              //   ),
                              // ),
                              child: TextFormField(
                                controller: state.altQty,
                                onTap: () {
                                  state.altQty.text = "";
                                  state.quantity.text = "0.00";
                                  state.calculate();
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (text) {
                                  state.orderFormKey.currentState!.validate();
                                  state.calculate();
                                  setState(() {});
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,3}')),
                                ],
                                decoration: InputDecoration(
                                  filled: true,
                                  counter: const Offstage(),
                                  isDense: true,
                                  hintText: "",
                                  labelStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                  contentPadding: const EdgeInsets.all(10.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color: primaryColor,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ): const SizedBox.shrink(),
                        //qty
                        Container(
                          margin: const EdgeInsets.all(3.0),
                          child: Row(children: [
                            const Expanded(
                              flex: 3,
                              child: Text(
                                "Quantity",
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                            const Expanded(
                                child:
                                    Text(' : ', textAlign: TextAlign.center)),
                            Expanded(
                              flex: 5,
                              // child: TextFormField(
                              //   controller: state.quantity,
                              //   onTap: () {
                              //     state.quantity.text = "";
                              //   },
                              //   onChanged: (text) {
                              //     state.calculate();
                              //     setState(() {});
                              //   },
                              //   validator: (value) {
                              //     if (value!.isEmpty) {
                              //       return "";
                              //     } else {
                              //       return null;
                              //     }
                              //   },
                              //   keyboardType: TextInputType.number,
                              //   inputFormatters: <TextInputFormatter>[
                              //     FilteringTextInputFormatter.allow(
                              //         RegExp(r"[0-9.]")),
                              //   ],
                              //   maxLength: 10,
                              //   maxLines: 1,
                              //   decoration: InputDecoration(
                              //     counter: const Offstage(),
                              //     hintText: 'Enter Quantity',
                              //     contentPadding: const EdgeInsets.symmetric(
                              //         vertical: 10.0, horizontal: 10.0),
                              //     focusedBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(5.0),
                              //         borderSide:
                              //             const BorderSide(color: Colors.blue)),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(5.0),
                              //       borderSide:
                              //           BorderSide(color: Colors.grey.shade300),
                              //     ),
                              //     border: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(5.0),
                              //     ),
                              //   ),
                              // ),
                              child: TextFormField(
                                controller: state.quantity,
                                onTap: () {
                                  state.quantity.text = "";
                                  state.altQty.text = "0.00";
                                  state.calculate();
                                },
                                validator: (value) {
                                  if (value!.isEmpty ) {
                                    return "";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (text) {
                                  state.orderFormKey.currentState!.validate();
                                  state.calculate();
                                  setState(() {});
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,3}')),
                                ],
                                decoration: InputDecoration(
                                  filled: true,
                                  counter: const Offstage(),
                                  isDense: true,
                                  hintText: "",
                                  labelStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                  contentPadding: const EdgeInsets.all(10.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color: primaryColor,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),

                        ///
                        ///
                        ///
                        Container(
                          margin: const EdgeInsets.all(3.0),
                          child: Row(children: [
                            const Expanded(
                              flex: 3,
                              child: Text(
                                "Sales Rate",
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                            const Expanded(
                                child:
                                    Text(' : ', textAlign: TextAlign.center)),
                            Expanded(
                              flex: 5,
                              child: TextFormField(
                                readOnly: true,
                                controller: state.salesRate,
                                onTap: () {
                                //  state.salesRate.text = "";
                                },
                                validator: (value) {
                                  // if (value!.isEmpty) {
                                  //   return "";
                                  // } else {
                                  //   return null;
                                  // }
                                },
                                onChanged: (text) {
                                 // state.orderFormKey.currentState!.validate();

                                //  state.calculate();
                                 // setState(() {});
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  counter: const Offstage(),
                                  isDense: true,
                                  hintText: "",
                                  labelStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                  contentPadding: const EdgeInsets.all(10.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color: primaryColor,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),

                        //vate
                        Container(
                          margin: const EdgeInsets.all(3.0),
                          child: Row(children: [
                            const Expanded(
                              flex: 3,
                              child: Text(
                                "Vat 13%",
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                            const Expanded(
                                child:
                                Text(' : ', textAlign: TextAlign.center)),
                            Expanded(
                                flex: 5,
                                child: Text(
                                  state.totalVat.toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                   // fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ]),
                        ),
                        ///
                        ///

                        // OrderProductShowList(
                        //   titleText: ' ',
                        //   titleStyle: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 18.0,
                        //     color: Colors.blueGrey.shade400,
                        //   ),
                        //   detailsText: "${state.totalPrice}",
                        //   detailStyle: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 18.0,
                        //     color: Colors.blueGrey.shade400,
                        //   ),
                        // ),

                        Row(children: [
                          const Expanded(
                              flex: 3,
                              child: Text(
                                "Amount",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          const Expanded(
                              child: Text(' : ', textAlign: TextAlign.center)),
                          Expanded(
                              flex: 5,
                              child: Text(
                                state.totalPriceWithVat.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ]),

                        Divider(
                          thickness: 1,
                          color: Colors.grey.shade200,
                          height: 10.0,
                        ),

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CancleButton(
                                  buttonName: "CANCEL",
                                  onClick: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              horizantalSpace(10.0),
                              Expanded(
                                child: SaveButton(
                                  buttonName: "CONFIRM",
                                  onClick: () async {
                                    orderProvider.getAllTempProductOrderList();
                                    // state.getProductDetails = state.productDetail;
                                    await state.saveTempProduct(state.productDetail.pCode);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class OrderProductShowList extends StatelessWidget {
  final String titleText, detailsText;
  final TextStyle? titleStyle, detailStyle;

  const OrderProductShowList({
    super.key,
    required this.titleText,
    required this.detailsText,
    this.titleStyle,
    this.detailStyle,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    );
    return detailsText.isEmpty
        ? verticalSpace(0)
        : Container(
            margin: const EdgeInsets.all(3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(titleText, style: titleStyle ?? textStyle),
                ),
                Expanded(
                  child: Text(":", style: titleStyle ?? textStyle),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    detailsText,
                    style: detailStyle ?? titleStyle,
                  ),
                ),
              ],
            ),
          );
  }
}
