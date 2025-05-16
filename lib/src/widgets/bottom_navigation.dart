import 'package:flutter/material.dart';
import 'package:oms_salesforce/theme/theme.dart';

import 'container_decoration.dart';

class BottomNavigationWidget extends StatelessWidget {
  final Widget child;
  const BottomNavigationWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ContainerDecoration.decoration(
        color: primaryColor,
        bColor: primaryColor,
      ),
      padding: const EdgeInsets.all(15.0),
      child: child,
    );
  }
}
