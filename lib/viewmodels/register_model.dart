import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../locator.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import 'base_model.dart';

class RegisterModel extends BaseModel {
  // final UserServiceRest _userServiceRest = locator<UserServiceRest>();
  final AuthService _authService = locator<AuthService>();
  final form = GlobalKey<FormState>();
  User userExist;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = true;

  Future<void> createNewUser(context) async {
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    setState(ViewState.Busy);
    notifyListeners();

    //Check whether is empty and email format
    // await checkEmailExist(email);
    // final isValid = form.currentState.validate();
    // if (!isValid) {
    //   setState(ViewState.Idle);
    //   notifyListeners();
    //   return;
    // }

    User user = new User(
        username: username,
        email: email,
        password: password,
        type: 'head',
        members: null);

    final add = await _authService.signUp(user);
    print(add);
    if (add != null) {
      showSuccessDialog(context);
      setState(ViewState.Idle);
      notifyListeners();
    }
    //Move to login
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pop(true);
      Navigator.of(context).pop(true);
    });
  }

  changePasswordVisibility() {
    isObscure = !isObscure;
    notifyListeners();
  }

  // Future<void> checkEmailExist(email) async {
  //   final User user = await _userServiceRest.checkEmailExist(email: email);
  //   userExist = user;
  // }

  showSuccessDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
                child: Icon(Icons.account_circle_rounded,
                    size: 50, color: primary)),
            content: Container(
              height: 90.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "User is created! Please login...",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )
                ],
              ),
            ),
          );
        });
  }
}
