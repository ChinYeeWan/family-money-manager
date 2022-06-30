import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../constants/color.dart';
import '../constants/month_list.dart';
import '../constants/veryfi_api.dart';
import '../locator.dart';
import '../models/category.dart';
import '../models/transaction.dart';
import '../models/user.dart';
import '../services/category_icon_service.dart';
import '../services/transaction_firestore_service_rest.dart';
import 'base_model.dart';

class AddModel extends BaseModel {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  TextEditingController memoController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final FixCategoryIconService _categoryIconService =
      locator<FixCategoryIconService>();

  final TransactionFirestoreServiceRest _transactionServiceRest =
      locator<TransactionFirestoreServiceRest>();

  DateTime selectedDate = new DateTime.now();
  String selectedDay;
  String selectedMonth;
  String selectedYear;
  String type;
  String imagePath;
  Category category;
  Transaction transaction;
  bool isExpense = true;
  User user;

  void init(int selectedTypeIndex, u) {
    // initial values are current day and month
    selectedMonth = months[DateTime.now().month - 1];
    selectedDay = DateTime.now().day.toString();
    selectedYear = DateTime.now().year.toString();
    type = (selectedTypeIndex == 0) ? 'income' : 'expense';
    if (type == 'income') {
      isExpense = false;
      category = _categoryIconService.incomeList.elementAt(0);
    } else {
      category = _categoryIconService.expenseList.elementAt(0);
    }
    user = u;
  }

  Future selectDate(context) async {
    // hide the keyboard
    unFocusFromTheTextField(context);

    DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now());

    if (picked != null) {
      selectedMonth = months[picked.month - 1];
      selectedDay = picked.day.toString();
      selectedYear = picked.year.toString();
      selectedDate = picked;

      notifyListeners();
    }
  }

  void unFocusFromTheTextField(context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  String getSelectedDate() {
    if (int.parse(selectedDay) == DateTime.now().day &&
        DateTime.now().month == months.indexOf(selectedMonth) + 1) {
      return 'Today, ' + selectedDay + ' ' + selectedMonth + ' ' + selectedYear;
    } else {
      return selectedDay + ' ' + selectedMonth + ' ' + selectedYear;
    }
  }

  changeType() {
    isExpense = !isExpense;

    if (isExpense == false) {
      type = 'income';
      category = _categoryIconService.incomeList.elementAt(0);
    } else {
      type = 'expense';
      category = _categoryIconService.expenseList.elementAt(0);
    }
    notifyListeners();
  }

  chooseCategory(context, selectedType) async {
    final chosenCategory = await Navigator.pushNamed(context, "chooseCategory",
        arguments: [selectedType, user.id]);

    if (chosenCategory != null) {
      category = chosenCategory;
    }
    notifyListeners();
  }

  //--------------------------Scan Receipt------------------------------
  File imageFile;
  ImagePicker imagePicker = new ImagePicker();

  Future pickImage(ImageSource imageSource) async {
    setState(ViewState.Busy);
    notifyListeners();
    try {
      final image = await imagePicker.pickImage(source: imageSource);

      if (image == null) return;

      final imageTemporary = File(image.path);
      imageFile = imageTemporary;
      await processDocument();

      setState(ViewState.Idle);
      notifyListeners();
    } on Exception catch (e) {
      print('Failed to pick image $e');
    }
  }

  Future<void> processDocument() async {
    Uint8List imageData = imageFile.readAsBytesSync();
    String fileData = base64Encode(imageData);

    await client.processDocument(imageFile.path, fileData).then(
      (response) {
        if (response["total"] != null) {
          amountController.text = response["total"].toString();
        }
        if (response["vendor"]["name"] != null) {
          memoController.text = response["vendor"]["name"];
        }

        imagePath = response["img_url"];

        //format date
        selectedDate = dateFormat.parse(response["date"]);

        selectedMonth = months[selectedDate.month - 1];
        selectedDay = selectedDate.day.toString();
        selectedYear = selectedDate.year.toString();
        getSelectedDate();

        print('done process');
      },
    ).catchError((error) {
      print('process data failed');
      print(error);
    });
  }

  removeImage() {
    imagePath = null;
    notifyListeners();
  }

  //--------------------------------------------------------------------

  addTransaction(context) async {
    String amount = amountController.text;
    String memo = memoController.text;

    if (amount.length == 0) {
      Fluttertoast.showToast(
          msg: "Please fill in the amount!",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 2,
          backgroundColor: red,
          gravity: ToastGravity.BOTTOM);
      return;
    }

    if (memo.length == 0) {
      memo = category.name;
    }

    Transaction newTransaction = new Transaction(
        type: type,
        day: int.parse(selectedDay),
        month: selectedMonth,
        year: int.parse(selectedYear),
        memo: memo,
        amount: double.parse(amount),
        category: category,
        userId: user.id,
        imagePath: imagePath);

    // insert it!
    Transaction added =
        await _transactionServiceRest.addTransaction(newTransaction);

    if (added == null) {
      Fluttertoast.showToast(
          msg: "Transaction is not added!",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          backgroundColor: red,
          gravity: ToastGravity.BOTTOM);
      return;
    }

    // return to the home
    Navigator.of(context).pop();
    print("--------------------------added expense");
  }
}
