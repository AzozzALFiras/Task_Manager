import 'package:flutter/material.dart';

RoundedRectangleBorder ButtonBorder(){
  return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10))
  );
}
RoundedRectangleBorder ButtonBorder2(){
  return  RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8)
  );
}