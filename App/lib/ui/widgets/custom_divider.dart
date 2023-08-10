import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const/style_constant.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
    this.height = 1,
    this.color = appStyle.grayColor2,
    this.width = 100,
  }) : super(key: key);
  final double height;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: color,
    );
  }
}

// divider with radius
class CustomDivider2 extends StatelessWidget {
  const CustomDivider2({
    Key? key,
    this.height = 1,
    this.color = appStyle.grayColor2,
    this.width = 100,
  }) : super(key: key);
  final double height;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
      height: height,
      width: width,
    );
  }
}
class CustomDivider3 extends StatelessWidget {
  const CustomDivider3({
    Key? key,
    this.height = 1,
    this.color = appStyle.grayColor2,
    this.width = 100,
  }) : super(key: key);
  final double height;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      height: height,
      width: width,
    );
  }
}
