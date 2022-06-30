import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/color.dart';
import '../../constants/ui_helper.dart';
import '../../models/transaction.dart';
import '../../viewmodels/detail_model.dart';
import 'detail_table_widget.dart';

class DetailsCard extends StatelessWidget {
  final DetailModel model;
  final Transaction transaction;
  DetailsCard({this.transaction, this.model});

  @override
  Widget build(BuildContext context) {
    print(transaction);
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(transaction.category.color),
                  child: Icon(
                      IconDataSolid(int.parse(transaction.category.icon)),
                      color: white)),
              title: Text(
                "\t\t\t" + "${transaction.category.name}",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[800]),
              ),
            ),
            UIHelper.verticalSpaceSmall(),
            Divider(
              thickness: 1,
            ),
            UIHelper.verticalSpaceSmall(),
            DetailsTable(transaction: transaction),
          ],
        ),
      ),
    );
  }
}
