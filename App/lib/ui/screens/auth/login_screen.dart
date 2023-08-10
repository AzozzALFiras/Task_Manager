// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/ui/screens/auth/register.dart';

import '../../../const/style_constant.dart';
import '../../../data/repository/auth.dart';
import '../../widgets/buttonborder.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/cusuom_buttom.dart';
import '../../widgets/logIn_text_filed.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => loginScreenState();
}

// ignore: camel_case_types
class loginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  bool _validate = false;

  @override
  void initState() {
    focusNode1.addListener(() {
      setState(() {});
    });

    focusNode2.addListener(() {
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
      loginUser(_usernameController.text, _passwordController.text, context);
    }
  }

  savePrefShowDeleteAccount() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("showDeleteButton", false);
    print("${preferences.getBool("showDeleteButton")}");
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
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .07),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    gaps(.5),
                    const Text(
                      'Task Manager',
                      style: TextStyle(
                          color: appStyle.primaryColor,
                          fontSize: appStyle.xxxLargeTitleFontSize,
                          fontWeight: FontWeight.w700),
                    ),
                    gaps(.1),
                    Text(
                      'login',
                      style: appStyle.boldTextStyle(
                          fontSize: appStyle.xLargeTitleFontSize,
                          color: Colors.black),
                    ),
                    gaps(.05),
                    authTextFiled(
                      autofocus: true,
                      controller: _usernameController,
                      label: 'Username',
                      hint: 'Enter username',
                      isObscureText: false,
                      myFocusNode: focusNode1,
                      errorText: _validate ? "Empty filed" : null,
                    ),
                    gaps(.05),
                    authTextFiled(
                      controller: _passwordController,
                      label: 'Password',
                      hint: 'Enter Password',
                      isObscureText: true,
                      myFocusNode: focusNode2,
                      errorText: _validate ? "Empty filed" : null,
                    ),
                    gaps(.05),
                    gaps(.05),
                    CustomButtom(
                      text: 'Login',
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
                    gaps(.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomDivider(
                          width: MediaQuery.of(context).size.width * .12,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.black),
                                'Dont have account'),
                          ),
                        ),
                        CustomDivider(
                          width: MediaQuery.of(context).size.width * .12,
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
            backgroundColor: Color(0xff036eb7),
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
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          )),
    );
  }

  void showAlert(text, BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Task Manager"),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
