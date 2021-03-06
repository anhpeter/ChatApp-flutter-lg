import 'package:flutter/material.dart';

class StateFullWrapperWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onInit;
  const StateFullWrapperWidget(
      {required this.child, required this.onInit, Key? key})
      : super(key: key);

  @override
  _StateFullWrapperWidgetState createState() => _StateFullWrapperWidgetState();
}

class _StateFullWrapperWidgetState extends State<StateFullWrapperWidget> {
  @override
  void initState() {
    if (widget.onInit != null) widget.onInit!();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
