import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oms_salesforce/src/core/productorder/productorder.dart';
import 'package:oms_salesforce/src/utils/loading_indicator.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../pendingsync/pendingsync.dart';
import 'sales_return_state.dart';

class SalesReturnListSection extends StatefulWidget {
  const SalesReturnListSection({super.key});

  @override
  State<SalesReturnListSection> createState() => _SalesReturnListSectionState();
}

class _SalesReturnListSectionState extends State<SalesReturnListSection> {
  @override
  void initState() {
    super.initState();
    Provider.of<SalesReturnState>(context, listen: false).getAllSalesReturnData();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SalesReturnState>();
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: const Text("Order List")),
          bottomNavigationBar: Container(
            decoration: ContainerDecoration.decoration(
              color: borderColor,
              bColor: borderColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, right: 10.0, left: 10.0, bottom: 5.0),
                    child: OrderProductShowList(
                      titleText: "Total",
                      titleStyle: productTitleTextStyle,
                      detailsText: "${state.calculateTotalAmount()}",
                      detailStyle: productTitleTextStyle,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: state.allTempOrderList.isNotEmpty
                        ? () {
                            ShowAlert(context).alert(
                              child: CustomAlertWidget(
                                showCancle: true,
                                title: "Enter Comment",
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Enter Remarks",
                                        style: textFormTitleStyle,
                                      ),
                                      const SizedBox(height: 5.0),
                                      Form(
                                        key: state.commentKey,
                                        child: TextFormField(
                                          controller: state.comment,
                                          maxLines: 1,
                                          style:
                                              const TextStyle(fontSize: 15.0),
                                          onChanged: (value) {
                                            state.commentKey.currentState!
                                                .validate();
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "";
                                            }
                                            return null;
                                          },
                                          decoration:
                                              TextFormDecoration.decoration(
                                            hintText: "Comment",
                                            hintStyle: hintTextStyle.copyWith(
                                                fontSize: 20.0),
                                            containPadding:
                                                const EdgeInsets.all(20.0),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await state.onSalesReturnAPICall();
                                        },
                                        child: const Text("CONFIRM"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        : null,
                    child: const Text("Confirm Order"),
                  ),
                ],
              ),
            ),
          ),
          body: state.allTempOrderList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.allTempOrderList.length,
                  itemBuilder: (context, index) {
                    ProductPendingSync indexData =
                        state.allTempOrderList[index];
                    String vatAmount =
                        (double.parse(indexData.totalAmount) * 0.13)
                            .toStringAsFixed(1);

                    return StatefulBuilder(
                      builder: (BuildContext context, setState) {
                        return Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          indexData.alias,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        verticalSpace(10.0),
                                        RowDataWidget(
                                          title: "Qty",
                                          value: indexData.quantity,
                                          valueAlign: TextAlign.end,
                                        ),
                                        RowDataWidget(
                                          title: "Price",
                                          value: indexData.rate,
                                          valueAlign: TextAlign.end,
                                        ),
                                        RowDataWidget(
                                          title: "Amount",
                                          titleBold: true,
                                          valueBold: true,
                                          valueAlign: TextAlign.end,
                                          value:
                                              "${(double.parse(indexData.rate) * double.parse(indexData.quantity))}",
                                        ),
                                        RowDataWidget(
                                          title: "VAT(13.0)%",
                                          valueAlign: TextAlign.end,
                                          value: vatAmount,
                                        ),
                                        verticalSpace(5.0),
                                        const CustomDottedDivider(
                                          color: Colors.black,
                                        ),
                                        verticalSpace(5.0),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Row(children: [
                                            const Expanded(
                                              child: Text(
                                                "Total",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                            const Expanded(
                                              child: Text(
                                                ' : ',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${state.getIndexTotalAmount(rate: indexData.totalAmount)}",
                                                textAlign: TextAlign.end,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ]),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          ShowAlert(context).alert(
                                            child: ConfirmationWidget(
                                              title: 'Are you sure ?',
                                              description:
                                                  'You want to delete this product.',
                                              onConfirm: () async {
                                                Navigator.pop(context);
                                                await state
                                                    .deleteTempOrderProduct(
                                                  productID:
                                                      indexData.productCode,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.delete_forever,
                                          color: errorColor,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ShowAlert(context).alert(
                                            child: EditOrderProductDetails(
                                              productDetail: indexData,
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.edit,
                                            color: primaryColor),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              : const NoDataWidget(),
          // ),
        ),
        if (state.isLoading) LoadingScreen.loadingScreen(),
      ],
    );
  }
}

class EditOrderProductDetails extends StatefulWidget {
  final ProductPendingSync productDetail;

  const EditOrderProductDetails({super.key, required this.productDetail});

  @override
  State<EditOrderProductDetails> createState() =>
      _EditOrderProductDetailsState();
}

class _EditOrderProductDetailsState extends State<EditOrderProductDetails> {
  late final _updateQty = TextEditingController(text: "0");
  late final _updateRate = TextEditingController(text: "0");

  @override
  void initState() {
    super.initState();
    _updateQty.text = widget.productDetail.quantity;
    _updateRate.text = widget.productDetail.rate;
  }

  @override
  void dispose() {
    _updateQty.dispose();
    _updateRate.dispose();
    super.dispose();
  }

  calculateValue() {
    if (_updateQty.text.isEmpty || _updateRate.text.isEmpty) {
      return "0.00";
    } else {
      return (double.parse(_updateQty.text) * double.parse(_updateRate.text))
          .toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SalesReturnState>();
    ProductPendingSync productDetail = widget.productDetail;
    return CustomAlertWidget(
      title: productDetail.alias,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Current Value",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Container(height: 0.5, color: hintColor),
            verticalSpace(5.0),
            OrderProductShowList(
              titleText: 'Quantity ',
              detailsText: productDetail.quantity,
            ),
            OrderProductShowList(
              titleText: 'Rate ',
              detailsText: productDetail.rate,
            ),
            OrderProductShowList(
              titleText: 'Balance ',
              detailsText: productDetail.totalAmount,
            ),
            verticalSpace(5.0),
            Container(height: 0.5, color: hintColor),
            verticalSpace(5.0),
            const Text(
              "Update Value",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            verticalSpace(5.0),
            Container(height: 0.5, color: hintColor),
            verticalSpace(10.0),
            Row(children: [
              Expanded(
                child: TextFieldFormat(
                  textFieldName: "Quantity",
                  textFormField: TextFormField(
                    controller: _updateQty,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) async {
                      await calculateValue();
                      setState(() {});
                    },
                    maxLength: 10,
                    maxLines: 1,
                    decoration: TextFormDecoration.decoration(hintText: ""),
                  ),
                ),
              ),
              Expanded(
                child: TextFieldFormat(
                  textFieldName: "Rate",
                  textFormField: TextFormField(
                    controller: _updateRate,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) async {
                      await calculateValue();
                      setState(() {});
                    },
                    maxLength: 10,
                    maxLines: 1,
                    decoration: TextFormDecoration.decoration(hintText: ""),
                  ),
                ),
              ),
            ]),
            OrderProductShowList(
              titleText: 'Amount ',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
              detailsText: calculateValue(),
              detailStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
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
                      buttonName: "CANCLE",
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
                        Navigator.pop(context);
                        await state.updateTempOrderProductDetail(
                          productID: productDetail.productCode,
                          rate: _updateRate.text.trim(),
                          quantity: _updateQty.text.trim(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
