import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenWithUrl {
  static Future<void> openUrl({required String url}) async {
    Uri myUrl = Uri.parse(url);
    debugPrint("My URL => $myUrl");
    if (!await launchUrl(
      myUrl,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $myUrl');
    }
  }
}
