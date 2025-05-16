import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/service/api/api.dart';

class ProductAPI {
  static getProduct({required String dbName, required String agentCode,required String brCode,required String customer}) async {
    var jsonData = await APIProvider.getAPI(
      endPoint:
          "Area/ListBrandAssignToSalesmanSchemeRate?DbName=$dbName&AgentCode=$agentCode&BrCode=$brCode&Customer=$customer",
    );
    ////http://ritaapi.omsird.com:802/api/Area/ListBrandAssignToSalesmanSchemeRate?DbName=RITA008101&AgentCode=19&BrCode=KATHMANDU&Customer=Global tech test party
   // print("Area/ListBrandAssignToSalesman?DbName=$dbName&AgentCode=$agentCode&BrCode=$brCode");
    print("Area/ListBrandAssignToSalesmanSchemeRate?DbName=$dbName&AgentCode=$agentCode&BrCode=$brCode&Customer=$customer");
    return ProductModel.fromJson(jsonData);
  }
}
