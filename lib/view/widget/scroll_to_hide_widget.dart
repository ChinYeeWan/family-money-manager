import 'package:flutter/material.dart';

import '../../viewmodels/main_model.dart';

class ScrollToHide extends StatelessWidget {
  final MainModel model;
  final Widget child;
  final ScrollController controller;
  final Duration duration;

  const ScrollToHide({
    this.model,
    this.child,
    this.controller,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      height: model.show ? 56 : 0,
      child: Wrap(children: [child]),
    );
  }
}
