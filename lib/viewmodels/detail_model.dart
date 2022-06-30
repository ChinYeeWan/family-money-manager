import 'package:flutter/material.dart';

import '../locator.dart';
import '../models/transaction.dart';
import '../services/transaction_firestore_service_rest.dart';
import 'base_model.dart';

class DetailModel extends BaseModel {
  final TransactionFirestoreServiceRest _transactionServiceRest =
      locator<TransactionFirestoreServiceRest>();

  Transaction transaction;
  bool isUpdated;
  double height;

  void init(transac) {
    transaction = transac;
    isUpdated = false;
    checkHeight();
    notifyListeners();
  }

  backHome(context) {
    if (isUpdated == true) {
      Navigator.of(context).pop(isUpdated);
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<void> editTransaction(context) async {
    final updated = await Navigator.of(context)
        .pushNamed('edit', arguments: transaction.copyWith());
    if (updated != null) {
      isUpdated = true;
      transaction = updated;
      checkHeight();
      notifyListeners();
    }
  }

  Future<void> deleteTransaction(Transaction transaction) async {
    await _transactionServiceRest.deleteTransaction(transaction.id);
    notifyListeners();
  }

  checkHeight() {
    height = transaction.imagePath == null ? 360.0 : 480.0;
  }
}
