import 'package:flutter/material.dart';

import '../../constants/ui_helper.dart';

class NoMemberFoundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          UIHelper.verticalSpaceLarge(),
          Image.asset(
            'assets/add-user.png',
            width: 200,
            height: 200,
          ),
          UIHelper.verticalSpaceMedium(),
          Text(
            "No members were found! \nPress '+ Add Member' to create one",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
