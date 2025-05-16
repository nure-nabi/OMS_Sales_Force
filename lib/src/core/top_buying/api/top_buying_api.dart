import 'package:oms_salesforce/src/service/api/apiprovider.dart';

import '../model/top_buying_model.dart';

class TopBuyingAPI {
  static Future getQuestion({
    required String databaseName,
    required String glCode,
  }) async {
    var jsonData = await APIProvider.getAPI(
      endPoint: "MasterList/TopbuyingItem?DbName=$databaseName&Glcode=$glCode",
    );

    return TopBuyingModel.fromJson(jsonData);
  }
}
