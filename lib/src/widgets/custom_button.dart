import 'package:flutter/material.dart';
import 'package:oms_salesforce/theme/colors.dart';

class SaveButton extends StatelessWidget {
  final String buttonName;
  final void Function() onClick;
  const SaveButton({
    super.key,
    required this.buttonName,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: primaryColor,
      child: InkWell(
        onTap: () {
          onClick();
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            buttonName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class CancleButton extends StatelessWidget {
  final String buttonName;
  final void Function() onClick;
  const CancleButton({
    super.key,
    required this.buttonName,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: errorColor,
      child: InkWell(
        onTap: () {
          onClick();
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            buttonName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
