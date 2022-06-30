import 'package:flutter/material.dart';

import '../locator.dart';
import '../models/category.dart';
import '../models/user.dart';
import '../services/category_firestore_service_rest.dart';
import '../services/category_icon_service.dart';
import 'base_model.dart';

class ManageCategoryModel extends BaseModel {
  ScrollController scrollController = new ScrollController();
  final FixCategoryIconService _categoryIconService =
      locator<FixCategoryIconService>();
  final CategoryFirestoreServiceRest _categoryServiceRest =
      locator<CategoryFirestoreServiceRest>();

  bool isExpense = true;
  List<Category> categories = [];
  User user;

  void init(u) {
    user = u;
    loadCategoriesIcons();
  }

  void loadCategoriesIcons() async {
    var databaseCategoryList;
    var fixCategoryList;
    setState(ViewState.Busy);
    notifyListeners();
    if (isExpense == true) {
      // load expense
      databaseCategoryList =
          await _categoryServiceRest.getCategoryList(user.id, 'expense');
      fixCategoryList = _categoryIconService.expenseList.toList();
    } else {
      // load income
      databaseCategoryList =
          await _categoryServiceRest.getCategoryList(user.id, 'income');
      fixCategoryList = _categoryIconService.incomeList.toList();
    }

    categories = databaseCategoryList + fixCategoryList;
    setState(ViewState.Idle);
    notifyListeners();
  }

  changeType() {
    isExpense = !isExpense;
    loadCategoriesIcons();
    notifyListeners();
  }

  void addCategory(context) async {
    await Navigator.pushNamed(context, "addCategory",
        arguments: [isExpense, user.id]);
    loadCategoriesIcons();
    notifyListeners();
  }

  void deleteCategory(category) async {
    await _categoryServiceRest.deleteCategory(category.id);
    loadCategoriesIcons();
    notifyListeners();
  }
}
