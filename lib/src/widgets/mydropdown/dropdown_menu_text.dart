import 'package:flutter/material.dart';

class DropDownMenuText extends StatelessWidget {
  final String item;

  const DropDownMenuText({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Text(
      item,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 13.0),
    );
  }
}
