import 'package:flutter/material.dart';

import '../../constants/text_style.dart';
import '../../models/transaction.dart';

class DetailsTable extends StatelessWidget {
  const DetailsTable({
    Key key,
    @required this.transaction,
  }) : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    print(transaction.imagePath);
    return Table(
      columnWidths: {1: FixedColumnWidth(250)},
      children: [
        TableRow(
          children: [
            SizedBox(
              height: 50,
              child: Text(
                "Category",
                style: detailNameStyle,
              ),
            ),
            Text(
              transaction.type,
              textAlign: TextAlign.justify,
              style: detailItemStyle,
            ),
          ],
        ),
        TableRow(
          children: [
            SizedBox(
              height: 50,
              child: Text(
                "Amount",
                style: detailNameStyle,
              ),
            ),
            Text(
              transaction.amount.toStringAsFixed(2),
              textAlign: TextAlign.justify,
              style: detailItemStyle,
            ),
          ],
        ),
        TableRow(
          children: [
            SizedBox(
              height: 50,
              child: Text(
                "Date",
                style: detailNameStyle,
              ),
            ),
            Text(
              "${transaction.day} ${transaction.month} ${transaction.year}",
              textAlign: TextAlign.justify,
              style: detailItemStyle,
            ),
          ],
        ),
        TableRow(
          children: [
            SizedBox(
              height: 50,
              child: Text(
                "Memo",
                style: detailNameStyle,
              ),
            ),
            Text(
              transaction.memo,
              style: detailItemStyle,
            ),
          ],
        ),
        transaction.imagePath == null
            ? TableRow(children: [Container(), Container()])
            : TableRow(
                children: [
                  SizedBox(
                    height: 50,
                    child: Text(
                      "Receipt",
                      style: detailNameStyle,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.network(
                      transaction.imagePath,
                      height: 120,
                      fit: BoxFit.fitHeight,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace stackTrace) {
                        return Container(
                          height: 120,
                          child: Text(
                            'Could not load Receipt',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
      ],
    );
  }
}
