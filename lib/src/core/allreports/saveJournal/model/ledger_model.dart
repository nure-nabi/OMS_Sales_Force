class JournalLedgerModel {
  JournalLedgerModel({
    required this.statusCode,
    required this.status,
    required this.data,
  });

  final int statusCode;
  final bool status;
  final List<JournalLedgerDataModel> data;

  factory JournalLedgerModel.fromJson(Map<String, dynamic> json) {
    return JournalLedgerModel(
      statusCode: json["status_code"] ?? 0,
      status: json["status"] ?? false,
      data: json["data"] == null
          ? []
          : List<JournalLedgerDataModel>.from(
              json["data"]!.map((x) => JournalLedgerDataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class JournalLedgerDataModel {
  JournalLedgerDataModel({
    required this.glCode,
    required this.glDesc,
    required this.glShortName,
    required this.panNo,
    required this.catagory,
    required this.balance,
    required this.creditLimite,
    required this.creditDay,
    required this.scheme,
    required this.grpCode,
    required this.grpDesc,
    required this.sGrpCode,
    required this.sGrpDesc,
    required this.agentCode,
    required this.agentDesc,
    required this.areaCode,
    required this.areaDesc,
    required this.primaryGroup,
    required this.address,
    required this.telNo,
    required this.mobile,
    required this.email,
    required this.contactPerson,
    required this.id,
    required this.subledger,
    required this.addGrp1Desc,
    required this.addGrp2Desc,
    required this.blockBackDatedEntry,
  });

  final String glCode;
  final String glDesc;
  final String glShortName;
  final String panNo;
  final String catagory;
  final String balance;
  final String creditLimite;
  final String creditDay;
  final String scheme;
  final String grpCode;
  final String grpDesc;
  final String sGrpCode;
  final String sGrpDesc;
  final String agentCode;
  final String agentDesc;
  final String areaCode;
  final String areaDesc;
  final String primaryGroup;
  final String address;
  final String telNo;
  final String mobile;
  final String email;
  final String contactPerson;
  final String id;
  final String subledger;
  final String addGrp1Desc;
  final String addGrp2Desc;
  final String blockBackDatedEntry;

  factory JournalLedgerDataModel.fromJson(Map<String, dynamic> json) {
    return JournalLedgerDataModel(
      glCode: json["GlCode"] ?? "",
      glDesc: json["GlDesc"] ?? "",
      glShortName: json["GlShortName"] ?? "",
      panNo: json["PanNo"] ?? "",
      catagory: json["Catagory"] ?? "",
      balance: json["Balance"] ?? "",
      creditLimite: json["CreditLimite"] ?? "",
      creditDay: json["CreditDay"] ?? "",
      scheme: json["Scheme"] ?? "",
      grpCode: json["GrpCode"] ?? "",
      grpDesc: json["GrpDesc"] ?? "",
      sGrpCode: json["SGrpCode"] ?? "",
      sGrpDesc: json["SGrpDesc"] ?? "",
      agentCode: json["AgentCode"] ?? "",
      agentDesc: json["AgentDesc"] ?? "",
      areaCode: json["AreaCode"] ?? "",
      areaDesc: json["AreaDesc"] ?? "",
      primaryGroup: json["PrimaryGroup"] ?? "",
      address: json["Address"] ?? "",
      telNo: json["TelNo"] ?? "",
      mobile: json["Mobile"] ?? "",
      email: json["Email"] ?? "",
      contactPerson: json["ContactPerson"] ?? "",
      id: json["Id"] ?? "",
      subledger: json["Subledger"] ?? "",
      addGrp1Desc: json["AddGrp1Desc"] ?? "",
      addGrp2Desc: json["AddGrp2Desc"] ?? "",
      blockBackDatedEntry: json["BlockBackDatedEntry"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "GlCode": glCode,
        "GlDesc": glDesc,
        "GlShortName": glShortName,
        "PanNo": panNo,
        "Catagory": catagory,
        "Balance": balance,
        "CreditLimite": creditLimite,
        "CreditDay": creditDay,
        "Scheme": scheme,
        "GrpCode": grpCode,
        "GrpDesc": grpDesc,
        "SGrpCode": sGrpCode,
        "SGrpDesc": sGrpDesc,
        "AgentCode": agentCode,
        "AgentDesc": agentDesc,
        "AreaCode": areaCode,
        "AreaDesc": areaDesc,
        "PrimaryGroup": primaryGroup,
        "Address": address,
        "TelNo": telNo,
        "Mobile": mobile,
        "Email": email,
        "ContactPerson": contactPerson,
        "Id": id,
        "Subledger": subledger,
        "AddGrp1Desc": addGrp1Desc,
        "AddGrp2Desc": addGrp2Desc,
        "BlockBackDatedEntry": blockBackDatedEntry,
      };
}

/*
{
	"status_code": 200,
	"status": true,
	"data": [
		{
			"GlCode": "10",
			"GlDesc": "Auto International",
			"GlShortName": "10",
			"PanNo": "25896314",
			"Catagory": "Customer/Vendor",
			"Balance": "10824730.00000000",
			"CreditLimite": "0.00000000",
			"CreditDay": "0",
			"Scheme": "",
			"GrpCode": "",
			"GrpDesc": "SUNDRY DEBTORS",
			"SGrpCode": "",
			"SGrpDesc": "",
			"AgentCode": "",
			"AgentDesc": "",
			"AreaCode": "",
			"AreaDesc": "",
			"PrimaryGroup": "Assets",
			"Address": "",
			"TelNo": "",
			"Mobile": "9851069643",
			"Email": "",
			"ContactPerson": "",
			"Id": "",
			"Subledger": "0",
			"AddGrp1Desc": "",
			"AddGrp2Desc": "",
			"BlockBackDatedEntry": ""
		}
	]
}*/