import 'package:flutter/material.dart';

import '../../constants/text_style.dart';

class IncomeExpenseCard extends StatelessWidget {
  const IncomeExpenseCard({
    Key key,
    @required this.color,
    @required this.size,
    @required this.text,
    @required this.isSelected,
    @required this.onTap,
  }) : super(key: key);

  final Color color;
  final Size size;
  final String text;
  final bool isSelected;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: isSelected ? color : null,
        elevation: 4,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          width: (size.width / 2) - 30,
          child: Column(
            children: <Widget>[
              Text(text, style: summaryTextStyle),
            ],
          ),
        ),
      ),
    );
  }
}
