import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/utils/loading_indicator.dart';
import 'package:oms_salesforce/src/widgets/alert/show_alert.dart';
import 'package:oms_salesforce/src/widgets/tablewidgets/header_table.dart';
import 'package:oms_salesforce/theme/fonts_style.dart';
import 'package:provider/provider.dart';
import '../../../theme/colors.dart';
import '../../utils/no_data_widget.dart';
import 'order_report.dart';

class OrderReportScreen extends StatefulWidget {
  const OrderReportScreen({super.key});

  @override
  State<OrderReportScreen> createState() => _OrderReportScreenState();
}

class _OrderReportScreenState extends State<OrderReportScreen> {
  double percentage = 0.0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<DatePickerState1>(context, listen: false).init();
    Provider.of<OrderReportState>(context, listen: false).getContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderReportState>(builder: (context, state, child) {
      return Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text("Order Report"),
              actions: [
                IconButton(
                  onPressed: () async {
                    await state.getOrderReportFromReport();
                  },
                  icon: const Icon(EvaIcons.refreshOutline),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: IconButton(
                      onPressed: () {
                        ShowAlert(context).alert(
                          child: DatePickerWidget1(
                            onConfirm: () async {
                              await state.onDatePickerConfirm();
                            },
                          ),
                        );
                      },
                      tooltip: 'Select DateWise Order Report',
                      icon: const Icon(
                        Icons.calendar_month,
                        size: 28.0,
                      )),
                )
              ],
            ),
            body: Column(
              children: [
                TableHeaderWidget(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Date",
                          style: tableHeaderTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Expanded(
                        child: Text(''),
                      ),
                      Expanded(
                        child: Text(
                          "Amount",
                          style: tableHeaderTextStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: state.dateWiseList.isNotEmpty
                      ? _buildDeliveryList(state)
                      : const NoImageWidget(),
                ),
              ],
            ),
          ),
          if (state.isLoading) LoadingScreen.loadingScreen(),
        ],
      );
    });
  }

  Widget _buildDeliveryList(OrderReportState state) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListView.builder(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: state.dateWiseList.length,
        itemBuilder: (context, index) {
          OrderReportDataModel indexData = state.dateWiseList[index];
          return _buildDeliveryItem(indexData, state, index);
        },
      ),
    );
  }

  Widget _buildDeliveryItem(
      OrderReportDataModel indexData, OrderReportState state, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            state.getSelectedDate = indexData;
            state.onDateSelected();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        indexData.vDate,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        indexData.vDate,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Rs. ${indexData.netAmt}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
