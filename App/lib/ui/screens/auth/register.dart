// ignore_for_file: use_key_in_widget_constructors, prefer_final_fields, unused_element

import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../const/style_constant.dart';
import '../../../data/repository/auth.dart';
import '../../widgets/buttonborder.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/cusuom_buttom.dart';
import '../../widgets/logIn_text_filed.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final FocusNode focusNodeusername = FocusNode();
  final FocusNode focusNodepassword = FocusNode();

  bool _validate = false;

  @override
  void initState() {
    focusNodeusername.addListener(() {
      setState(() {});
    });

    focusNodepassword.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  var _isLoading = false;

  bool validateField(String value) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  validateValue() {
    _usernameController.value.text.isEmpty ||
            _passwordController.value.text.isEmpty
        ? _validate = true
        : _validate = false;
    final value = _usernameController.value.text.isNotEmpty &&
        _passwordController.value.text.isNotEmpty;

    if (value) {
      registerUser(_usernameController.value.text,
          _passwordController.value.text, context);
    }
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: appStyle.primaryColor,
            colorScheme: ColorScheme.light(primary: appStyle.primaryColor),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStyle.primaryBgColor,
      body: Container(
        child: SingleChildScrollView(
          child: IgnorePointer(
            ignoring: _isLoading,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .07),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    gaps(.1),
                    const Text(
                      'Task Manager',
                      style: TextStyle(
                          color: appStyle.primaryColor,
                          fontSize: appStyle.xxxLargeTitleFontSize,
                          fontWeight: FontWeight.w700),
                    ),
                    gaps(.1),
                    Text(
                      'Create an account',
                      style: appStyle.boldTextStyle(
                          fontSize: appStyle.xLargeTitleFontSize,
                          color: Colors.black),
                    ),
                    gaps(.05),

                    authTextFiled(
                      controller: _usernameController,
                      label: 'Username',
                      hint: 'Enter username',
                      isObscureText: false,
                      myFocusNode: focusNodeusername,
                      errorText: _validate ? "Empty field" : null,
                    ),
                    gaps(.05),
                    authTextFiled(
                      controller: _passwordController,
                      label: 'Password',
                      hint: 'Enter password',
                      isObscureText: true,
                      myFocusNode: focusNodepassword,
                      errorText: _validate ? "Empty field" : null,
                    ),

                    gaps(.1),
                    CustomButtom(
                      text: 'Sign Up',
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        validateValue();
                      },
                      color: appStyle.primaryColor,
                      height: MediaQuery.of(context).size.width * .15,
                      width: MediaQuery.of(context).size.width,
                      borderRadius: 8,
                    ),
                    // button(),
                    gaps(.2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomDivider(
                          width: MediaQuery.of(context).size.width * .14,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.black),
                                'You already have an account'),
                          ),
                        ),
                        CustomDivider(
                          width: MediaQuery.of(context).size.width * .14,
                        ),
                      ],
                    ),
                    gaps(.1),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget gaps(double value) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * value,
    );
  }

  Widget textHeading(String value) {
    return Text(
        textAlign: TextAlign.left,
        style: appStyle.normalTextStyle(fontSize: 16, color: Colors.black),
        value);
  }

  Widget button() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xff036eb7),
            padding: EdgeInsets.zero,
            shape: ButtonBorder(),
          ),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            validateValue();
          },
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'login',
              style: TextStyle(color: Colors.white),
            ),
          )),
    );
  }
}
