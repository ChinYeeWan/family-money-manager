import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/color.dart';
import '../models/user.dart';
import '../viewmodels/base_model.dart';
import '../viewmodels/manage_category_model.dart';
import 'base_UI.dart';
import 'widget/income_expense_card_widget.dart';

class ManageCategoryUI extends StatelessWidget {
  final User user;
  ManageCategoryUI({this.user});
  @override
  Widget build(BuildContext context) {
    return BaseUI<ManageCategoryModel>(
      onModelReady: (model) => model.init(user),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: secondary,
          title: Text('Category'),
        ),
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : getBody(context, model),
        bottomNavigationBar: InkWell(
          onTap: () => model.addCategory(context),
          child: Container(
            decoration: BoxDecoration(color: secondary),
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, size: 18),
                Text('Add Catogory', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getBody(BuildContext context, model) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IncomeExpenseCard(
                color: secondary,
                size: size,
                text: 'Income',
                isSelected: !model.isExpense,
                onTap: () => model.changeType(),
              ),
              IncomeExpenseCard(
                color: secondary,
                size: size,
                text: 'Expense',
                isSelected: model.isExpense,
                onTap: () => model.changeType(),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: model.categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(model.categories[index].color),
                    child: Icon(
                      IconDataSolid(
                        int.parse(model.categories[index].icon),
                      ),
                      color: white,
                    ),
                  ),
                  title: Text(model.categories[index].name),
                  trailing: model.categories[index].delete != null
                      ? InkWell(
                          onTap: () => showDeleteDialog(
                              context, model, model.categories[index]),
                          child: Icon(Icons.delete, color: grey),
                        )
                      : null,
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
          ),
        ),
      ],
    );
  }

  showDeleteDialog(BuildContext context, model, category) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete"),
            content: Text("Are you sure do you want to delete this?"),
            actions: <Widget>[
              TextButton(
                child: Text("Delete", style: TextStyle(color: primary)),
                onPressed: () async {
                  await model.deleteCategory(category);
                  // hide dialog
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Cancel", style: TextStyle(color: primary)),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              )
            ],
          );
        });
  }
}
