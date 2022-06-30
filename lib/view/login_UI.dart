import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../constants/ui_helper.dart';
import '../viewmodels/base_model.dart';
import '../viewmodels/login_model.dart';
import 'base_UI.dart';
import 'widget/check_account_widget.dart';
import 'widget/input_text_field_widget.dart';
import 'widget/password_text_field_widget.dart';

class LoginUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseUI<LoginModel>(
      onModelReady: (model) => model.init(context),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.yellow[100],
        body: SingleChildScrollView(
          child: Form(
            key: model.form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                UIHelper.verticalSpaceLarge(),
                Text(
                  "Welcome to Family Money Manager",
                  style: TextStyle(color: Colors.yellow[700]),
                ),
                UIHelper.verticalSpaceMedium(),
                Image(
                  image: AssetImage("assets/logo.png"),
                  height: size.height * 0.30,
                ),
                UIHelper.verticalSpaceLarge(),
                InputTextFieldWidget(
                    controller: model.emailController,
                    text: 'Email',
                    icon: Icons.mail,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Please fill in the email';
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email)) {
                        return 'Please insert valid email';
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
                              await model.login(context);
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
                              "Login",
                              style: TextStyle(
                                color: white,
                              ),
                            ),
                          ),
                        ),
                      ),
                UIHelper.verticalSpaceMedium(),
                CheckAccountWidget(
                    login: true,
                    press: () {
                      Navigator.pushNamed(context, "register");
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
