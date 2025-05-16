import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oms_salesforce/src/core/quickorder/quick_order_state.dart';
import 'package:oms_salesforce/src/utils/loading_indicator.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

class AddOutletScreen extends StatelessWidget {
  const AddOutletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<QuickOrderState>();
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: Text(state.selectedRouteName)),
          body: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              // Container(
              //   decoration: ContainerDecoration.decoration(color: successColor),
              //   height: screenHeight / 5,
              //   child: FlutterMap(
              //     options: MapOptions(
              //       // center: const LatLng(51.509364, -0.128928),
              //       zoom: 9.2,
              //     ),
              //     nonRotatedChildren: [
              //       AttributionWidget.defaultWidget(
              //         source: 'OpenStreetMap contributors',
              //         onSourceTapped: null,
              //       ),
              //     ],
              //     children: [
              //       TileLayer(
              //         urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              //         userAgentPackageName: 'com.example.app',
              //       ),
              //     ],
              //   ),
              // ),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 10.0,
                ),
                children: [
                  OutletEntryFormWidget(
                    controller: state.outletName,
                    autoFocus: true,
                    title: "Outlet Name*",
                    onFieldSubmitted: (value) {
                      state.contactPersonFocus.requestFocus();
                    },
                  ),
                  OutletEntryFormWidget(
                    controller: state.contactPerson,
                    title: "Contact Person*",
                    focusNode: state.contactPersonFocus,
                    onFieldSubmitted: (value) {
                      state.mobileNoFocus.requestFocus();
                    },
                  ),
                  OutletEntryFormWidget(
                    controller: state.mobileNo,
                    title: "Mobile No.*",
                    focusNode: state.mobileNoFocus,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value) {
                      state.landlineNoFocus.requestFocus();
                    },
                  ),
                  OutletEntryFormWidget(
                    controller: state.landlineNo,
                    title: "Landline No.",
                    focusNode: state.landlineNoFocus,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value) {
                      state.emailFocus.requestFocus();
                    },
                  ),
                  OutletEntryFormWidget(
                    controller: state.email,
                    title: "Email",
                    focusNode: state.emailFocus,
                    onFieldSubmitted: (value) {
                      state.addressFocus.requestFocus();
                    },
                  ),
                  OutletEntryFormWidget(
                    controller: state.address,
                    title: "Address*",
                    focusNode: state.addressFocus,
                    onFieldSubmitted: (value) {
                      state.panNoFocus.requestFocus();
                    },
                  ),
                  OutletEntryFormWidget(
                    controller: state.panNo,
                    title: "Pan No.",
                    focusNode: state.panNoFocus,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                  ),
                  OutletEntryFormWidget(
                    controller: state.outletType,
                    title: "Outlet Type",
                  ),
                  OutletEntryFormWidget(
                    controller: state.route,
                    readOnly: true,
                    title: "Route",
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await state.createOutlet();
                    },
                    child: const Text("Add Outlet"),
                  )
                ],
              ),
            ],
          ),
        ),
        if (state.isLoading) LoadingScreen.loadingScreen()
      ],
    );
  }
}

class OutletEntryFormWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool readOnly, autoFocus;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const OutletEntryFormWidget({
    super.key,
    required this.title,
    required this.controller,
    this.readOnly = false,
    this.autoFocus = false,
    this.focusNode,
    this.onFieldSubmitted,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: subTitleTextStyle,
          ),
        ),
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: controller,
            readOnly: readOnly,
            autofocus: autoFocus,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: TextFormDecoration.decoration(
              hintText: "",
            ),
          ),
        ),
      ],
    );
  }
}
