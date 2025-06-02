import 'package:flutter/material.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';
import 'orderReportDetailsState.dart';
import 'package:icons_plus/icons_plus.dart';

class OrderReportDetailScreen extends StatefulWidget {
  final String vNo;
  final String glDesc;
  final String mobile;
  final String route;
  final String remarks;

  const OrderReportDetailScreen(
      {super.key,
      required this.vNo,
      required this.glDesc,
      required this.mobile,
      required this.route,required this.remarks});

  @override
  State<OrderReportDetailScreen> createState() =>
      _OrderReportDetailScreenState();
}

class _OrderReportDetailScreenState extends State<OrderReportDetailScreen> {
  String outletName = "Order Report Product";

  @override
  void initState() {
    super.initState();
    Provider.of<OrderDetailsState>(context, listen: false)
        .init(vNo: widget.vNo);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderDetailsState>(
      builder: (BuildContext context, state, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: primaryColor,
            title: Text(
              '${widget.glDesc} (Bill No: ${widget.vNo})',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          body: Consumer<OrderDetailsState>(
            builder: (context, orderDetailsStateDetails, _) {
              if (orderDetailsStateDetails.isLoading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: primaryColor),
                      const SizedBox(height: 16),
                      Text('Loading details...',
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: orderDetailsStateDetails.dataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final itemList =
                              orderDetailsStateDetails.dataList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Product: ${itemList.dPDesc.toString()}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    double.parse(itemList.dAltQty) != 0.0
                                        ? _buildDetailRow(
                                            'Alt Qty',
                                            '${itemList.dAltQty.toString()} (${itemList.altUnitCode.toString()})',
                                            Bootstrap.box,
                                          )
                                        : const SizedBox(),
                                    _buildDetailRow(
                                      'Quantity',
                                      '${itemList.dQty.toString()} (${itemList.unitCode.toString()})',
                                      Icons.straighten,
                                    ),
                                    _buildDetailRow(
                                      'Rate',
                                      'Rs ${itemList.dLocalRate}',
                                      Bootstrap.cash_stack,
                                    ),
                                    const Divider(
                                      height: 12,
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Net Amount',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Rs ${itemList.dNetAmt}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Consumer<OrderDetailsState>(
              builder: (context, orderDetailsStateDetails, _) {
                double netAmountTotal = 0.0;
                double netQuantity = 0.0;
                for (var item in orderDetailsStateDetails.dataList) {
                  netAmountTotal += double.tryParse(item.dBasicAmt) ?? 0.0;
                  netQuantity += double.tryParse(item.dQty) ?? 0.0;
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Quantity',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          netQuantity.toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Total Amount',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '₹${netAmountTotal.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () async {
              await state.shareLedger(
                  vNo: widget.vNo,
                  glDesc: widget.glDesc,
                  mobile: widget.mobile,
                  route: widget.route,
                remarks: widget.remarks,
              );
            },
            child: const Icon(Bootstrap.file_earmark_pdf, color: Colors.white),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
