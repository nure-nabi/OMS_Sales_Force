import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/allreports/save_product_availability/db/save_product_availability_db.dart';
import 'package:oms_salesforce/src/core/allreports/save_product_availability/model/save_product_availability_model.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../../model/model.dart';
import '../../../../theme/colors.dart';
import '../../../service/sharepref/sharepref.dart';
import '../../login/company_model.dart';
import '../../pdf/pdf.dart';
import '../../products/products.dart';
import 'api/save_product_availability_api.dart';

class SaveProductAvailabilityState extends ChangeNotifier {
  SaveProductAvailabilityState();

  late BuildContext _context;

  BuildContext get context => _context;
  late final NavigatorState navigator = Navigator.of(_context);

  set context(BuildContext value) {
    _context = value;

    ///
    init();
  }

  late bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  late ProductState productState;

  stateInit() {
    productState = context.read<ProductState>();
    notifyListeners();
  }

  init() async {
    await clean();
    await stateInit();
    await getAllProductListFromDB();
    await getAddProductList();
  }

  clean() async {
    _isLoading = false;
    _controller.clear();
    _productList.clear();
    _saveProductList.clear();

    ///
    _companyDetail = await GetAllPref.companyDetail();
  }

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});

  CompanyDetailsModel get companyDetail => _companyDetail;

  set getCompanyDetail(CompanyDetailsModel value) {
    _companyDetail = value;
    notifyListeners();
  }

  late List<TextEditingController> _controller = [];

  List<TextEditingController> get controller => _controller;
  set controller(List<TextEditingController> value) {
    _controller = value;
    notifyListeners();
  }

  late List<FilterProductModel> _productList = [];

  List<FilterProductModel> get productList => _productList;

  set productList(List<FilterProductModel> value) {
    _productList = value;
    notifyListeners();
  }

  ///
  ///

  getAllProductListFromDB() async {
    productList.clear();
    await ProductInfoDatabase.instance
        .getAllProduct(glCode: productState.outletDetail.glCode)
        .then((value) {
      productList = value;
    });

    controller = List<TextEditingController>.generate(_productList.length, (i) {
      return TextEditingController(text: "");
    });

    // final list = await SaveProductAvailabilityDatabase.instance
    //     .getAllProductByRouteOutletCode(
    //   routeCode: productState.outletDetail.routeCode,
    //   outletCode: productState.outletDetail.outletCode,
    // );

    // controller = List<TextEditingController>.generate(_productList.length, (i) {
    //   var ctrl = TextEditingController(text: "");
    //   for (var element in list) {
    //     if (element.itemCode == _productList[i].pCode) {
    //       ctrl = TextEditingController(text: element.qty);
    //     } else {
    //       ctrl = TextEditingController(text: "");
    //     }
    //   }
    //   return ctrl;
    // });

    CustomLog.errorLog(value: "productList => $productList");
    notifyListeners();
  }

  ///
  ///
  Future<void> addProduct() async {
    isLoading = true;
    List<SaveProductAvailabilityModel> productDetails = [];

    await _populateProductDetails(productDetails);

    if (productDetails.isNotEmpty) {
      await _saveProductDetails(productDetails);

      ShowToast.showToast(
        msg: "Product added successfully",
        backgroundColor: successColor,
      );
    }

    await getAddProductList();
    isLoading = false;
    notifyListeners();
  }

  Future<void> _populateProductDetails(
      List<SaveProductAvailabilityModel> productDetails) async {
    for (var i = 0; i < productList.length; i++) {
      final product = productList[i];
      final qty = controller[i].text.isEmpty ? "0" : controller[i].text;

      if (qty == "0") continue;

      final lat = await MyLocation().lat();
      final lng = await MyLocation().long();
      final timestamp = await MyTimeConverter.getTimeStamp();

      final productDetail = SaveProductAvailabilityModel(
        routeCode: productState.outletDetail.routeCode,
        outletCode: productState.outletDetail.outletCode,
        productName: product.alias,
        itemCode: product.pCode,
        qty: qty,
        price: product.mrp,
        lat: lat,
        lng: lng,
        timestamp: timestamp,
      );

      productDetails.add(productDetail);
    }
  }

  Future<bool> checkAlreadyExist(itemCode) async {
    bool isAvailable =
        await SaveProductAvailabilityDatabase.instance.isProductExist(
      pCode: itemCode,
      routeCode: productState.outletDetail.routeCode,
      outletCode: productState.outletDetail.outletCode,
    );

    return isAvailable;
  }

  Future<String> getQtyByPCode(itemCode) async {
    return await SaveProductAvailabilityDatabase.instance.getQtyByProductId(
      pCode: itemCode,
      routeCode: productState.outletDetail.routeCode,
      outletCode: productState.outletDetail.outletCode,
    );
  }
  // Future<List<TextEditingController>> getQtyByPCode(String itemCode) async {
  //   final list = await SaveProductAvailabilityDatabase.instance
  //       .getAllProductByRouteOutletCode(
  //     routeCode: productState.outletDetail.routeCode,
  //     outletCode: productState.outletDetail.outletCode,
  //   );

  //   controller = List<TextEditingController>.generate(_productList.length, (i) {
  //     var ctrl = TextEditingController(text: "");
  //     for (var element in list) {
  //       if (element.itemCode == _productList[i].pCode) {
  //         ctrl = TextEditingController(text: element.qty);
  //       } else {
  //         ctrl = TextEditingController(text: "");
  //       }
  //     }
  //     return ctrl;
  //   });
  //   // If no matching product code found in the product list
  //   return controller;
  // }

  Future<void> _saveProductDetails(
    List<SaveProductAvailabilityModel> productDetails,
  ) async {
    await Future.wait(
      productDetails.map(
        (element) async {
          bool isAvailable = await checkAlreadyExist(element.itemCode);
          if (!isAvailable) {
            await SaveProductAvailabilityDatabase.instance.insertData(element);
          }
        },
      ),
    );
  }

  ///
  ///
  ///
  late List<SaveProductAvailabilityModel> _saveProductList = [];

  List<SaveProductAvailabilityModel> get saveProductList => _saveProductList;

  set saveProductList(List<SaveProductAvailabilityModel> value) {
    _saveProductList = value;
    notifyListeners();
  }

  getAddProductList() async {
    await SaveProductAvailabilityDatabase.instance
        .getAllProductByRouteOutletCode(
            routeCode: productState.outletDetail.routeCode,
            outletCode: productState.outletDetail.outletCode)
        .then((value) {
      saveProductList = value;
    });

    await getAllProductListFromDB();

    notifyListeners();
  }

  ///
  ///
  Future<void> onUpdateButtonSave({bool isPrint = false}) async {
    isLoading = true;
    final list = await SaveProductAvailabilityDatabase.instance
        .getAllProductByRouteOutletCode(
      routeCode: productState.outletDetail.routeCode,
      outletCode: productState.outletDetail.outletCode,
    );
    BasicModel model = await SaveProductAvailabilityAPI.apiCall(
      salesmanId: _companyDetail.agentCode,
      databaseName: _companyDetail.databaseName,
      routeCode: productState.outletDetail.routeCode,
      outletCode: productState.outletDetail.outletCode,
      productDetails: list,
    );

    if (model.statusCode == 200) {
      navigator.pop();
      navigator.pop();
      if (isPrint) shareInPFD();
      await SaveProductAvailabilityDatabase.instance
          .deleteDataByRouteAndOutletCode(
        routeCode: productState.outletDetail.routeCode,
        outletCode: productState.outletDetail.outletCode,
      );
      ShowToast.successToast(msg: model.message);
    } else {
      ShowToast.errorToast(msg: model.message);
    }
    isLoading = false;

    notifyListeners();
  }

  shareInPFD() async {
    final list = await SaveProductAvailabilityDatabase.instance
        .getAllProductByRouteOutletCode(
      routeCode: productState.outletDetail.routeCode,
      outletCode: productState.outletDetail.outletCode,
    );
    final pdfFile = await ProductAvailabilityPDFApi.generate(
      dataList: list,
      companyDetails: _companyDetail,
    );

    ////  opening the pdf file
    FileHandleApi.openFile(pdfFile);

    notifyListeners();
  }
}
