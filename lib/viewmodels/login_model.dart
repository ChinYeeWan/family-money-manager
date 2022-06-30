import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../locator.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import 'base_model.dart';

class LoginModel extends BaseModel {
  // final UserServiceRest _userServiceRest = locator<UserServiceRest>();
  final AuthService _authService = locator<AuthService>();
  final form = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  User user;
  bool isObscure = true;

  Future<void> login(context) async {
    String email = emailController.text;
    String password = passwordController.text;

    setState(ViewState.Busy);
    notifyListeners();

    //Check whether is empty and email format
    final isValid = form.currentState.validate();
    if (!isValid) {
      setState(ViewState.Idle);
      notifyListeners();
      return;
    }

    //Check database got user or not
    final User user = await _authService.login(email, password);
    if (user == null) {
      showInvalidDialog(context);
      setState(ViewState.Idle);
      notifyListeners();
      return;
    }
    form.currentState.save();
    Navigator.of(context).pushReplacementNamed('home', arguments: user);
  }

  showInvalidDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Icon(Icons.warning, size: 50, color: red)),
            content: Text(
              "Invalid email and password!",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  changePasswordVisibility() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
