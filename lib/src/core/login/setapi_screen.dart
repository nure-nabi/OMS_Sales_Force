// import 'package:flutter/material.dart';
// import 'package:oms_salesforce/src/widgets/widgets.dart';
// import 'package:oms_salesforce/theme/theme.dart';
// import 'package:provider/provider.dart';

// import 'login_state.dart';

// class SetAPISection extends StatefulWidget {
//   const SetAPISection({Key? key}) : super(key: key);

//   @override
//   State<SetAPISection> createState() => _SetAPISectionState();
// }

// class _SetAPISectionState extends State<SetAPISection> {
//   final hintText = "http://myomsapi.globaltechsolution.com.np:802/api/";

//   @override
//   Widget build(BuildContext context) {
//     final state = context.watch<LoginState>();
//     return Stack(
//       children: [
//         GredientContainer(
//           child: Scaffold(
//               backgroundColor: Colors.transparent,
//               appBar: AppBar(title: const Text("Enter API")),
//               body: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 8.0,
//                   vertical: 15.0,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(children: [
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 10.0),
//                             child: Text(
//                               " API Example ",
//                               textAlign: TextAlign.start,
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 color: primaryColor,
//                                 wordSpacing: 2,
//                                 fontWeight: FontWeight.bold,
//                                 decoration: TextDecoration.underline,
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {
//                               state.apiController.text = hintText;
//                             },
//                             child: Container(
//                               decoration: ContainerDecoration.decoration(),
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 5.0, vertical: 10.0),
//                               child: Text(
//                                 hintText,
//                                 style: hintTextStyle.copyWith(
//                                   fontSize: 13.0,
//                                   color: Colors.black54,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20.0),
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 10.0),
//                             child: Text(
//                               " Enter Your API ",
//                               textAlign: TextAlign.start,
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 color: primaryColor,
//                                 wordSpacing: 2,
//                                 fontWeight: FontWeight.bold,
//                                 decoration: TextDecoration.underline,
//                               ),
//                             ),
//                           ),
//                           Form(
//                             key: state.apiKey,
//                             child: TextFormField(
//                               controller: state.apiController,
//                               maxLines: 1,
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return "* Required";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               onChanged: (value) {
//                                 if (value.isNotEmpty) {
//                                   state.apiKey.currentState!.validate();
//                                 }
//                               },
//                               autofocus: true,
//                               textAlign: TextAlign.center,
//                               decoration: TextFormDecoration.decoration(
//                                 hintText: "Enter API",
//                               ),
//                             ),
//                           ),
//                         ]),
//                       ),
//                     ),
//                     const SizedBox(height: 10.0),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           await state.setAPI();
//                         },
//                         child: const Text("CONFIRM"),
//                       ),
//                     )
//                   ],
//                 ),
//               )),
//         ),
//       ],
//     );
//   }
// }
