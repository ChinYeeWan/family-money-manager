import 'package:flutter/material.dart';

import '../../constants/ui_helper.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UIHelper.verticalSpaceLarge(),
        Image.asset(
          'assets/data-not-found.png',
          width: 200,
          height: 200,
        ),
        UIHelper.verticalSpaceMedium(),
        Text(
          'No Data Found!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      ],
    );
  }
}
