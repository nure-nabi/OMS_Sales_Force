import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/src/service/database/database.dart';
import 'package:sqflite/sqflite.dart';

import '../../../utils/custom_log.dart';
import '../model/ledger_model.dart';

class LedgerReportDatabase {
  Database? db;

  LedgerReportDatabase._privateConstructor();

  static final LedgerReportDatabase instance =
      LedgerReportDatabase._privateConstructor();

  Future<int> insertData(LedgerReportDataModel data) async {
    db = await DatabaseHelper.instance.database;
    return await db!.insert(
      DatabaseDetails.ledgerDetailTable,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future deleteData() async {
    String myQuery = '''  DELETE FROM ${DatabaseDetails.ledgerDetailTable} ''';
    db = await DatabaseHelper.instance.database;
    return await db!.rawQuery(myQuery);
  }

  Future<List<LedgerReportDataModel>> getAllDataList() async {

    String myQuery = '''SELECT * FROM ${DatabaseDetails.ledgerDetailTable}''';

    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);
    CustomLog.successLog(
      value: "QUERY LEDGER =>  $mapData ",
    );
    return List.generate(mapData.length, (i) {
      return LedgerReportDataModel.fromJson(mapData[i]);
    });
  }

  Future<List<LedgerReportDataModel>> getDataList({
    required String fromDate,
    required String toDate,
  }) async {
    ///
    debugPrint("FROM DATE $fromDate");
    debugPrint("TO DATE $toDate");

    ///
    ///
    ///
    String myQuery = '''SELECT * FROM ${DatabaseDetails.ledgerDetailTable}
        where
          substr(${DatabaseDetails.miti}, 7) || '-' ||
          substr(${DatabaseDetails.miti}, 4, 2) || '-' ||
          substr(${DatabaseDetails.miti}, 1, 2)  >= DATE("$fromDate")
        AND
          substr(${DatabaseDetails.miti}, 7) || '-' ||
          substr(${DatabaseDetails.miti}, 4, 2) || '-' ||
          substr(${DatabaseDetails.miti}, 1, 2) <= DATE("$toDate")

       ORDER BY
           substr(${DatabaseDetails.miti}, 7) || '-' ||
            substr(${DatabaseDetails.miti}, 4, 2) || '-' ||
           substr(${DatabaseDetails.miti}, 1, 2) ASC ''';

    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);
    CustomLog.successLog(
      value: "QUERY LEDGER =>  $mapData ",
    );
    return List.generate(mapData.length, (i) {
      return LedgerReportDataModel.fromJson(mapData[i]);
    });
  }

  Future<dynamic> getOpeningBalance({
    required String glCode,
    required String fromDate,
  }) async {
    db = await DatabaseHelper.instance.database;

    String myQuery =
        '''   Select Sum (Dr-Cr) as Balance From ${DatabaseDetails.ledgerDetailTable}  Where
          substr(${DatabaseDetails.miti}, 7) || '-' ||
          substr(${DatabaseDetails.miti}, 4, 2) || '-' ||
          substr(${DatabaseDetails.miti}, 1, 2) < DATE("$fromDate")  ''';

    var result = await db!.rawQuery(myQuery);
    debugPrint("result => $result");

    String value = (result[0]["Balance"] == null)
        ? "0.00"
        : result[0]["Balance"].toString();

    return double.parse(value).toStringAsFixed(2);
  }

  Future<String> getTotalDebitAmount({required String glCode}) async {
    db = await DatabaseHelper.instance.database;
    var result = await db!.rawQuery(
        ''' SELECT SUM (Dr) FROM  ${DatabaseDetails.ledgerDetailTable} ''');
    debugPrint("result => $result");
    String value = (result[0]["SUM (Dr)"] == null)
        ? "0.00"
        : result[0]["SUM (Dr)"].toString();
    return double.parse(value).toStringAsFixed(2);
  }

  Future<String> getTotalCreditAmount({required String glCode}) async {
    db = await DatabaseHelper.instance.database;
    var result = await db!.rawQuery(
        ''' SELECT SUM (Cr) FROM  ${DatabaseDetails.ledgerDetailTable} ''');
    debugPrint("result => $result");
    String value = (result[0]["SUM (Cr)"] == null)
        ? "0.00"
        : result[0]["SUM (Cr)"].toString();
    return double.parse(value).toStringAsFixed(2);
  }
}
