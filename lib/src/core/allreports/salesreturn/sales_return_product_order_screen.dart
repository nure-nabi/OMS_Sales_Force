import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oms_salesforce/src/core/allreports/allreports.dart';
import 'package:oms_salesforce/src/core/productorder/productorder.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

class SalesReturnProductOrderScreen extends StatefulWidget {
  const SalesReturnProductOrderScreen({super.key});

  @override
  State<SalesReturnProductOrderScreen> createState() =>
      _SalesReturnProductOrderScreenState();
}

class _SalesReturnProductOrderScreenState
    extends State<SalesReturnProductOrderScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SalesReturnState>(context, listen: false).getContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesReturnState>(
      builder: (context, state, child) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return CustomAlertWidget(
              title: state.productDetails.pDesc,
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
                          value: state.productDetails.pShortName.isNotEmpty
                              ? state.productDetails.pShortName
                              : state.productDetails.pCode,
                        ),
                        RowDataWidget(
                          valueFlex: 2,
                          title: "Group",
                          titleBold: true,
                          valueBold: true,
                          value: state.productDetails.grpDesc,
                        ),
                        RowDataWidget(
                          valueFlex: 2,
                          title: "Buy Rate",
                          titleBold: true,
                          valueBold: true,
                          value: state.productDetails.buyRate,
                        ),

                        ///
                        Divider(color: hintColor),

                        ///
                        ///

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
                              child: TextFormField(
                                controller: state.quantity,
                                onTap: () {
                                  state.quantity.text = "";
                                },
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      state.quantity.text == "0.00") {
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
                                controller: state.salesRate,
                                onTap: () {
                                  state.salesRate.text = "";
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
                                "${state.totalPrice}",
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
                                    // state.getproductDetailss = state.productDetails;
                                    await state.saveProduct();
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
