import 'package:flutter/material.dart';
import 'package:oms_salesforce/theme/theme.dart';

class GredientContainer extends StatelessWidget {
  final Widget child;
  final bool? reverseGredient;
  const GredientContainer(
      {super.key, required this.child, this.reverseGredient = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: reverseGredient == false
              ? [Colors.white, primaryColor]
              : [primaryColor, Colors.white],
        ),
      ),
      child: child,
    );
  }
}
