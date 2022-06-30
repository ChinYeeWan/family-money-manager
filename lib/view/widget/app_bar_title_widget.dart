import 'package:flutter/material.dart';

import '../../constants/color.dart';

class AppBarTitle extends StatelessWidget implements PreferredSizeWidget {
  final model;
  AppBarTitle(this.model);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primary,
      title: InkWell(
        onTap: () {
          model.titleClicked();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.appBarTitle,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              model.isCollabsed
                  ? Icon(
                      Icons.arrow_drop_down,
                    )
                  : Icon(
                      Icons.arrow_drop_up,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  static final _appBar = AppBar();
  @override
  Size get preferredSize => _appBar.preferredSize;
}
