import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class authTextFiled extends StatelessWidget {
  const authTextFiled({
    Key? key,
    required this.myFocusNode,
    required this.controller,
    required this.label,
    this.hint = "",
    required this.isObscureText,
    required this.errorText,
    this.autofocus = false,
  }) : super(key: key);

  final FocusNode myFocusNode;
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isObscureText;
  final bool autofocus;

  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      //textAlign: TextAlign.end,
      autofocus: autofocus,
      obscureText: isObscureText,
      focusNode: myFocusNode,
      controller: controller,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        errorText: errorText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        fillColor: Colors.grey.withOpacity(0.5),
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(
            color: myFocusNode.hasFocus ? Color(0xff363062) : Colors.black45,
            fontSize: 16),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff363062), width: 1.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}

class authTextarea extends StatelessWidget {
  const authTextarea({
    Key? key,
    required this.myFocusNode,
    required this.controller,
    required this.label,
    this.hint = "",
    required this.isObscureText,
    required this.errorText,
    this.autofocus = false,
  }) : super(key: key);

  final FocusNode myFocusNode;
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isObscureText;
  final bool autofocus;

  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 5,
      autofocus: autofocus,
      obscureText: isObscureText,
      focusNode: myFocusNode,
      controller: controller,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        errorText: errorText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        fillColor: Colors.grey.withOpacity(0.5),
        labelText: label,

        // label: Align(
        //   alignment: Alignment.centerLeft,
        //   child: SizedBox(
        //     child: Text(label),
        //   ),
        // ),
        hintText: hint,
        labelStyle: TextStyle(
            color: myFocusNode.hasFocus ? Color(0xff363062) : Colors.black45,
            fontSize: 16),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff363062), width: 1.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
