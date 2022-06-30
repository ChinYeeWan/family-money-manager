import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:multi_sort/multi_sort.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constants/color.dart';
import '../constants/month_list.dart';
import '../locator.dart';
import '../models/category.dart';
import '../models/category_data.dart';
import '../models/member.dart';
import '../models/transaction.dart';
import '../services/category_firestore_service_rest.dart';
import '../services/category_icon_service.dart';
import '../services/transaction_firestore_service_rest.dart';
import 'base_model.dart';

class OverviewMemberModel extends BaseModel {
  TooltipBehavior tooltipBehavior = TooltipBehavior(
      enable: true, color: primary, textStyle: TextStyle(color: black));

  Member user;
  final TransactionFirestoreServiceRest _transactionServiceRest =
      locator<TransactionFirestoreServiceRest>();
  final CategoryFirestoreServiceRest _categoryServiceRest =
      locator<CategoryFirestoreServiceRest>();
  final FixCategoryIconService _categoryIconService =
      locator<FixCategoryIconService>();

  ScrollController scrollController =
      new ScrollController(); // set controller on scrolling
  bool show = true;
  bool isCollabsed = false;

  List<Transaction> expenseTransactionList = [];
  List<Transaction> incomeTransactionList = [];
  List<Category> expenseCategoryList = [];
  List<Category> incomeCategoryList = [];
  List<CategoryData> categoryList = [];
  List<Category> categories = [];
  List<Transaction> transactionList = [];
  int selectedMonthIndex;
  String appBarTitle; // selected month
  double expenseSum = 0;
  double incomeSum = 0;
  bool isExpense = true;

  //init
  void init(u) async {
    user = u;
    setState(ViewState.Busy);
    notifyListeners();
    selectedMonthIndex = DateTime.now().month - 1;
    appBarTitle = months[selectedMonthIndex];
    await loadCategoriesIcons();
    await getAllTransaction();
    getCategoryListForPieChart();
    setState(ViewState.Idle);
    notifyListeners();

    print(categoryList);
  }

  //Get the transactions data of the Member
  Future<void> getAllTransaction() async {
    print("---------------------getMemberTransaction");

    expenseTransactionList = await _transactionServiceRest.getTransactionList(
        user.id, "expense", appBarTitle);
    incomeTransactionList = await _transactionServiceRest.getTransactionList(
        user.id, "income", appBarTitle);

    sortList(expenseTransactionList);
    sortList(incomeTransactionList);

    if (expenseTransactionList.isNotEmpty) {
      expenseSum = expenseTransactionList.fold(
          0, (sum, transaction) => sum + transaction.amount);
    } else {
      expenseSum = 0;
    }

    if (incomeTransactionList.isNotEmpty) {
      incomeSum = incomeTransactionList.fold(
          0, (sum, transaction) => sum + transaction.amount);
    } else {
      incomeSum = 0;
    }
  }

  void sortList(List<Transaction> list) {
    List<bool> criteria = [false, false];
    List<String> preferrence = ['day', 'id'];
    list.multisort(criteria, preferrence);
  }

  //Get category of the member
  Future<void> loadCategoriesIcons() async {
    print("---------------------getCategoryTransaction");
    var databaseCategoryList;
    var fixCategoryList;

    // load expense
    databaseCategoryList =
        await _categoryServiceRest.getCategoryList(user.id, 'expense');
    fixCategoryList = _categoryIconService.expenseList.toList();
    expenseCategoryList = databaseCategoryList + fixCategoryList;

    // load income
    databaseCategoryList =
        await _categoryServiceRest.getCategoryList(user.id, 'income');
    fixCategoryList = _categoryIconService.incomeList.toList();
    incomeCategoryList = databaseCategoryList + fixCategoryList;
  }

  getCategoryListForPieChart() {
    print('------------------------------get data for por chart');
    categoryList = [];
    transactionList = [];

    if (isExpense == true) {
      transactionList = expenseTransactionList;
      // load expense icon
      categories = expenseCategoryList;
    } else {
      transactionList = incomeTransactionList;
      // load income icon
      categories = incomeCategoryList;
    }

    sortAndGroupList();
  }

  sortAndGroupList() {
    //Group category data
    var groupList =
        groupBy(transactionList, (transaction) => transaction.category.id);

    groupList.forEach((categoryId, transactions) {
      double categorySum =
          transactions.fold(0, (sum, transaction) => sum + transaction.amount);
      int index =
          categories.indexWhere(((category) => category.id == categoryId));
      CategoryData category = CategoryData(categories[index], categorySum);
      categoryList.add(category);
    });

    //Sort Category List
    categoryList.sort((a, b) => b.amount.compareTo(a.amount));
  }

  changeType() {
    isExpense = !isExpense;
    getCategoryListForPieChart();
    notifyListeners();
  }

  //---------------------------------Month Click-----------------
  monthClicked(String clickedMonth) async {
    selectedMonthIndex = months.indexOf(clickedMonth);
    appBarTitle = clickedMonth;
    await getAllTransaction();
    getCategoryListForPieChart();
    titleClicked();
  }

  titleClicked() {
    isCollabsed = !isCollabsed;
    notifyListeners();
  }

  getColor(month) {
    int monthIndex = months.indexOf(month);
    // color the selected month with
    if (monthIndex == selectedMonthIndex) {
      return Colors.orange;
    } else {
      return Colors.black;
    }
  }

  void closeMonthPicker() {
    isCollabsed = false;
    notifyListeners();
  }
}
