import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constants/color.dart';
import '../models/category.dart';
import '../models/category_data.dart';
import '../models/transaction.dart';
import 'base_model.dart';
import 'main_model.dart';

class OverviewModel extends BaseModel {
  TooltipBehavior tooltipBehavior = TooltipBehavior(
      enable: true, color: primary, textStyle: TextStyle(color: black));
  MainModel mainModel;
  List<Transaction> transactionList;
  List<Transaction> incomeList;
  List<Transaction> expenseList;
  List<CategoryData> categoryList;
  List<Category> categories;
  bool isExpense = true;

  getCategoryList(main) {
    mainModel = main;
    categoryList = [];
    transactionList = [];

    expenseList = mainModel.expenseTransactionList;
    incomeList = mainModel.incomeTransactionList;

    if (isExpense == true) {
      transactionList = expenseList;
      // load expense icon
      categories = mainModel.expenseCategoryList;
    } else {
      transactionList = incomeList;
      // load income icon
      categories = mainModel.incomeCategoryList;
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

  changeType() async {
    isExpense = !isExpense;

    if (isExpense == true) {
      transactionList = expenseList;
      // load expense icon
      categories = mainModel.expenseCategoryList;
    } else {
      transactionList = incomeList;
      // load income icon
      categories = mainModel.incomeCategoryList;
    }

    sortAndGroupList();
    notifyListeners();
  }
}
