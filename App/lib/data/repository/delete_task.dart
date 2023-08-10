// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/Config/config.dart';

delete_task(String username, String id, context) async {
  // ignore: unnecessary_brace_in_string_interps
  var uri = Uri.parse("${HostServer}/Tasks/Delete.php");

  Map<String, String> headers = {"Accept": "application/json; charset=UTF-8"};

  try {
    Map<String, dynamic> body = {'User_Name': username, 'id': id};
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
