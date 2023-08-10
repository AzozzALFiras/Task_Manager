// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ui/screens/auth/login_screen.dart';
import '../../ui/screens/home/hoem_screen.dart';
import '../model/Config/config.dart';
import 'update_task.dart';

void loginUser(username, password, context) async {
  final uri = Uri.parse('${HostServer}/auth/Login.php');
  final headers = {'Content-Type': 'application/json'};
  Map<String, dynamic> body = {
    'User_Name': username,
    'User_Password': password
  };
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );

  int statusCode = response.statusCode;

  Map<String, dynamic> responseJson = json.decode(response.body);
  String Status_Login = responseJson["Status_Login"];
  String Status_Text = responseJson["Status_Text"];
  String Username_Json = responseJson["Username"];
  SharedPreferences preferences = await SharedPreferences.getInstance();

  if (statusCode == 200) {
    if (Status_Login == "DONE") {
      // ignore: use_build_context_synchronously
      showAlert(Status_Text, context);
      await preferences.setString('Task_Manager_Username', Username_Json);
      // ignore: unnecessary_new
      await new Future.delayed(const Duration(seconds: 5));
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      // error login
      showAlert(Status_Text, context);
    }
  }
}

void registerUser(username, password, context) async {
  final uri = Uri.parse('${HostServer}/auth/CreateUser.php');
  final headers = {'Content-Type': 'application/json'};
  Map<String, dynamic> body = {
    'User_Name': username,
    'User_Password': password
  };
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );

  int statusCode = response.statusCode;
  Map<String, dynamic> responseJson = json.decode(response.body);
  String statusLogin = responseJson["Status_Login"];
  //String Username_Json = responseJson["Username"];
  if (statusCode == 200) {
    try {
      if (statusLogin == "DONE") {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } catch (error) {
      showAlert(error, context);
    }
  }
}
