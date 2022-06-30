import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../models/transaction.dart';
import '../viewmodels/detail_model.dart';
import 'base_UI.dart';
import 'widget/detail_card_widget.dart';

class DetailUI extends StatelessWidget {
  final Transaction transaction;
  DetailUI(this.transaction);

  @override
  Widget build(BuildContext context) {
    return BaseUI<DetailModel>(
      onModelReady: (model) => model.init(transaction),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          leading: InkWell(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Details'),
              InkWell(
                child: Icon(Icons.delete, color: Colors.grey[800], size: 27),
                onTap: () {
                  showDeleteDialog(context, model);
                },
              ),
            ],
          ),
        ),
        body: getBody(context, model.height, model),
      ),
    );
  }

  Widget getBody(context, height, model) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: height,
                padding: const EdgeInsets.all(10.0),
                child: DetailsCard(
                  transaction: model.transaction,
                ),
              ),
              Positioned(
                right: 30,
                top: height - 40.0,
                child: FloatingActionButton(
                  child: Icon(Icons.edit, color: white),
                  backgroundColor: primary,
                  onPressed: () async {
                    await model.editTransaction(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  showDeleteDialog(BuildContext context, DetailModel model) async {
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
                  await model.deleteTransaction(transaction);
                  // hide dialog
                  Navigator.of(context).pop();
                  // exit detailsscreen
                  Navigator.of(context).pop(true);
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
