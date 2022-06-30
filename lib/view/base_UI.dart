import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';
import '../viewmodels/base_model.dart';

class BaseUI<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;

  BaseUI({this.builder, this.onModelReady});

  @override
  _BaseUIState<T> createState() => _BaseUIState<T>();
}

class _BaseUIState<T extends BaseModel> extends State<BaseUI<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        create: (context) => model,
        child: Consumer<T>(builder: widget.builder));
  }
}
