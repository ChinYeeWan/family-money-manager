import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/color.dart';
import '../constants/ui_helper.dart';
import '../viewmodels/base_model.dart';
import '../viewmodels/choose_category_model.dart';
import 'base_UI.dart';

class ChooseCategoryUI extends StatelessWidget {
  final String selectedType;
  final int userId;
  ChooseCategoryUI(this.selectedType, this.userId);
  @override
  Widget build(BuildContext context) {
    return BaseUI<ChooseCategoryModel>(
      onModelReady: (model) => model.init(selectedType, userId),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: secondary,
          title: Text('Select Category'),
        ),
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : getBody(context, model),
      ),
    );
  }
}

Widget getBody(BuildContext context, model) {
  return SafeArea(
    child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1.2,
          mainAxisSpacing: 1.2,
        ),
        itemCount: model.categories.length,
        itemBuilder: (context, index) {
          return Card(
              elevation: 4,
              child: InkWell(
                onTap: () => Navigator.pop(context, model.categories[index]),
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(model.categories[index].name),
                      UIHelper.verticalSpaceSmall(),
                      CircleAvatar(
                        backgroundColor:
                            Color(model.categories[index].color).withOpacity(1),
                        radius: 30,
                        child: Center(
                          child: Icon(
                            IconDataSolid(
                                int.parse(model.categories[index].icon)),
                            size: 25,
                            color: white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
        }),
  );
}
