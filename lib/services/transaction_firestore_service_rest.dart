import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/transaction.dart' as transModel;

class TransactionFirestoreServiceRest {
  final CollectionReference transactionsCollection =
      FirebaseFirestore.instance.collection("transactions");

  Future<List<transModel.Transaction>> getTransactionList(
      String userId, String type, String month) async {
    final snapshot = await transactionsCollection
        .where("userId", isEqualTo: userId)
        .where("type", isEqualTo: type)
        .where("month", isEqualTo: month)
        .get();
    print(snapshot.docs);
    if (snapshot != null) {
      return (snapshot.docs)
          .map((doc) => transModel.Transaction.fromJson(doc.data()))
          .toList();
    } else {
      return [];
    }
  }

  Future<transModel.Transaction> getTransaction(
      transModel.Transaction transaction) async {
    final snapshot = await transactionsCollection.doc(transaction.id).get();

    return transModel.Transaction.fromJson(snapshot.data());
  }

  Future<transModel.Transaction> addTransaction(
      transModel.Transaction transaction) async {
    final docTransaction = transactionsCollection.doc();
    transaction.id = docTransaction.id;
    await docTransaction.set(transaction.toJson());

    return await getTransaction(transaction);
  }

  Future<transModel.Transaction> updateTransaction(
      transModel.Transaction transaction) async {
    await transactionsCollection
        .doc(transaction.id)
        .update(transaction.toJson());

    return await getTransaction(transaction);
  }

  Future<void> deleteTransaction(String id) async {
    await transactionsCollection.doc(id).delete();
  }
}
