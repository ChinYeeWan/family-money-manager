import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/color.dart';
import '../constants/text_style.dart';
import '../constants/ui_helper.dart';
import '../viewmodels/base_model.dart';
import '../viewmodels/main_model.dart';
import '../viewmodels/overview_model.dart';
import 'base_UI.dart';
import 'widget/app_bar_title_widget.dart';
import 'widget/no_data_found_widget.dart';
import 'widget/pie_chart.dart';

class OverviewUI extends StatelessWidget {
  final MainModel mainModel;
  OverviewUI({this.mainModel});

  @override
  Widget build(BuildContext context) {
    return BaseUI<OverviewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBarTitle(mainModel),
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : getBody(context, mainModel, model),
      ),
    );
  }

  Widget getBody(context, MainModel mainModel, OverviewModel overviewModel) {
    overviewModel.getCategoryList(mainModel);
    var size = MediaQuery.of(context).size;
    var income = mainModel.incomeSum;
    var expense = mainModel.expenseSum;
    var balance = income - expense;
    var total = overviewModel.isExpense ? expense : income;

    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buildCard(
                      size: size,
                      text: 'Income',
                      sum: income,
                      isSelected: !overviewModel.isExpense,
                      onTap: () async => await overviewModel.changeType()),
                  buildCard(
                      size: size,
                      text: 'Expense',
                      sum: expense,
                      isSelected: overviewModel.isExpense,
                      onTap: () async => await overviewModel.changeType()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                width: size.width - 40,
                child: Column(
                  children: <Widget>[
                    Text(
                        "Balance: " +
                            (balance == 0.0 ? "0" : balance.toStringAsFixed(2)),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: balance == 0
                              ? black
                              : balance < 0
                                  ? red
                                  : green,
                        )),
                  ],
                ),
              ),
            ),
            overviewModel.categoryList.length == 0
                ? NoDataFoundWidget()
                : Flexible(
                    child: ListView(
                      controller: mainModel.scrollController,
                      children: <Widget>[
                        PieChart(
                            tooltipBehavior: overviewModel.tooltipBehavior,
                            chartData: overviewModel.categoryList,
                            total: total),
                        buildList(context, overviewModel.categoryList,
                            mainModel, overviewModel),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}

buildList(context, categoryList, mainModel, overviewModel) {
  return categoryList.length == 0
      ? Container()
      : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Text(
                    overviewModel.isExpense ? "Expense List" : "Income List",
                    style: titleItemStyle,
                    textAlign: TextAlign.left,
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: categoryList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor:
                                  Color(categoryList[index].category.color),
                              child: Icon(
                                IconDataSolid(
                                  int.parse(categoryList[index].category.icon),
                                ),
                                color: white,
                              ),
                            ),
                            title: Text(categoryList[index].category.name),
                            trailing: Text(
                                categoryList[index].amount.toStringAsFixed(2),
                                style: TextStyle(fontSize: 20))),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                  ),
                ],
              ),
            ),
          ),
        );
}

buildCard({text, onTap, isSelected, size, sum}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      color: isSelected ? primary : null,
      elevation: 4,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        width: (size.width / 2) - 20,
        child: Column(
          children: <Widget>[
            Text(text, style: summaryTextStyle),
            UIHelper.verticalSpaceSmall(),
            Text(sum == 0.0 ? "0" : sum.toStringAsFixed(2),
                style: summaryNumberTextStyle)
          ],
        ),
      ),
    ),
  );
}
