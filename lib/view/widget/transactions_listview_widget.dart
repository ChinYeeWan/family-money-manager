import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/color.dart';
import '../../models/transaction.dart';
import '../../viewmodels/main_model.dart';

class TransactionsListView extends StatelessWidget {
  final List<Transaction> transactions;
  final MainModel model;

  const TransactionsListView(this.model, this.transactions);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        controller: model.scrollController,
        padding: EdgeInsets.all(8),
        children: transactions.map((transaction) {
          return Card(
            child: InkWell(
              onTap: () async => await model.moveToDetail(context, transaction),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "${transaction.day}, ${transaction.month}",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(transaction.category.color),
                        child: Icon(
                            IconDataSolid(int.parse(transaction.category.icon)),
                            color: white),
                      ),
                      title: Text(transaction.memo),
                      trailing: transaction.type == 'expense'
                          ? Text('- ' + transaction.amount.toStringAsFixed(2),
                              style: TextStyle(fontSize: 20))
                          : Text(transaction.amount.toStringAsFixed(2),
                              style: TextStyle(fontSize: 20)),
                    )
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
