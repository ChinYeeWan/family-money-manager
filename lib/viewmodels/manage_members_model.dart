import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/locator.dart';

import '../constants/color.dart';
import '../models/member.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/user_firestore_service_rest.dart';
import 'base_model.dart';

class ManageMembersModel extends BaseModel {
  ScrollController scrollController = new ScrollController();
  final AuthService _authService = locator<AuthService>();

  final UserFirestoreServiceRest _userFirestoreService =
      locator<UserFirestoreServiceRest>();

  User user;
  List<Member> members;

  void init(u) {
    setState(ViewState.Busy);
    notifyListeners();
    user = u;
    print(user);
    if (user.members == null) {
      members = [];
    } else {
      members = user.members;
    }

    setState(ViewState.Idle);
    notifyListeners();
  }

  void loadMembers(updatedMembers) {
    setState(ViewState.Busy);
    notifyListeners();
    members = updatedMembers;
    setState(ViewState.Idle);
    notifyListeners();
  }

  void addMember(context) async {
    final addedMembers = await Navigator.pushNamed(context, "addMember",
        arguments: [user, members]);
    if (addedMembers != null) {
      loadMembers(addedMembers);
      notifyListeners();
    }
  }

  void selectMenu(context, int value, int memberIndex) {
    switch (value) {
      case 1:
        copyMemberInfo(memberIndex);
        break;
      case 2:
        //
        showDeleteDialog(context, memberIndex);
        break;
    }
  }

  void copyMemberInfo(index) async {
    Member member = members[index];
    final User user = await _userFirestoreService.getUser(member.id);

    Clipboard.setData(ClipboardData(
        text: "Email: ${user.email} \nPassword: ${user.password}"));
    Fluttertoast.showToast(
        msg: "Email and password are copied to clipboard",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 3,
        backgroundColor: primary,
        gravity: ToastGravity.BOTTOM);
    notifyListeners();
  }

  showDeleteDialog(BuildContext context, memberIndex) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete"),
            content: Text("Are you sure do you want to delete this member?"),
            actions: <Widget>[
              TextButton(
                child: Text("Delete", style: TextStyle(color: primary)),
                onPressed: () async {
                  await deleteMember(memberIndex);
                  // hide dialog
                  Navigator.of(context).pop();
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

  Future<void> deleteMember(index) async {
    Member deleteMember = members[index];
    members.removeAt(index);

    await _authService.deleteMember(deleteMember.id);
    await _userFirestoreService.updateMember(user.id, members);

    loadMembers(members);
  }
}
