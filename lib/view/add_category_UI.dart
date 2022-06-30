import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../viewmodels/add_category_model.dart';
import 'base_UI.dart';

class AddCategoryUI extends StatelessWidget {
  final bool isExpense;
  final int userId;
  AddCategoryUI(this.isExpense, this.userId);

  @override
  Widget build(BuildContext context) {
    return BaseUI<AddCategoryModel>(
      onModelReady: (model) => model.init(isExpense, userId),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
            backgroundColor: secondary,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isExpense
                    ? Text("Add Expense Category")
                    : Text("Add Income Category"),
                InkWell(
                  child: Icon(Icons.save, color: Colors.grey[800], size: 27),
                  onTap: () async {
                    await model.addCategory(context);
                  },
                ),
              ],
            )),
        body: getBody(context, model),
      ),
    );
  }

  Widget getBody(context, model) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: model.isSelected.color,
                child: Icon(
                  model.isSelected.icon,
                  color: white,
                  size: 25,
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 30,
                controller: model.categoryNameController,
                decoration: InputDecoration(
                  labelText: "Name",
                ),
              ),
            )),
          ],
        ),
        Expanded(
          child: ListView(children: [
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 1.2,
                mainAxisSpacing: 1.2,
              ),
              itemCount: model.iconList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => model.selectIcon(model.iconList[index]),
                  child: model.isSelected != model.iconList[index]
                      ? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.grey[100],
                            child: Icon(
                              model.iconList[index].icon,
                              color: primary,
                              size: 25,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: model.iconList[index].color,
                            child: Icon(
                              model.iconList[index].icon,
                              color: white,
                              size: 25,
                            ),
                          ),
                        ),
                );
              },
            )
          ]),
        )
      ],
    );
  }
}
