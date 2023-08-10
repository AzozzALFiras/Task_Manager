// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Config/config.dart';

// id, title, description, date
Update_Task(
    String id, String title, String description, String date, context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final String? Username = preferences.getString('Task_Manager_Username');
  // ignore: unnecessary_brace_in_string_interps
  var uri = Uri.parse("${HostServer}/Tasks/Update.php");

  Map<String, String> headers = {"Accept": "application/json; charset=UTF-8"};

  try {
    Map<String, dynamic> body = {
      'id': id,
      'User_Name': Username,
      'Task_Title': title,
      'Task_Des': description,
      'Task_Date': date
    };
    String jsonBody = json.encode(body);
    final response = await http.post(uri, headers: headers, body: jsonBody);
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      Future.delayed(
          Duration.zero, () => showAlert(responseData['Status_Text'], context));

      return responseData;
    } else {
      var errorMessage = responseData['Status_Text'];
      throw errorMessage;
    }
  } catch (error) {
    throw error;
  }
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
