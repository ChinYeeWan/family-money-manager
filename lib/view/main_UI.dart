import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../constants/color.dart';
import '../models/user.dart';
import '../viewmodels/main_model.dart';
import 'base_UI.dart';
import 'expense_UI.dart';
import 'income_UI.dart';
import 'overview_UI.dart';
import 'profile_UI.dart';
import 'widget/scroll_to_hide_widget.dart';

class MainUI extends StatelessWidget {
  final User user;
  MainUI(this.user);
  @override
  Widget build(BuildContext context) {
    return BaseUI<MainModel>(
        onModelReady: (model) => model.init(user),
        builder: (context, model, child) => Scaffold(
            body: getBody(model),
            bottomNavigationBar: ScrollToHide(
                model: model,
                controller: model.scrollController,
                child: getBottomNavigationBar(model)),
            floatingActionButton: Visibility(
              visible: model.show,
              child: FloatingActionButton(
                onPressed: () async {
                  await model.addTransaction(context);
                },
                child: Icon(
                  Icons.add,
                  size: 25,
                  color: white,
                ),
                backgroundColor: primary,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked));
  }

  Widget getBody(MainModel model) {
    return IndexedStack(
      index: model.pageIndex,
      children: [
        IncomeUI(model: model, incomeList: model.incomeTransactionList),
        ExpenseUI(model: model, expenseList: model.expenseTransactionList),
        OverviewUI(
          mainModel: model,
        ),
        ProfileUI(model: model),
      ],
    );
  }

  Widget getBottomNavigationBar(model) {
    List<IconData> iconItems = [
      Ionicons.wallet,
      Ionicons.receipt,
      Ionicons.pie_chart,
      Ionicons.person,
    ];
    return AnimatedBottomNavigationBar(
      activeColor: primary,
      splashColor: secondary,
      gapLocation: GapLocation.center,
      inactiveColor: Colors.black.withOpacity(0.5),
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
      icons: iconItems,
      activeIndex: model.pageIndex,
      onTap: (index) {
        model.clickTab(index);
      },
    );
  }
}
