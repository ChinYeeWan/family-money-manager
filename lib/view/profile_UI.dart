import 'package:flutter/material.dart';
import '../constants/color.dart';
import '../constants/text_style.dart';
import '../constants/ui_helper.dart';
import '../models/user.dart';
import '../viewmodels/main_model.dart';
import 'widget/profile_menu_widget.dart';
import 'widget/profile_picture_widget.dart';

class ProfileUI extends StatelessWidget {
  final MainModel model;
  ProfileUI({this.model});
  @override
  Widget build(BuildContext context) {
    User user = model.user;
    return Scaffold(
      appBar:
          AppBar(backgroundColor: primary, title: Text("Profile"), actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
              onTap: () => showLogoutDialog(context),
              child: Icon(Icons.logout, color: Colors.grey[800], size: 27)),
        )
      ]),
      body: getBody(context, user),
    );
  }

  Widget getBody(context, user) {
    return Column(
      children: [
        UIHelper.verticalSpaceMedium(),
        ProfilePicture(),
        UIHelper.verticalSpaceMedium(),
        Center(child: Text(user.username, style: profileStyle)),
        UIHelper.verticalSpaceMedium(),
        ProfileMenu(
            text: "Catogory",
            icon: Icons.grid_view_rounded,
            press: () => Navigator.pushNamed(context, "manageCategory",
                arguments: model.user)),
        model.user.type == 'head'
            ? ProfileMenu(
                text: "Members",
                icon: Icons.people_alt_rounded,
                press: () => Navigator.pushNamed(context, "manageMembers",
                    arguments: model.user))
            : Container()
      ],
    );
  }

  showLogoutDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Logout"),
            content: Text("Are you sure do you want to logout?"),
            actions: <Widget>[
              TextButton(
                child: Text("Logout", style: TextStyle(color: primary)),
                onPressed: () => model.logout(context),
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
