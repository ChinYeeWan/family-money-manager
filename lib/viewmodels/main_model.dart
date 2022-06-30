import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multi_sort/multi_sort.dart';

import '../constants/month_list.dart';
import '../locator.dart';
import '../models/category.dart';
import '../models/transaction.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/category_firestore_service_rest.dart';
import '../services/category_icon_service.dart';
import '../services/transaction_firestore_service_rest.dart';

import 'base_model.dart';

class MainModel extends BaseModel {
  final AuthService _authService = locator<AuthService>();
  final TransactionFirestoreServiceRest _transactionServiceRest =
      locator<TransactionFirestoreServiceRest>();
  final CategoryFirestoreServiceRest _categoryServiceRest =
      locator<CategoryFirestoreServiceRest>();
  final FixCategoryIconService _categoryIconService =
      locator<FixCategoryIconService>();

  ScrollController scrollController =
      new ScrollController(); // set controller on scrolling
  bool show = true;

  User user;
  List<Transaction> expenseTransactionList = [];
  List<Transaction> incomeTransactionList = [];
  int selectedMonthIndex;
  String appBarTitle; // selected month
  double expenseSum = 0;
  double incomeSum = 0;
  int pageIndex; //0-Income, 1-Expense, 2-Overview, 3-Profile, 4-Add

  bool isCollabsed = false;
  List<Category> incomeCategoryList = [];
  List<Category> expenseCategoryList = [];

  init(u) async {
    handleScroll();
    user = u;
    pageIndex = 1;
    selectedMonthIndex = DateTime.now().month - 1;
    appBarTitle = months[selectedMonthIndex];

    loadCategoriesIcons();
    await getAllTransaction();
  }

  Future<void> getAllTransaction() async {
    print("---------------------getAllTransaction");
    setState(ViewState.Busy);
    notifyListeners();
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
    setState(ViewState.Idle);
    notifyListeners();
  }

  void sortList(List<Transaction> list) {
    List<bool> criteria = [false, false];
    List<String> preferrence = ['day', 'id'];
    list.multisort(criteria, preferrence);
  }

  //---------------------------------Move Screen-----------------
  void clickTab(int index) async {
    pageIndex = index;
    if (isCollabsed == true) {
      isCollabsed = !isCollabsed;
    }
    notifyListeners();
  }

  Future<void> addTransaction(context) async {
    if (isCollabsed == true) {
      isCollabsed = !isCollabsed;
    }
    if (pageIndex == 0) {
      await Navigator.of(context).pushNamed('add', arguments: [0, user]);
    } else {
      await Navigator.of(context).pushNamed('add', arguments: [1, user]);
    }
    getAllTransaction();
    notifyListeners();
  }

  Future<void> moveToDetail(context, transaction) async {
    await Navigator.pushNamed(context, "detail", arguments: transaction);
    getAllTransaction();
    notifyListeners();
  }

  //-------------------------------Scroll Controller-------------
  void handleScroll() async {
    scrollController.addListener(() {
      if (scrollController.positions
          .any((pos) => pos.userScrollDirection == ScrollDirection.reverse)) {
        hideBottomNav();
      }
      if (scrollController.positions
          .any((pos) => pos.userScrollDirection == ScrollDirection.forward)) {
        showBottomNav();
      }
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    super.dispose();
  }

  void showBottomNav() {
    show = true;
    notifyListeners();
  }

  void hideBottomNav() {
    show = false;
    notifyListeners();
  }

  //---------------------------------Month Click-----------------
  monthClicked(String clickedMonth) async {
    selectedMonthIndex = months.indexOf(clickedMonth);
    appBarTitle = clickedMonth;
    await getAllTransaction();
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

  //-------------------------------Load Category-----------------
  void loadCategoriesIcons() async {
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

  // logout
  logout(context) async {
    await _authService.signOut();
    user = new User();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
  }
}
