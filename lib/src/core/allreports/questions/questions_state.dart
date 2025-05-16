import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../service/sharepref/sharepref.dart';
import '../../../utils/utils.dart';
import '../../login/login.dart';
import '../../products/products.dart';
import 'model/question_report_model.dart';
import 'questions.dart';

class QuestionState extends ChangeNotifier {
  QuestionState();

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

  init() async {
    await clean();
    await getOutletInfoState();
    //

    await Future.wait([
      getQuestionListFromRemote(),
      getQuestionReportFromRemote(),
    ]);
  }

  late ProductState productState;
  getOutletInfoState() {
    productState = Provider.of<ProductState>(context, listen: false);
  }

  late bool _isFromIndex = false;
  bool get isFromIndex => _isFromIndex;
  set isFromIndex(bool value) {
    _isFromIndex = value;
    notifyListeners();
  }

  CompanyDetailsModel _companyDetails = CompanyDetailsModel.fromJson({});
  CompanyDetailsModel get companyDetails => _companyDetails;
  clean() async {
    _isLoading = false;
    _questionList = [];
    _questionReportList = [];

    _companyDetails = await GetAllPref.companyDetail();
  }

  late List<QuestionDataModel> _questionList = [];
  List<QuestionDataModel> get questionList => _questionList;
  set questionList(List<QuestionDataModel> value) {
    _questionList = value;
    notifyListeners();
  }

  Future getQuestionListFromRemote() async {
    questionList.clear();
    isLoading = true;
    QuestionModel model = await QuestionAPI.getQuestion(
      databaseName: _companyDetails.databaseName,
    );

    if (model.statusCode == 200) {
      questionList = model.data;
    } else {
      questionList = [];
    }
    isLoading = false;
    notifyListeners();
  }

  Future answerQuestion({
    required String questionCode,
    required String answer,
  }) async {
    isLoading = true;
    QuestionModel model = await QuestionAPI.postAnswerToQuestion(
      databaseName: _companyDetails.databaseName,
      questionCode: questionCode,
      answer: answer,
      glCode: productState.outletDetail.glCode,
      agentCode: _companyDetails.agentCode,
      userCode: _companyDetails.userCode,
      lat: await MyLocation().lat(),
      lng: await MyLocation().long(),
    );
    if (model.statusCode == 200) {
      await getQuestionListFromRemote();
      await getQuestionReportFromRemote();
    } else {}
    isLoading = false;
    notifyListeners();
  }

  ///
  ///
  late List<QuestionReportDataModel> _questionReportList = [];
  List<QuestionReportDataModel> get questionReportList => _questionReportList;
  set questionReportList(List<QuestionReportDataModel> value) {
    _questionReportList = value;
    notifyListeners();
  }

  Future getQuestionReportFromRemote() async {
    questionReportList.clear();
    isLoading = true;
    QuestionReportModel model = await QuestionAPI.getQuestionReports(
      databaseName: _companyDetails.databaseName,
      glCode: _isFromIndex ? "" : productState.outletDetail.glCode,
    );
    if (model.statusCode == 200) {
      questionReportList = model.data;
      updateListToggleValue();
    } else {
      questionReportList = [];
    }
    isLoading = false;
    notifyListeners();
  }

  /// **************************
  Map<int, String> answerController = {};

  ///
  ///
  late List<bool> _isShowItemBuilder = [];
  List<bool> get isShowItemBuilder => _isShowItemBuilder;

  updateListToggleValue() {
    _isShowItemBuilder = List.generate(
      questionReportList.length,
      (index) => false,
    );
    notifyListeners();
  }

  ///
}
