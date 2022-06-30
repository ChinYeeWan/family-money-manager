import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/color.dart';
import '../constants/text_style.dart';
import '../constants/ui_helper.dart';
import '../models/user.dart';
import '../viewmodels/add_model.dart';
import '../viewmodels/base_model.dart';
import 'base_UI.dart';
import 'widget/income_expense_card_widget.dart';

class AddUI extends StatelessWidget {
  final int selectedType;
  final User user;
  AddUI({this.selectedType, this.user});
  @override
  Widget build(BuildContext context) {
    return BaseUI<AddModel>(
      onModelReady: (model) => model.init(selectedType, user),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Text('Add '),
                  model.type == 'income' ? Text('Income') : Text('Expense'),
                ],
              ),
              InkWell(
                child: Icon(Icons.save, color: Colors.grey[800], size: 27),
                onTap: () async {
                  await model.addTransaction(context);
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
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            buildIncomeExpenseCard(size, model),
            UIHelper.verticalSpaceMedium(),
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
                    await model.chooseCategory(context, model.type);
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
            model.isExpense
                ? model.state == ViewState.Busy
                    ? Center(
                        child: Column(
                        children: [
                          CircularProgressIndicator(),
                          UIHelper.verticalSpaceSmall(),
                          Text("Scanning receipt ..."),
                        ],
                      ))
                    : Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: primary,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            textStyle: TextStyle(fontSize: 16, color: black),
                          ),
                          child: Text('Scan a Receipt'),
                          onPressed: () => chooseChoice(context, model),
                        ),
                      )
                : Container(),
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
                        child: Image.network(model.imagePath,
                            height: 700, fit: BoxFit.cover),
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

  chooseChoice(context, model) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(children: [
            SimpleDialogOption(
                onPressed: () {
                  model.pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                child: ListTile(
                    leading: Icon(Icons.camera), title: Text("Camera"))),
            Divider(),
            SimpleDialogOption(
              onPressed: () {
                model.pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              child: ListTile(
                  leading: Icon(Icons.image), title: Text("Pick from Gallary")),
            ),
          ]);
        });
  }

  Padding buildIncomeExpenseCard(Size size, AddModel model) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IncomeExpenseCard(
            color: primary,
            size: size,
            text: 'Income',
            isSelected: !model.isExpense,
            onTap: () => model.changeType(),
          ),
          IncomeExpenseCard(
            color: primary,
            size: size,
            text: 'Expense',
            isSelected: model.isExpense,
            onTap: () => model.changeType(),
          ),
        ],
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
      inputFormatters: isNumeric
          ? [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ]
          : null,
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
