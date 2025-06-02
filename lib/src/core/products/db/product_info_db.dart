import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/service/database/database.dart';
import 'package:oms_salesforce/src/utils/custom_log.dart';
import 'package:sqflite/sqflite.dart';

class ProductInfoDatabase {
  Database? db;

  ProductInfoDatabase._privateConstructor();

  static final ProductInfoDatabase instance =
      ProductInfoDatabase._privateConstructor();

  Future<int> insertData(FilterProductModel data) async {
    db = await DatabaseHelper.instance.database;
    return await db!.insert(
      DatabaseDetails.productTable,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future deleteData() async {
    db = await DatabaseHelper.instance.database;
    return await db!
        .rawQuery(''' DELETE FROM ${DatabaseDetails.productTable} ''');
  }

  Future deleteDataByGlCode({required String glCode}) async {
    db = await DatabaseHelper.instance.database;
    return await db!.rawQuery(
        ''' DELETE FROM ${DatabaseDetails.productTable} where ${DatabaseDetails.glCode} = "$glCode" ''');
  }

  Future<List<FilterProductModel>> getProductGroupData(
      {required String glCode}) async {
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(
       // ''' SELECT DISTINCT ${DatabaseDetails.grpDesc}, ${DatabaseDetails.grpCode} FROM ${DatabaseDetails.productTable} where ${DatabaseDetails.glCode} = "$glCode" ''');
        ''' SELECT DISTINCT ${DatabaseDetails.grpDesc}, ${DatabaseDetails.grpCode} FROM ${DatabaseDetails.productTable}''');

    return List.generate(mapData.length, (i) {
      return FilterProductModel.fromJson(mapData[i]);
    });
  }

  Future<List<FilterProductModel>> getProductList({
    required String groupCode,
    required String glCode,
    required String outletCode,
  }) async {
    db = await DatabaseHelper.instance.database;
    String myQuery = '''  Select p.*,
                      toi.PCode as tempPCode,
                      orderInfo.PCode as orderPCode 
        from ${DatabaseDetails.productTable} p 
        left outer join  ${DatabaseDetails.tempOrderProductTable} toi 
                  on p.${DatabaseDetails.pCode} = toi.${DatabaseDetails.pCode} AND toi.${DatabaseDetails.outletCode} = "$outletCode"
        left outer join  ${DatabaseDetails.orderProductTable} orderInfo 
                  on p.${DatabaseDetails.pCode} = orderInfo.${DatabaseDetails.pCode}  AND orderInfo.${DatabaseDetails.outletCode} = "$outletCode"
        WHERE  ${DatabaseDetails.grpCode} = "$groupCode" Group by p.${DatabaseDetails.pDesc} ''';

    //WHERE  ${DatabaseDetails.grpCode} = "$groupCode" AND ${DatabaseDetails.glCode} = "$glCode" ''';
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);

    CustomLog.successLog(value: "MY Query => $myQuery");
    CustomLog.successLog(value: "MapData => $mapData");

    return List.generate(mapData.length, (i) {
      return FilterProductModel.fromJson(mapData[i]);
    });
  } //getAllProductAvalability

  /// FOR PRODUCT AVAilability
  Future<List<FilterProductModel>> getAllProductAvalability({
    required String grCode,
  }) async {
    String myQuery =
    '''  SELECT DISTINCT ${DatabaseDetails.pDesc} FROM ${DatabaseDetails.productTable} WHERE ${DatabaseDetails.grpCode} = "$grCode" ''';
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);

    return List.generate(mapData.length, (i) {
      return FilterProductModel.fromJson(mapData[i]);
    });
  }


  ///
  /// FOR PRODUCT AVAilability
  Future<List<FilterProductModel>> getAllProduct({
    required String glCode,
  }) async {
    String myQuery =
        '''  SELECT * FROM ${DatabaseDetails.productTable} WHERE ${DatabaseDetails.glCode} = "$glCode" ''';
    db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);

    return List.generate(mapData.length, (i) {
      return FilterProductModel.fromJson(mapData[i]);
    });
  }
}
