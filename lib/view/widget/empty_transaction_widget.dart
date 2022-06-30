import 'package:flutter/material.dart';

import '../../constants/ui_helper.dart';

class EmptyTransactionsWidget extends StatelessWidget {
  const EmptyTransactionsWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UIHelper.verticalSpaceLarge(),
        Image.asset(
          'assets/no-money.png',
          width: 120,
          height: 120,
        ),
        UIHelper.verticalSpaceMedium(),
        Text(
          'No transactions\nTap + to add one.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      ],
    );
  }
}
