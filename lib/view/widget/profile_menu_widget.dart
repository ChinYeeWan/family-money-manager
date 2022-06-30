import 'package:flutter/material.dart';

import '../../constants/text_style.dart';
import '../../constants/ui_helper.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          primary: Colors.yellow[200],
          onPrimary: Colors.yellow[100],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey[800],
              size: 30,
            ),
            UIHelper.horizontalSpaceMedium(),
            Expanded(child: Text(text, style: profileStyle)),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[800],
            ),
          ],
        ),
        onPressed: press,
      ),
    );
  }
}
