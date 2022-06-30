import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/color.dart';
import '../constants/text_style.dart';
import '../constants/ui_helper.dart';
import '../models/transaction.dart';
import '../viewmodels/edit_model.dart';
import 'base_UI.dart';

class EditUI extends StatelessWidget {
  final Transaction transaction;
  EditUI({this.transaction});
  @override
  Widget build(BuildContext context) {
    return BaseUI<EditModel>(
      onModelReady: (model) => model.init(transaction),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Edit'),
              InkWell(
                child: Icon(Icons.save, color: Colors.grey[800], size: 27),
                onTap: () async {
                  await model.editTransaction(context, transaction);
                },
              ),
            ],
          ),
        ),
        body: getBody(context, model),
      ),
    );
  }

  Widget getBody(BuildContext context, model) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(model.category.name, style: detailItemStyle),
                  leading: CircleAvatar(
                    backgroundColor: Color(model.category.color),
                    child: Icon(
                      IconDataSolid(int.parse(model.category.icon)),
                      color: white,
                      size: 20,
                    ),
                  ),
                  onTap: () async {
                    await model.chooseCategory(context, transaction.type);
                  },
                ),
              ),
            ),
            UIHelper.verticalSpaceMedium(),
            buildTextField(
              model.memoController,
              'Memo',
              "Enter a memo for your transaction",
              Icons.edit,
              false,
            ),
            UIHelper.verticalSpaceMedium(),
            buildTextField(
                model.amountController,
                'Amount',
                "Enter a the amount for the transaction",
                Icons.attach_money,
                true),
            UIHelper.verticalSpaceMedium(),
            buildDateField(model, context),
            UIHelper.verticalSpaceMedium(),
            UIHelper.verticalSpaceMedium(),
            model.imagePath == null
                ? Container()
                : Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                          child: Card(
                        elevation: 4,
                        child: Image.network(
                          model.imagePath,
                          height: 700,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace stackTrace) {
                            return Container(
                              child: Text(
                                'Could not load Receipt',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            );
                          },
                        ),
                      )),
                      Positioned(
                        bottom: -30,
                        child: FloatingActionButton(
                          backgroundColor: Colors.grey[300],
                          child: const Icon(Icons.delete,
                              size: 27, color: Colors.white),
                          onPressed: () => model.removeImage(),
                        ),
                      ),
                    ],
                  ),
            Container(height: 40),
          ],
        ),
      ),
    );
  }

  TextFormField buildDateField(model, BuildContext context) {
    return TextFormField(
      readOnly: true,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        fillColor: secondary,
        filled: true,
        border: OutlineInputBorder(),
        icon: Icon(
          Icons.calendar_month_rounded,
          color: Colors.black,
        ),
        suffixIcon: InkWell(
          onTap: () async {
            await model.selectDate(context);
          },
          child: Icon(
            Icons.edit,
            color: Colors.black,
          ),
        ),
        hintText: model.getSelectedDate(),
        hintStyle: TextStyle(
          color: Color(0xFFFF000000),
        ),
      ),
    );
  }

  TextFormField buildTextField(TextEditingController controller, String text,
      String helperText, IconData icon, isNumeric) {
    return TextFormField(
      cursorColor: Colors.black,
      maxLength: isNumeric ? 10 : 40,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        labelText: text,
        suffixIcon: InkWell(
          onTap: () {
            controller.clear();
          },
          child: Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(
          color: Color(0xFFFF000000),
        ),
        helperText: helperText,
      ),
    );
  }
}
