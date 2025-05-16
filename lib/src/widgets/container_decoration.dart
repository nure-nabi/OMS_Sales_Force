import 'package:flutter/material.dart';
import 'package:oms_salesforce/theme/theme.dart';

class ContainerDecoration {
  static decoration({
    Color? bColor,
    Color? color,
    BorderRadiusGeometry? borderRadius,
  }) {
    return BoxDecoration(
      color: color ?? Colors.white,
      border: Border.all(color: bColor ?? borderColor),
      borderRadius: borderRadius ?? BorderRadius.circular(5.0),
    );
  }
}
