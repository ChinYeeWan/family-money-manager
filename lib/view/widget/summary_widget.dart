import 'package:flutter/material.dart';
import 'package:fyp/constants/color.dart';

import '../../constants/text_style.dart';
import '../../constants/ui_helper.dart';

class SummaryWidget extends StatelessWidget {
  final bool isExpense;
  final double income;
  final double expense;

  const SummaryWidget({this.isExpense, this.income, this.expense});

  @override
  Widget build(BuildContext context) {
    var balance = income - expense;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Income',
                      style: !isExpense
                          ? summaryColorTextStyle
                          : summaryTextStyle),
                  UIHelper.verticalSpaceSmall(),
                  Text(income == 0.0 ? "0" : income.toStringAsFixed(2),
                      style: !isExpense
                          ? summaryNumberColorTextStyle
                          : summaryNumberTextStyle)
                ],
              ),
              Text(
                '|',
                style: TextStyle(
                    fontSize: 40, color: grey, fontWeight: FontWeight.w200),
              ),
              Column(
                children: <Widget>[
                  Text('Expense',
                      style:
                          isExpense ? summaryColorTextStyle : summaryTextStyle),
                  UIHelper.verticalSpaceSmall(),
                  Text(expense == 0.0 ? "0" : expense.toStringAsFixed(2),
                      style: isExpense
                          ? summaryNumberColorTextStyle
                          : summaryNumberTextStyle)
                ],
              ),
              Text(
                '|',
                style: TextStyle(
                    fontSize: 40, color: grey, fontWeight: FontWeight.w200),
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Balance',
                    style: summaryTextStyle,
                  ),
                  UIHelper.verticalSpaceSmall(),
                  Text(balance == 0.0 ? "0" : balance.toStringAsFixed(2),
                      style: summaryNumberTextStyle)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
