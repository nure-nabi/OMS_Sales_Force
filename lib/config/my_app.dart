import 'package:flutter/material.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';
import '../src/service/router/router.dart';
import 'state_list.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: myStateList,
      child: MaterialApp(
        title: 'OMS|SalesForce',
        debugShowCheckedModeBanner: false,
        scrollBehavior: const ScrollBehavior().copyWith(
          physics: const BouncingScrollPhysics(),
        ),
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: primarySwatch,
          primaryColor: primaryColor,
          appBarTheme: const AppBarTheme(elevation: 0.0),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // home: const TodoScreen(),
        initialRoute: splashPath,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
