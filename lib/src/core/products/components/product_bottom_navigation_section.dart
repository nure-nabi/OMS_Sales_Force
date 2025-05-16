import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../../utils/utils.dart';
import '../product_state.dart';
import 'speed_dial_options.dart';

class ProductBottomNavigationSection extends StatelessWidget {
  const ProductBottomNavigationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductState>();

    return Padding(
      padding: const EdgeInsets.only(
        right: 20.0,
        left: 20.0,
        bottom: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            heroTag: "Info",
            onPressed: () => {},
            child: const Icon(
              Icons.info,
              size: 35.0,
            ),
          ),
          FloatingActionButton(
            heroTag: "Map",
            onPressed: () {
              CustomLog.actionLog(value: state.outletDetail.latitude);
              CustomLog.actionLog(value: state.outletDetail.longitude);
              if (state.outletDetail.latitude.isNotEmpty &&
                  state.outletDetail.longitude.isNotEmpty) {
                MapsLauncher.launchCoordinates(
                  double.parse(state.outletDetail.latitude),
                  double.parse(state.outletDetail.longitude),
                );
              } else {
                ShowToast.errorToast(msg: 'Location not found.');
              }
            },
            child: Icon(
              Icons.pin_drop,
              color: errorColor,
              size: 35.0,
            ),
          ),

          ///
          FloatingActionButton(
            heroTag: "Options",
            onPressed: () => {
              Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: false,
                  barrierColor: Colors.black.withOpacity(.4),
                  transitionDuration: const Duration(milliseconds: 100),
                  reverseTransitionDuration: const Duration(milliseconds: 100),
                  pageBuilder: (_, __, ___) => const SpeedDialOptionsWidget(),
                ),
              ),

              ///
            },
            child: const Icon(Icons.ac_unit, size: 35.0),
          ),

          ///
        ],
      ),
    );
  }
}
