import 'package:flutter/material.dart';

import '../../constants/color.dart';

class CheckAccountWidget extends StatelessWidget {
  const CheckAccountWidget({
    Key key,
    @required this.login,
    @required this.press,
  }) : super(key: key);

  final bool login;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don’t have an Account ? " : "Already have an Account ? ",
          style: TextStyle(color: Colors.grey[700]),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Login",
            style: TextStyle(
              color: primary,
              fontWeight: FontWeight.w900,
            ),
          ),
        )
      ],
    );
  }
}
