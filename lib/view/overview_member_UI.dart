import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/color.dart';
import '../constants/text_style.dart';
import '../constants/ui_helper.dart';
import '../models/member.dart';
import '../viewmodels/base_model.dart';
import '../viewmodels/overview_member_model.dart';
import 'base_UI.dart';
import 'widget/no_data_found_widget.dart';
import 'widget/pick_month_overlay.dart';
import 'widget/pie_chart.dart';

class OverviewMemberUI extends StatelessWidget {
  final Member user;
  OverviewMemberUI({this.user});

  @override
  Widget build(BuildContext context) {
    return BaseUI<OverviewMemberModel>(
      onModelReady: (model) => model.init(user),
      builder: (context, model, child) => Scaffold(
        appBar: getAppBar(model),
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : getBody(context, model),
      ),
    );
  }

  Widget getAppBar(model) {
    return AppBar(
      backgroundColor: secondary,
      title: InkWell(
        onTap: () {
          model.titleClicked();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  model.appBarTitle,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                model.isCollabsed
                    ? Icon(
                        Icons.arrow_drop_down,
                      )
                    : Icon(
                        Icons.arrow_drop_up,
                      ),
              ],
            ),
            Text('${user.username}',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget getBody(context, model) {
    var size = MediaQuery.of(context).size;
    var income = model.incomeSum;
    var expense = model.expenseSum;
    var balance = income - expense;
    var total = model.isExpense ? expense : income;

    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            model.isCollabsed
                ? PickMonthOverlay(
                    model: model,
                    showOrHide: model.isCollabsed,
                    context: context)
                : Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buildCard(
                      size: size,
                      text: 'Income',
                      sum: income,
                      isSelected: !model.isExpense,
                      onTap: () async => await model.changeType()),
                  buildCard(
                      size: size,
                      text: 'Expense',
                      sum: expense,
                      isSelected: model.isExpense,
                      onTap: () async => await model.changeType()),
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
            model.categoryList.length == 0
                ? NoDataFoundWidget()
                : Flexible(
                    child: ListView(
                      controller: model.scrollController,
                      children: <Widget>[
                        PieChart(
                            tooltipBehavior: model.tooltipBehavior,
                            chartData: model.categoryList,
                            total: total),
                        buildList(
                          context,
                          model.categoryList,
                          model,
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}

buildList(context, categoryList, model) {
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
                    model.isExpense ? "Expense List" : "Income List",
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
