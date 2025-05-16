import 'package:oms_salesforce/src/core/pendingverify/model/pending_verify_model.dart';
import 'package:oms_salesforce/src/service/api/api.dart';
import 'package:oms_salesforce/src/utils/utils.dart';

import '../model/product_avalability_report_model.dart';

class ProductAvailabilityAPI {
  static getData({
    required String dbName,
    required String gLdesc,
    required String pDesc,
  }) async {
    //
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "MasterList/ListProductAvailability?DbName=$dbName&Gldesc=$gLdesc&Pdesc=$pDesc",
      // http://myomsapi.globaltechsolution.com.np:802/api/MasterList/ListProductAvailability?DbName=Erpdemo101
    );

    //Gldesc
    // Pdesc
    CustomLog.log(value: "JSON DATA : $jsonData");

    return ProductAvailabilityResponse.fromJson(jsonData);
  }
}
