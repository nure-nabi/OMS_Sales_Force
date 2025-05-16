class LedgerNoteModel {
  LedgerNoteModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  final String message;
  final int statusCode;
  final List<LedgerNoteDataModel> data;

  factory LedgerNoteModel.fromJson(Map<String, dynamic> json) {
    return LedgerNoteModel(
      message: json["MESSAGE"] ?? "",
      statusCode: json["STATUS_CODE"] ?? 0,
      data: json["data"] == null
          ? []
          : List<LedgerNoteDataModel>.from(
              json["data"]!.map((x) => LedgerNoteDataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "MESSAGE": message,
        "STATUS_CODE": statusCode,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class LedgerNoteDataModel {
  LedgerNoteDataModel({
    required this.glcode,
    required this.glshortname,
    required this.gldesc,
    required this.catagory,
    required this.addressI,
    required this.telNoI,
    required this.mobile,
    required this.email,
    required this.noteDate,
    required this.noteDEtails,
  });

  final String glcode;
  final String glshortname;
  final String gldesc;
  final String catagory;
  final String addressI;
  final String telNoI;
  final String mobile;
  final String email;
  final String noteDate;
  final String noteDEtails;

  factory LedgerNoteDataModel.fromJson(Map<String, dynamic> json) {
    return LedgerNoteDataModel(
      glcode: json["Glcode"] ?? "",
      glshortname: json["Glshortname"] ?? "",
      gldesc: json["Gldesc"] ?? "",
      catagory: json["Catagory"] ?? "",
      addressI: json["AddressI"] ?? "",
      telNoI: json["TelNoI"] ?? "",
      mobile: json["Mobile"] ?? "",
      email: json["Email"] ?? "",
      noteDate: json["NoteDate"] ?? "",
      noteDEtails: json["NoteDEtails"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "Glcode": glcode,
        "Glshortname": glshortname,
        "Gldesc": gldesc,
        "Catagory": catagory,
        "AddressI": addressI,
        "TelNoI": telNoI,
        "Mobile": mobile,
        "Email": email,
        "NoteDate": noteDate,
        "NoteDEtails": noteDEtails,
      };
}

/*
{
	"MESSAGE": "Succesfully",
	"STATUS_CODE": 200,
	"data": [
		{
			"Glcode": "17",
			"Glshortname": "17",
			"Gldesc": "Banepa Trading",
			"Catagory": "Customer",
			"AddressI": "teku ",
			"TelNoI": "",
			"Mobile": "9851069643",
			"Email": "",
			"NoteDate": "202301",
			"NoteDEtails": "ok"
		}
	]
}*/