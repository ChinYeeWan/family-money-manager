import 'package:flutter/material.dart';
import 'package:fyp/viewmodels/main_model.dart';

import '../constants/color.dart';
import '../models/transaction.dart';
import '../viewmodels/base_model.dart';
import 'widget/app_bar_title_widget.dart';
import 'widget/empty_transaction_widget.dart';
import 'widget/pick_month_overlay.dart';
import 'widget/summary_widget.dart';
import 'widget/transactions_listview_widget.dart';

class IncomeUI extends StatelessWidget {
  final MainModel model;
  final List<Transaction> incomeList;
  IncomeUI({this.model, this.incomeList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTitle(model),
      backgroundColor: grey.withOpacity(0.05),
      body: model.state == ViewState.Busy
          ? Center(child: CircularProgressIndicator())
          : getBody(context, model),
    );
  }

  Widget getBody(context, MainModel model) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            SummaryWidget(
              isExpense: false,
              income: model.incomeSum,
              expense: model.expenseSum,
            ),
            buildList(context, model, incomeList),
          ],
        ),
        model.isCollabsed
            ? PickMonthOverlay(
                model: model, showOrHide: model.isCollabsed, context: context)
            : Container(),
      ],
    );
  }

  buildList(context, MainModel model, incomeList) {
    return incomeList.length == 0
        ? EmptyTransactionsWidget()
        : TransactionsListView(model, incomeList);
  }
}
