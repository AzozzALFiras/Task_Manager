import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:taskmanager/data/model/Config/config.dart';

import '../model/task/task.dart';

getTask(String username) async {
  var uri = Uri.parse("${HostServer}/Tasks/Get.php");

  Map<String, String> headers = {"Accept": "application/json; charset=UTF-8"};

  try {
    final response = await http.post(uri, headers: headers, body: {
      "User_Name": username,
    });

    final responseData = json.decode(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(responseData.toString());

      return responseData;
    } else {
      var errorMessage = responseData['message'];
      throw errorMessage;
    }
  } catch (error) {
    throw error;
  }
}

Future<List<Task>> fetchTasks(String username) async {
  var uri = Uri.parse("${HostServer}/Tasks/Get.php");

  Map<String, String> headers = {"Accept": "application/json; charset=UTF-8"};
  Map<String, String> requestBody = {"User_Name": username};

  final response = await http.post(
    uri,
    headers: headers,
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = jsonDecode(response.body);
    List<Task> tasks = jsonResponse.map((data) => Task.fromJson(data)).toList();
    return tasks;
  } else {
    throw Exception('Failed to load tasks');
  }
}
