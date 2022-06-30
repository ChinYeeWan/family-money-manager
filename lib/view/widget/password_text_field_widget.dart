import 'package:flutter/material.dart';

import '../../constants/color.dart';

class PasswordTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String text;
  final bool isObscure;
  final Function validator;
  final Function changeVisibility;
  PasswordTextFieldWidget(
      {this.controller,
      this.icon,
      this.text,
      this.isObscure,
      this.validator,
      this.changeVisibility});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextFormField(
        obscureText: isObscure,
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
          suffixIcon: InkWell(
              onTap: changeVisibility,
              child: isObscure
                  ? Icon(
                      Icons.visibility,
                      color: primary,
                    )
                  : Icon(
                      Icons.visibility_off,
                      color: primary,
                    )),
        ),
      ),
    );
  }
}
