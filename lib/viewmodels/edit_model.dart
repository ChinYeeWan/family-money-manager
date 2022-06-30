import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../locator.dart';
import '../constants/color.dart';
import '../constants/month_list.dart';
import '../models/category.dart';
import '../models/transaction.dart';
import '../services/transaction_firestore_service_rest.dart';
import 'base_model.dart';

class EditModel extends BaseModel {
  TextEditingController memoController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final TransactionFirestoreServiceRest _transactionServiceRest =
      locator<TransactionFirestoreServiceRest>();

  String selectedDay;
  String selectedMonth;
  String selectedYear;
  DateTime selectedDate;
  String imagePath;
  Category category;
  String userId;

  void init(Transaction transaction) async {
    // initla values are current day and month
    userId = transaction.userId;
    selectedMonth = transaction.month;
    selectedDay = transaction.day.toString();
    selectedYear = transaction.year.toString();
    selectedDate = formatDate();
    category = transaction.category;
    memoController.text = transaction.memo;
    amountController.text = transaction.amount.toString();
    imagePath = transaction.imagePath;
    notifyListeners();
  }

  DateTime formatDate() {
    String day = selectedDay.padLeft(2, '0');
    int monthIndex = months.indexWhere((month) => month == selectedMonth) + 1;
    String month = monthIndex.toString().padLeft(2, '0');
    String year = selectedYear;
    String formatDate = "$year-$month-$day";

    return DateTime.parse(formatDate);
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

  Future<void> chooseCategory(context, selectedType) async {
    final chosenCategory = await Navigator.pushNamed(context, "chooseCategory",
        arguments: [selectedType, userId]);

    if (chosenCategory != null) {
      category = chosenCategory;
    }
    notifyListeners();
  }

  removeImage() {
    imagePath = null;
    notifyListeners();
  }

  editTransaction(context, transaction) async {
    String memo = memoController.text;
    String amount = amountController.text;

    if (amount.length == 0) {
      Fluttertoast.showToast(
          msg: "Please fill in the amount!",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: red,
          gravity: ToastGravity.BOTTOM);
      return;
    }

    if (memo.length == 0) {
      memo = category.name;
    }

    Transaction updatedTransaction = new Transaction(
        type: transaction.type,
        day: int.parse(selectedDay),
        id: transaction.id,
        month: selectedMonth,
        year: int.parse(selectedYear),
        memo: memo,
        amount: double.parse(amount),
        category: category,
        userId: transaction.userId,
        imagePath: imagePath);

    // edit it!
    Transaction updated =
        await _transactionServiceRest.updateTransaction(updatedTransaction);

    if (updated == null) {
      Fluttertoast.showToast(
          msg: "Transaction is not updated!",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 2,
          backgroundColor: red,
          gravity: ToastGravity.BOTTOM);
      return;
    }
    Fluttertoast.showToast(
        msg: "Transaction is updated!",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 2,
        backgroundColor: primary,
        gravity: ToastGravity.BOTTOM);

    // return to the home
    Navigator.of(context).pop(updatedTransaction);
  }
}
