// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:maps_launcher/maps_launcher.dart';

// class InAppViewWidget extends StatefulWidget {
//   final String latitude, longitude;
//   const InAppViewWidget(
//       {super.key, required this.latitude, required this.longitude});

//   @override
//   State<InAppViewWidget> createState() => _InAppViewWidgetState();
// }

// class _InAppViewWidgetState extends State<InAppViewWidget> {
//   late InAppWebViewController _webViewController;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('In-App Map View')),
//       body: Column(
//         children: [
//           Expanded(
//             child: InAppWebView(
//               initialUrlRequest: URLRequest(
//                 url: MapsLauncher.createCoordinatesUri(
//                   double.parse(widget.latitude),
//                   double.parse(widget.longitude),
//                 ),
//               ),
//               onWebViewCreated: (controller) {
//                 _webViewController = controller;
//               },
//               initialOptions: InAppWebViewGroupOptions(
//                 crossPlatform: InAppWebViewOptions(
//                   javaScriptEnabled: true,
//                 ),
//               ),
//             ),
//           ),
//           // Padding(
//           //   padding: const EdgeInsets.all(16),
//           //   child: ElevatedButton(
//           //     onPressed: () async {
//           //       await launchMap(37.4220041,
//           //           -122.0862462); // replace with your own coordinates
//           //     },
//           //     child: const Text('Launch Map'),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
// //   getMAPLoad() async {
// //     await getURL();
// //   }

// //   Future<String> getURL() async {
// //     Uri url = MapsLauncher.createCoordinatesUri(
// //       double.parse(widget.latitude),
// //       double.parse(widget.longitude),
// //     );

// //     CustomLog.actionLog(value: "GET URL => ${getURL()}");
// //     return url.toString();
// //   }

// //   @override
// //   void initState() {
// //     super.initState();

// //     getMAPLoad();
// //   }

// //   late InAppWebViewController _webViewController;
// //   String url = "";
// //   double progress = 0;

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(title: const Text('InAppWebView Example')),
// //         body: Column(children: <Widget>[
// //           Expanded(
// //             // child: Container(
// //             //   margin: const EdgeInsets.all(10.0),
// //             //   decoration:
// //             //       BoxDecoration(border: Border.all(color: Colors.blueAccent)),
// //             //   child: FutureBuilder(
// //             //     future: getURL(),
// //             //     builder: (context, AsyncSnapshot<dynamic> snapshot) {
// //             //       if (!snapshot.hasData) {
// //             //         return LoadingScreen.dataLoading();
// //             //       }
// //             //       return InAppWebView(
// //             //         initialUrlRequest: URLRequest(
// //             //           url: getURL(),
// //             //         ),
// //             //         initialOptions: InAppWebViewGroupOptions(
// //             //             crossPlatform: InAppWebViewOptions(
// //             //                 // debuggingEnabled: true,
// //             //                 )),
// //             //         onWebViewCreated: (InAppWebViewController controller) {
// //             //           _webViewController = controller;
// //             //         },
// //             //         // onLoadStart: (InAppWebViewController controller, String url) {
// //             //         //   setState(() {
// //             //         //     this.url = url;
// //             //         //   });
// //             //         // },
// //             //         // onLoadStop:
// //             //         //     (InAppWebViewController controller, String url) async {
// //             //         //   setState(() {
// //             //         //     this.url = url;
// //             //         //   });
// //             //         // },
// //             //         onProgressChanged:
// //             //             (InAppWebViewController controller, int progress) {
// //             //           setState(() {
// //             //             this.progress = progress / 100;
// //             //           });
// //             //         },
// //             //       );
// //             //     },
// //             //   ),
// //             // ),

// //             child: FutureBuilder(
// //               builder: (ctx, snapshot) {
// //                 // Checking if future is resolved or not
// //                 if (snapshot.connectionState == ConnectionState.done) {
// //                   // If we got an error
// //                   if (snapshot.hasError) {
// //                     return Center(
// //                       child: Text(
// //                         '${snapshot.error} occurred',
// //                         style: TextStyle(fontSize: 18),
// //                       ),
// //                     );

// //                     // if we got our data
// //                   } else if (snapshot.hasData) {
// //                     // Extracting data from snapshot object
// //                     final data = snapshot.data as String;
// //                     return Center(
// //                       child: Text(
// //                         '$data',
// //                         style: TextStyle(fontSize: 18),
// //                       ),
// //                     );
// //                   }
// //                 }

// //                 // Displaying LoadingSpinner to indicate waiting state
// //                 return Center(
// //                   child: CircularProgressIndicator(),
// //                 );
// //               },

// //               // Future that needs to be resolved
// //               // inorder to display something on the Canvas
// //               future: getMAPLoad(),
// //             ),
// //           ),

// //           ///
// //           ButtonBar(
// //             alignment: MainAxisAlignment.center,
// //             children: <Widget>[
// //               TextButton(
// //                 child: const Icon(Icons.arrow_back),
// //                 onPressed: () {
// //                   _webViewController.goBack();
// //                 },
// //               ),
// //               TextButton(
// //                 child: const Icon(Icons.arrow_forward),
// //                 onPressed: () {
// //                   _webViewController.goForward();
// //                 },
// //               ),
// //               TextButton(
// //                 child: const Icon(Icons.refresh),
// //                 onPressed: () {
// //                   _webViewController.reload();
// //                 },
// //               ),
// //             ],
// //           ),
// //         ]),
// //       ),
// //     );
// //   }
// // }

