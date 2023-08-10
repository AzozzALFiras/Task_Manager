import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const/style_constant.dart';

// ignore: must_be_immutable
class CustomButtom extends StatelessWidget {
  CustomButtom({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = appStyle.primaryColor,
    this.height = 50,
    this.width = 50,
    this.borderRadius = 8,
  }) : super(key: key);

  final String text;
  final Color color;
  final double height;
  final double width;
  final double borderRadius;
  var onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius), color: color),
        child: Center(
            child: Text(
          text,
          style: appStyle.normalTextStyle(),
        )),
      ),
    );
  }
}
