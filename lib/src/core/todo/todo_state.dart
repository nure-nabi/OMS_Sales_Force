import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:oms_salesforce/src/utils/show_toast.dart';

import '../../service/sharepref/sharepref.dart';
import '../login/company_model.dart';
import 'model/assign_user_model.dart';
import 'model/create_activity_model.dart';
import 'model/ledger_model.dart';
import 'todo.dart';

class TodoState extends ChangeNotifier {
  TodoState();

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

    await getDataFromRemote();
  }

  late CompanyDetailsModel _companyDetail = CompanyDetailsModel.fromJson({});
  CompanyDetailsModel get companyDetail => _companyDetail;
  set getCompanyDetail(CompanyDetailsModel value) {
    _companyDetail = value;
    notifyListeners();
  }

  clean() async {
    _isLoading = false;
    _dataList = [];

    getCompanyDetail = await GetAllPref.companyDetail();
  }

  late List<TodoDataModel> _dataList = [];
  List<TodoDataModel> get dataList => _dataList;
  set dataList(List<TodoDataModel> value) {
    _dataList = value;
    notifyListeners();
  }

  getDataFromRemote() async {
    isLoading = true;
    TodoModel model = await ToDoAPI.todoData(
      databaseName: _companyDetail.databaseName,
      glCode: "",
      // agentCode: _companyDetail.agentCode,
      agentCode: "",
    );

    if (model.statusCode == 200) {
      dataList = model.data;
      await updateListToggleValue();
    } else {
      dataList = [];
    }
    isLoading = false;
    notifyListeners();
  }

  late List<bool> _isShowItemBuilder = [];
  List<bool> get isShowItemBuilder => _isShowItemBuilder;

  updateListToggleValue() {
    _isShowItemBuilder = List.generate(
      dataList.length,
      (index) => false,
    );
    notifyListeners();
  }

  late TodoDataModel _selectedToDo = TodoDataModel.fromJson({});
  TodoDataModel get selectedToDo => _selectedToDo;
  set selectedToDo(TodoDataModel value) {
    _selectedToDo = value;
    notifyListeners();
  }

  late List<TodoActivityDataModel> _activityDataList = [];
  List<TodoActivityDataModel> get activityDataList => _activityDataList;
  set activityDataList(List<TodoActivityDataModel> value) {
    _activityDataList = value;
    notifyListeners();
  }

  getToDoDetailsDataFromRemote() async {
    isLoading = true;
    TodoActivityModel model = await ToDoAPI.todoActivityData(
      databaseName: _companyDetail.databaseName,
      glCode: "",
      // agentCode: _companyDetail.agentCode,
      agentCode: "",
    );

    if (model.statusCode == 200) {
      activityDataList = model.data;
      await updateActivityListToggleValue();
      navigator.push(
        MaterialPageRoute(builder: (_) => const ToDoActivityScreen()),
      );
    } else {
      activityDataList = [];
    }
    isLoading = false;
    notifyListeners();
  }

  late List<bool> _isShowActivityItemBuilder = [];
  List<bool> get isShowActivityItemBuilder => _isShowActivityItemBuilder;

  updateActivityListToggleValue() {
    _isShowActivityItemBuilder = List.generate(
      activityDataList.length,
      (index) => false,
    );
    notifyListeners();
  }

  /// ************************************************* ///
  /// ********* CREATE TO-DO TASK ********************* ///
  /// ************************************************* ///

  late bool _isTodoCreateLoading = false;
  bool get isTodoCreateLoading => _isTodoCreateLoading;
  set isTodoCreateLoading(bool value) {
    _isTodoCreateLoading = value;
    notifyListeners();
  }

  String formatDate(int value) {
    return "${DateTime.now().add(Duration(days: value))}".substring(0, 10);
  }

  formClear() async {
    _isTodoCreateLoading = false;
    _isAssignUserLoading = false;
    _subjectController = TextEditingController(text: "");
    _ledgerController = TextEditingController(text: "");
    _agentController = TextEditingController(text: "");
    _frequencyController = TextEditingController(text: "");
    _fromDateController = TextEditingController(text: formatDate(0));
    _toDateController = TextEditingController(text: formatDate(4));
    _priorityController = TextEditingController(text: "");
    _descriptionController = TextEditingController(text: "");
    _taskStatusController = TextEditingController(text: "Pending");

    await Future.delayed(const Duration(seconds: 0), () async {
      dropdownDataLoading = true;
      await getAssignUserFromRemote();
      await getLedgerListFromRemote();
      dropdownDataLoading = false;
    });
  }

  late TextEditingController _subjectController, _ledgerController;
  late TextEditingController _agentController, _frequencyController;
  late TextEditingController _fromDateController, _toDateController;
  late TextEditingController _priorityController, _descriptionController;
  late TextEditingController _taskStatusController;
  //
  TextEditingController get subjectController => _subjectController;
  TextEditingController get ledgerController => _ledgerController;
  TextEditingController get agentController => _agentController;
  TextEditingController get frequencyController => _frequencyController;
  TextEditingController get fromDateController => _fromDateController;
  TextEditingController get toDateController => _toDateController;
  TextEditingController get priorityController => _priorityController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get taskStatusController => _taskStatusController;

  ///
  ///
  sendableDate(String date) {
    final year = date.split("/").first;
    final month = date.split("/").elementAt(1);
    final day = date.split("/").last;
    final result = "$day/$month/$year";

    debugPrint("Format DATE : $date");
    debugPrint("Result DATE : $result");
    return result;
  }

  createTodoActivityFromRemote() async {
    isTodoCreateLoading = true;
    CreateActivityModel model = await ToDoAPI.createToDo(
      databaseName: _companyDetail.databaseName,
      frequencyType: _frequencyController.text,
      description: _descriptionController.text,
      todoItems: _subjectController.text.trim(),
      priorityLevel: _priorityController.text,
      // createdBy: _companyDetail.userCode,
      createdBy:"OMS",
      assignedBy: "OMS",
      assignedTo: "$_assignToUserList",
      fromDate: _fromDateController.text,
      toDate: _toDateController.text,
      // fromDate: sendableDate(_fromDateController.text),
      // toDate: sendableDate(_toDateController.text),
      taskStatus: _taskStatusController.text,
      closedStatus: "",
      closedBy: "",
      closedDate: "",
      glDesc: "",
      glCode: "",
      agentDesc: _companyDetail.agentCode,
      agentCode: _companyDetail.agentCode,
    );

    if (model.statusCode == 200) {
      ShowToast.successToast(msg: model.message);
      navigator.pop();
      navigator.pop();
    } else {
      ShowToast.errorToast(msg: model.message);
    }

    isTodoCreateLoading = false;
    notifyListeners();
  }

  ///
  ///
  late List<String> _assignToUserList = [];
  List<String> get assignToUserList => _assignToUserList;
  set assignToUserList(List<String> value) {
    _assignToUserList = value;
    notifyListeners();
  }

  late bool _isAssignUserLoading = false;
  bool get dropdownDataLoading => _isAssignUserLoading;
  set dropdownDataLoading(bool value) {
    _isAssignUserLoading = value;
    notifyListeners();
  }

  late List<MultiSelectItem<String>> _dropdownItems = [];
  List<MultiSelectItem<String>> get dropdownItems => _dropdownItems;
  set dropdownItems(List<MultiSelectItem<String>> value) {
    _dropdownItems = value;
    notifyListeners();
  }

  void _generateDropDownItems(List<TodoUserAssignDataModel> value) {
    dropdownItems = value
        .map((indexData) => MultiSelectItem<String>(
              indexData.userCode,
              indexData.userCode,
            ))
        .toList();

    notifyListeners();
  }

  getAssignUserFromRemote() async {
    TodoUserAssignModel model = await ToDoAPI.getAssignToUser(
      databaseName: _companyDetail.databaseName,
    );

    if (model.statusCode == 200) {
      _generateDropDownItems(model.data);
    } else {
      assignToUserList = [];
    }

    notifyListeners();
  }

  late List<TodoLedgerDataModel> _ledgerList = [];
  List<TodoLedgerDataModel> get ledgerList => _ledgerList;
  set ledgerList(List<TodoLedgerDataModel> value) {
    _ledgerList = value;
    notifyListeners();
  }

  Future getLedgerListFromRemote() async {
    TodoLedgerModel model = await ToDoAPI.getLedgerList(
      databaseName: _companyDetail.databaseName,
    );

    if (model.statusCode == 200) {
      ledgerList = model.data;
    } else {
      ledgerList = [];
    }

    notifyListeners();
  }

  ///
}
