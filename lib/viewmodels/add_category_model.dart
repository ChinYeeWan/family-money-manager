import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/locator.dart';

import '../constants/color.dart';
import '../models/category.dart';
import '../models/iconPicker.dart';
import '../services/category_firestore_service_rest.dart';
import '../services/icon_picker_data_service.dart';
import 'base_model.dart';

class AddCategoryModel extends BaseModel {
  final CategoryFirestoreServiceRest _categoryServiceRest =
      locator<CategoryFirestoreServiceRest>();
  final IconPickerDataService iconPickerData = locator<IconPickerDataService>();

  bool isExpense;
  String type;
  IconPicker isSelected = IconPicker();
  TextEditingController categoryNameController = TextEditingController();
  List<IconPicker> iconList = [];
  String userId;

  void init(isExp, uId) {
    userId = uId;
    isExpense = isExp;
    iconList = iconPickerData.iconList;
    isSelected = iconPickerData.iconList.elementAt(0);
    defineType();
  }

  void defineType() {
    if (isExpense == true) {
      type = 'expense';
    } else {
      type = 'income';
    }
  }

  void selectIcon(icon) {
    isSelected = icon;
    notifyListeners();
  }

  addCategory(context) async {
    String categoryName = categoryNameController.text;

    if (categoryName.length == 0) {
      Fluttertoast.showToast(
          msg: "Please fill in the name!",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 2,
          backgroundColor: red,
          gravity: ToastGravity.BOTTOM);
      return;
    }

    Category newCategory = new Category(
        type: type,
        name: categoryName,
        icon: isSelected.icon.codePoint.toString(),
        color: isSelected.color.value,
        delete: false,
        userId: userId);
    print(newCategory);
    Category added = await _categoryServiceRest.addCategory(newCategory);

    if (added == null) {
      Fluttertoast.showToast(
          msg: "Category is not added!",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          backgroundColor: red,
          gravity: ToastGravity.BOTTOM);
      return;
    }
    Navigator.of(context).pop();
  }
}
