import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../constants/ui_helper.dart';
import '../models/member.dart';
import '../models/user.dart';
import '../viewmodels/add_member_model.dart';
import '../viewmodels/base_model.dart';
import 'base_UI.dart';
import 'widget/input_text_field_widget.dart';
import 'widget/password_text_field_widget.dart';

class AddMemberUI extends StatelessWidget {
  final User user;
  final List<Member> members;
  AddMemberUI({this.user, this.members});

  get secondary => null;
  @override
  Widget build(BuildContext context) {
    return BaseUI<AddMemberModel>(
        onModelReady: (model) => model.init(user, members),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: secondary,
                title: Text('Create Member'),
              ),
              body: getBody(context, model),
            ));
  }

  Widget getBody(BuildContext context, model) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Form(
        key: model.form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            UIHelper.verticalSpaceLarge(),
            Icon(Icons.person_add, color: primary, size: 200),
            InputTextFieldWidget(
                controller: model.usernameController,
                text: 'Username',
                icon: Icons.person,
                validator: (username) {
                  if (username == null || username.isEmpty) {
                    return 'Please fill in the username';
                  }
                  if (username.length < 5) {
                    return 'Username must at least 5 characters long';
                  }
                  if (!RegExp(r"^[a-zA-Z0-9_ ]+$").hasMatch(username)) {
                    return 'Please avoid using special character, eg: !&*{}()';
                  }
                  return null;
                }),
            InputTextFieldWidget(
                controller: model.emailController,
                text: 'Email',
                icon: Icons.mail,
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return 'Please fill in the email';
                  }

                  if (!email.contains('@')) {
                    return 'Please insert valid email';
                  }
                  if (model.userExist != null) {
                    return 'User with this email already exist!';
                  }
                  return null;
                }),
            PasswordTextFieldWidget(
                controller: model.passwordController,
                text: 'Password',
                icon: Icons.lock,
                isObscure: model.isObscure,
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return 'Please fill in the password';
                  }
                  if (password.length < 8) {
                    return 'Password must at least 8 characters long';
                  }
                  return null;
                },
                changeVisibility: () => model.changePasswordVisibility()),
            UIHelper.verticalSpaceMedium(),
            model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    width: size.width * 0.8,
                    height: size.height * 0.055,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: ElevatedButton(
                        onPressed: () async {
                          await model.createNewUser(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            // vertical: 20,
                          ),
                          textStyle: TextStyle(
                            color: grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        child: Text(
                          "Create New Member",
                          style: TextStyle(
                            color: white,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
