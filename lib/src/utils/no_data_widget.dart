import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/constant/asstes_list.dart';

class NoImageWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final double? imageHeight;
  final double? imageWidth;
  final String? imagePath;

  const NoImageWidget({
    super.key,
    this.title = 'No Data Available',
    this.subtitle = 'There are no items to display at this time.',
    this.imageHeight = 64,
    this.imageWidth = 64,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetsList.noDataImage,
              height: imageHeight,
              width: imageWidth,
            ),
            const SizedBox(height: 16),
            Text(
              title!,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}