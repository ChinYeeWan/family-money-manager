import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/color.dart';
import '../locator.dart';
import '../models/member.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/user_firestore_service_rest.dart';
import 'base_model.dart';

class AddMemberModel extends BaseModel {
  final AuthService _authService = locator<AuthService>();
  final UserFirestoreServiceRest _userServiceRest =
      locator<UserFirestoreServiceRest>();

  User mainUser;
  List<Member> members;

  void init(u, m) {
    mainUser = u;
    members = m;
  }

  final form = GlobalKey<FormState>();
  bool userExist;
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
    await checkEmailExist(email);
    final isValid = form.currentState.validate();
    if (!isValid) {
      setState(ViewState.Idle);
      notifyListeners();
      return;
    }

    User user = new User(
        username: username,
        email: email,
        password: password,
        type: 'member',
        members: null);

    final User add = await _authService.signUp(user);
    print("---------------------Add member to main user");
    print(add);
    Member member = new Member(id: add.id, username: add.username);

    print(member);
    members.add(member);
    print('Members');
    print(members);

    final addMember = await _userServiceRest.addMember(mainUser.id, member);

    if (addMember != null) {
      Fluttertoast.showToast(
          msg:
              "Member is added! \n Please press the ⋮ to copy info and send to your member",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 20,
          backgroundColor: primary,
          gravity: ToastGravity.BOTTOM);
      setState(ViewState.Idle);
      notifyListeners();
    }
    //Move back to manage category
    Navigator.of(context).pop(members);
  }

  changePasswordVisibility() {
    isObscure = !isObscure;
    notifyListeners();
  }

  Future<void> checkEmailExist(email) async {
    final user = await _userServiceRest.checkEmailExist(email: email);
    userExist = user;
  }
}
