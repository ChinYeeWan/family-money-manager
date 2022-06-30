import '../../locator.dart';
import '../../models/transaction.dart';
import 'rest_service.dart';

class TransactionServiceRest {
  final rest = locator<RestService>();

  Future<List<Transaction>> getTransactionList(
      String userId, String type, String month) async {
    final listJson =
        await rest.get('transactions?userId=$userId&type=$type&month=$month');

    if (listJson.length == 0) {
      return [];
    } else {
      return (listJson as List)
          .map((itemJson) => Transaction.fromJson(itemJson))
          .toList();
    }
  }

  Future<Transaction> addTransaction(Transaction transaction) async {
    final json = await rest.post('transactions', data: transaction);
    return Transaction.fromJson(json);
  }

  Future<Transaction> updateTransaction(Transaction transaction) async {
    final json =
        await rest.put('transactions/${transaction.id}', data: transaction);
    return Transaction.fromJson(json);
  }

  Future<void> deleteTransaction(String id) async {
    await rest.delete('transactions/$id');
  }
}
