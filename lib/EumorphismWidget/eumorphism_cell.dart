import 'package:flutter/material.dart';

class EumorphismCell extends StatelessWidget {
  final Color softHighlightColor;
  final Color softShadowColor;
  final Color backgroundColor;

  final Widget child;
  const EumorphismCell(
      {Key key,
      this.softHighlightColor,
      this.softShadowColor,
      this.backgroundColor,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
              color: softHighlightColor,
              offset: Offset(-10, -10),
              spreadRadius: 0,
              blurRadius: 10),
          BoxShadow(
              color: softShadowColor,
              offset: Offset(10, 10),
              spreadRadius: 0,
              blurRadius: 10)
        ],
      ),
      child: child,
    );
  }
}
