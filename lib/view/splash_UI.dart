import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import '../constants/color.dart';
import 'login_UI.dart';

class SplashUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary, body: SafeArea(child: buildSpashScreen()));
  }

  buildSpashScreen() {
    return SplashScreen(
        seconds: 2,
        navigateAfterSeconds: LoginUI(),
        title: new Text(
          'Family Money Manager',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),
        ),
        image: new Image.asset(
          'assets/logo.png',
          height: 150,
          width: 150,
        ),
        backgroundColor: primary,
        loadingText: Text(
          'A place for all of your expenses.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        photoSize: 100.0,
        loaderColor: Colors.orange);
  }
}
