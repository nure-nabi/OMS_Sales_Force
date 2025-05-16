import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class LoadingScreen {
  double value = 0.5;
  static Widget loadingScreen() {
    return Platform.isAndroid
        ? Stack(
            children: [
              Container(color: Colors.black.withAlpha(100)),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const CircularProgressIndicator(),
                ),
              ),
            ],
          )
        : Stack(
            children: [
              Container(color: Colors.black.withAlpha(100)),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const CircularProgressIndicator(),
                ),
              ),
            ],
          );
  }

  static Widget loadingScreenPending(BuildContext context,double percentage) {
    double percentageValue = 0.0;
     if(percentage <= 1.0){
       percentageValue += percentage;
     }
    return Platform.isAndroid
        ? Stack(
            children: [
              Container(color: Colors.black.withAlpha(100)),

              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 0.0),
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: CircularPercentIndicator(
                    radius: 40.0,
                    lineWidth: 5.0,
                     progressColor: Theme.of(context).primaryColor,
                     percent: percentageValue,
                    center: const Text("Please Wait..",style: TextStyle(fontSize: 10),),
                  ),
                ),
              ),
              // Text("data")
            ],
          )
        : Stack(
            children: [
              Container(color: Colors.black.withAlpha(100)),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const CircularProgressIndicator(),
                ),
              ),
            ],
          );
  }

  static Widget dataLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const CircularProgressIndicator(),
        ),
      ],
    );
  }
}


