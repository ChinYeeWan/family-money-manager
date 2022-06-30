import 'package:flutter/material.dart';
import 'package:overlay_container/overlay_container.dart';

import '../../constants/color.dart';
import '../../constants/month_list.dart';

class PickMonthOverlay extends StatelessWidget {
  final model;
  final BuildContext context;
  final bool showOrHide;

  const PickMonthOverlay({Key key, this.model, this.context, this.showOrHide})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlayContainer(
        show: showOrHide,
        // Let's position this overlay to the right of the button.
        position: OverlayContainerPosition(
          // Left position.
          0,
          // Bottom position.
          0,
        ),
        // The content inside the overlay.
        child: Container(
          height: 200,
          padding: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: grey,
                blurRadius: 3,
                spreadRadius: 10,
              )
            ],
          ),
          child: buildGridView(model),
        ));
  }

  Widget buildGridView(model) {
    return GridView.count(
      crossAxisCount: 6,

      // Generate 100 widgets that display their index in the List.
      children: months.map((month) {
        return InkWell(
          onTap: () {
            model.monthClicked(month);
          },
          child: Center(
            child: Text(
              month,
              style: TextStyle(
                color: model.getColor(month),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
