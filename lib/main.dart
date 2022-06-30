import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'locator.dart';
import 'router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  setupLocator();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      initialRoute: '/',
      onGenerateRoute: RouterChange.generateRoute,
    ),
  );
}
