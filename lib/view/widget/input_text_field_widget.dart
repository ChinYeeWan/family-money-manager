import 'package:flutter/material.dart';

import '../../constants/color.dart';

class InputTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String text;
  final Function validator;
  InputTextFieldWidget({this.controller, this.icon, this.text, this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextFormField(
        controller: controller,
        cursorColor: primary,
        validator: validator,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.yellow[700],
            size: 40,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.yellow[700]),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: primary),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: red),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: red),
          ),
          labelText: text,
          labelStyle: TextStyle(
            color: primary,
          ),
        ),
      ),
    );
  }
}
