import 'package:sqflite/sqflite.dart';

import 'database_const.dart';

class CreateTable {
  Database db;
  CreateTable(this.db);

  /// Company List Info
  companyListTable() async {
    await db.execute(
        ''' CREATE TABLE if not exists ${DatabaseDetails.clientListTable} (
                                                ${DatabaseDetails.userCode} TEXT,
                                                ${DatabaseDetails.loginName} TEXT,
                                                ${DatabaseDetails.password} TEXT,
                                                ${DatabaseDetails.userName} TEXT,
                                                ${DatabaseDetails.createdDateTime} TEXT,
                                                ${DatabaseDetails.isEnable} TEXT,
                                                ${DatabaseDetails.companyDBName} TEXT,
                                                ${DatabaseDetails.companyName} TEXT,
                                                ${DatabaseDetails.companyPanNo} TEXT,
                                                ${DatabaseDetails.deviceId} TEXT,
                                                ${DatabaseDetails.agentCode} TEXT,
                                                ${DatabaseDetails.userType} TEXT,
                                                ${DatabaseDetails.createdBy} TEXT,
                                                ${DatabaseDetails.createdDate} TEXT
                                                ) ''');
  }

  /// OutLet Info
  outletTable() async {
    await db.execute(
        ''' CREATE TABLE if not exists ${DatabaseDetails.outletTable} (  
                                                ${DatabaseDetails.mAreaCode} TEXT,      
                                                ${DatabaseDetails.mAreaDesc} TEXT,      
                                                ${DatabaseDetails.routeCode} TEXT,      
                                                ${DatabaseDetails.routeDesc} TEXT,      
                                                ${DatabaseDetails.glCode} TEXT,      
                                                ${DatabaseDetails.glDesc} TEXT,      
                                                ${DatabaseDetails.outletCode} TEXT,
                                                ${DatabaseDetails.outletDesc} TEXT,
                                                ${DatabaseDetails.mobileNo} TEXT,
                                                ${DatabaseDetails.phoneNo} TEXT,
                                                ${DatabaseDetails.outletPerson} TEXT,
                                                ${DatabaseDetails.panNo} TEXT,
                                                ${DatabaseDetails.address} TEXT,
                                                ${DatabaseDetails.email} TEXT,
                                                ${DatabaseDetails.priceTag} TEXT,
                                                ${DatabaseDetails.latitude} TEXT,
                                                ${DatabaseDetails.longitude} TEXT,
                                                ${DatabaseDetails.balance} TEXT,
                                                ${DatabaseDetails.productPointBalance} TEXT,
                                                ${DatabaseDetails.routeStatus} TEXT,
                                                ${DatabaseDetails.outletStatus} TEXT,
                                                 ${DatabaseDetails.tempPCode} TEXT,
                                                ${DatabaseDetails.orderPCode} TEXT
                                                ) ''');
  }

  /// Product Info
  productTable() async {
    await db.execute(
        ''' CREATE TABLE if not exists ${DatabaseDetails.productTable} (  
                                                ${DatabaseDetails.glCode} TEXT,      
                                                ${DatabaseDetails.glDesc} TEXT,      
                                                ${DatabaseDetails.grpCode} TEXT,      
                                                ${DatabaseDetails.grpDesc} TEXT,      
                                                ${DatabaseDetails.pCode} TEXT,      
                                                ${DatabaseDetails.pDesc} TEXT,      
                                                ${DatabaseDetails.pShortName} TEXT,      
                                                ${DatabaseDetails.alias} TEXT,
                                                ${DatabaseDetails.mrp} TEXT,
                                                ${DatabaseDetails.tradeRate} TEXT,
                                                ${DatabaseDetails.buyRate} TEXT,
                                                ${DatabaseDetails.salesRate} TEXT,
                                                ${DatabaseDetails.vat} TEXT,
                                                ${DatabaseDetails.dealerPrice} TEXT,
                                                ${DatabaseDetails.exciseRate} TEXT,
                                                ${DatabaseDetails.maxStock} TEXT,
                                                ${DatabaseDetails.discountRate} TEXT,
                                                ${DatabaseDetails.stockBalance} TEXT,
                                                ${DatabaseDetails.unitCode} TEXT,
                                                ${DatabaseDetails.tempPCode} TEXT,
                                                ${DatabaseDetails.orderPCode} TEXT,
                                                ${DatabaseDetails.altQty} TEXT,
                                                ${DatabaseDetails.qty} TEXT,
                                                ${DatabaseDetails.unit} TEXT,
                                                ${DatabaseDetails.altUnit} TEXT,
                                                ${DatabaseDetails.scheme} TEXT
                                                ) ''');

  }

  /// Order Product Info
  tempOrderProductTable() async {
    await db.execute(
        ''' CREATE TABLE if not exists ${DatabaseDetails.tempOrderProductTable} (  
                                                ${DatabaseDetails.routeCode} TEXT,     
                                                ${DatabaseDetails.outletCode} TEXT,      
                                                ${DatabaseDetails.pCode} TEXT,  
                                                ${DatabaseDetails.quantity} TEXT,    
                                                ${DatabaseDetails.rate} TEXT,    
                                                ${DatabaseDetails.alias} TEXT,
                                                ${DatabaseDetails.totalAmount} TEXT) ''');
  }

  /// Order Product Info
  orderProductTable() async {
    await db.execute(
        ''' CREATE TABLE if not exists ${DatabaseDetails.orderProductTable} (  
                                                ${DatabaseDetails.routeCode} TEXT,      
                                                ${DatabaseDetails.outletCode} TEXT,      
                                                ${DatabaseDetails.pCode} TEXT,  
                                                ${DatabaseDetails.quantity} TEXT,    
                                                ${DatabaseDetails.rate} TEXT,    
                                                ${DatabaseDetails.alias} TEXT,
                                                ${DatabaseDetails.comment} TEXT,
                                                ${DatabaseDetails.orderBy} TEXT,
                                                ${DatabaseDetails.totalAmount} TEXT) ''');
  }

  /// sales Return INFO
  salesReturnTable() async {
    await db.execute(
        ''' CREATE TABLE if not exists ${DatabaseDetails.salesReturnTable} (  
                                                ${DatabaseDetails.routeCode} TEXT,      
                                                ${DatabaseDetails.outletCode} TEXT,      
                                                ${DatabaseDetails.pCode} TEXT,  
                                                ${DatabaseDetails.quantity} TEXT,    
                                                ${DatabaseDetails.rate} TEXT,    
                                                ${DatabaseDetails.alias} TEXT,
                                                ${DatabaseDetails.comment} TEXT,
                                                ${DatabaseDetails.orderBy} TEXT,
                                                ${DatabaseDetails.totalAmount} TEXT) ''');
  }

  /// Pending Verify Info
  pendingVerifyTable() async {
    await db.execute(
        ''' CREATE TABLE if not exists ${DatabaseDetails.pendingVerifyTable} (  
                                                ${DatabaseDetails.itemName} TEXT,  
                                                ${DatabaseDetails.qty} TEXT,    
                                                ${DatabaseDetails.rate} TEXT,    
                                                ${DatabaseDetails.netAmt} TEXT,
                                                ${DatabaseDetails.brandCode} TEXT,
                                                ${DatabaseDetails.glCode} TEXT,
                                                ${DatabaseDetails.glDesc} TEXT) ''');
  }

  ///

  deliveryReportTable() async {
    await db.execute(
        ''' CREATE TABLE if not exists ${DatabaseDetails.deliveryTableInfo} (  
                                                ${DatabaseDetails.vNo} TEXT,  
                                                ${DatabaseDetails.vDate} TEXT,  
                                                ${DatabaseDetails.vTime} TEXT,  
                                                ${DatabaseDetails.vMiti} TEXT,  
                                                ${DatabaseDetails.glCode} TEXT,    
                                                ${DatabaseDetails.glDesc} TEXT,    
                                                ${DatabaseDetails.glShortName} TEXT,    
                                                ${DatabaseDetails.netAmount} TEXT,
                                                ${DatabaseDetails.agentDesc} TEXT,
                                                ${DatabaseDetails.pONo} TEXT,
                                                ${DatabaseDetails.subledgerDesc} TEXT) ''');
  }

  localMovementTable() async {
    await db.execute(
        ''' CREATE TABLE if not exists ${DatabaseDetails.localMovementTableInfo} (  
                                                ${DatabaseDetails.lat} TEXT,  
                                                ${DatabaseDetails.long} TEXT,  
                                                ${DatabaseDetails.timestamp} TEXT,  
                                                ${DatabaseDetails.activity} TEXT) ''');
  }

  ledgerReportTable() async {
    await db.execute(
        ''' CREATE TABLE if not exists ${DatabaseDetails.ledgerDetailTable} (
                                                ${DatabaseDetails.vno} TEXT,
                                                ${DatabaseDetails.date} TEXT,
                                                ${DatabaseDetails.miti} TEXT,
                                                ${DatabaseDetails.source} TEXT,
                                                ${DatabaseDetails.dr} TEXT,
                                                ${DatabaseDetails.cr} TEXT,
                                                ${DatabaseDetails.remark} TEXT,
                                                ${DatabaseDetails.glCode} TEXT,
                                                ${DatabaseDetails.narration} TEXT,
                                                ${DatabaseDetails.total} TEXT) ''');
  }

    saveProductAvailabilityTable() async {
    await db.execute(
        ''' CREATE TABLE if not exists ${DatabaseDetails.saveProductAvailability} (
                                                ${DatabaseDetails.sRouteCode} TEXT,
                                                ${DatabaseDetails.sOutletCode} TEXT,
                                                ${DatabaseDetails.productName} TEXT,
                                                ${DatabaseDetails.itemCode} TEXT,
                                                ${DatabaseDetails.qty} TEXT,
                                                ${DatabaseDetails.price} TEXT,
                                                ${DatabaseDetails.lng} TEXT,
                                                ${DatabaseDetails.slat} TEXT,
                                                ${DatabaseDetails.timeStamp} TEXT) ''');
  }

  saveOrderReport() async {
    await db.execute(
        ''' CREATE TABLE if not exists ${DatabaseDetails.saveOrderReportTable} (
                                                ${DatabaseDetails.glcode} TEXT,
                                                ${DatabaseDetails.vNo} TEXT,
                                                ${DatabaseDetails.salesman} TEXT,
                                                ${DatabaseDetails.glDesc} TEXT,
                                                ${DatabaseDetails.route} TEXT,
                                                ${DatabaseDetails.telNoI} TEXT,
                                                ${DatabaseDetails.mobile} TEXT,
                                                ${DatabaseDetails.creditLimite} TEXT,
                                                ${DatabaseDetails.creditDay} TEXT,
                                                ${DatabaseDetails.overdays} TEXT,
                                                ${DatabaseDetails.overLimit} TEXT,
                                                ${DatabaseDetails.currentBalance} TEXT,
                                                ${DatabaseDetails.ageOfOrder} TEXT,
                                                ${DatabaseDetails.qty} TEXT,
                                                ${DatabaseDetails.vDate} TEXT,
                                                ${DatabaseDetails.vTime} TEXT,
                                                ${DatabaseDetails.netAmt} TEXT,
                                                ${DatabaseDetails.remarks} TEXT,
                                                ${DatabaseDetails.orderBy} TEXT,
                                                ${DatabaseDetails.lat} TEXT,
                                                ${DatabaseDetails.lng} TEXT,
                                                ${DatabaseDetails.managerRemarks} TEXT,
                                                ${DatabaseDetails.reconcileDate} TEXT,
                                                ${DatabaseDetails.reconcileBy} TEXT,
                                                ${DatabaseDetails.entryModule} TEXT,
                                                ${DatabaseDetails.invType} TEXT,
                                                ${DatabaseDetails.invDate} TEXT) ''');
  }

  productAvailability() async {
    await db.execute(
        ''' CREATE TABLE if not exists ${DatabaseDetails.productAvailabilityTable} (
                                                ${DatabaseDetails.agentCode} TEXT,
                                                ${DatabaseDetails.agentShortName} TEXT,
                                                ${DatabaseDetails.agentDesc} TEXT,
                                                ${DatabaseDetails.mobile} TEXT,
                                                ${DatabaseDetails.areaCode} TEXT,
                                                ${DatabaseDetails.areaShortName} TEXT,
                                                ${DatabaseDetails.areaDesc} TEXT,
                                                ${DatabaseDetails.glCode} TEXT,
                                                ${DatabaseDetails.glShortName} TEXT,
                                                ${DatabaseDetails.glDesc} TEXT,
                                                ${DatabaseDetails.pCode} TEXT,
                                                ${DatabaseDetails.pShortName} TEXT,
                                                ${DatabaseDetails.pDesc} TEXT,
                                                ${DatabaseDetails.qty} TEXT,
                                                ${DatabaseDetails.price} TEXT,
                                                ${DatabaseDetails.pADate} TEXT) ''');
  }

}
