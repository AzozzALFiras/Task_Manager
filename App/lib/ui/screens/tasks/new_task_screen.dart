import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'dart:convert';

import '../../../const/style_constant.dart';
import '../../widgets/cusuom_buttom.dart';
import '../../widgets/logIn_text_filed.dart';
import '../../../data/model/Config/config.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _desController = TextEditingController();
  final _dateController = TextEditingController();

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  bool _validate = false;
  validateValue() {
    _titleController.value.text.isEmpty || _desController.value.text.isEmpty
        ? _validate = true
        : _validate = false;
    final value = _titleController.value.text.isNotEmpty &&
        _desController.value.text.isNotEmpty;

    if (value) {
      AddTaskServer(
          _titleController.text, _desController.text, _dateController.text);
    }
  }

  // ignore: non_constant_identifier_names
  void AddTaskServer(title, description, date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? Username = prefs.getString('Task_Manager_Username');

    // ignore: unnecessary_brace_in_string_interps
    final uri = Uri.parse('${HostServer}/Tasks/Create.php');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'User_Name': Username,
      'Task_Title': title,
      'Task_Des': description,
      'Task_Date': date
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
    String Status_Task = responseJson["Status_Task"];
    String Status_Text = responseJson["Status_Text"];

    if (statusCode == 200) {
      if (Status_Task == "DONE") {
        Future.delayed(Duration.zero, () => showAlert(Status_Text, context));
      } else {
        // error login
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Cario",
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 10,
            width: 20,
            color: Colors.white,
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
      ),
      backgroundColor: appStyle.primaryBgColor,
      body: Container(
        child: SingleChildScrollView(
          child: IgnorePointer(
            ignoring: false,
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
                    gaps(.1),
                    const Text(
                      'Add new task',
                      style: TextStyle(
                          color: appStyle.primaryColor,
                          fontSize: appStyle.xxxLargeTitleFontSize,
                          fontWeight: FontWeight.w700),
                    ),

                    gaps(.1),
                    authTextFiled(
                      autofocus: true,
                      controller: _titleController,
                      label: 'Title',
                      hint: 'Enter title',
                      isObscureText: false,
                      myFocusNode: focusNode1,
                      errorText: _validate ? "Empty filed" : null,
                    ),
                    gaps(.05),
                    TextField(
                      controller: _desController,
                      style: TextStyle(color: Color(0xff363062), fontSize: 16),
                      maxLines: 4, //or null
                      decoration: InputDecoration(
                        errorText: _validate ? "Empty filed" : null,
                        fillColor: Colors.grey.withOpacity(0.5),
                        hintText: "Enter description",
                        labelText: "Description",
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff363062), width: 1.0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelStyle:
                            TextStyle(color: Color(0xff363062), fontSize: 16),
                      ),
                    ),
                    gaps(.05),
                    TextField(
                        controller:
                            _dateController, //editing controller of this TextField
                        decoration: InputDecoration(
                          errorText: _validate ? "Empty filed" : null,
                          fillColor: Colors.grey.withOpacity(0.5),
                          hintText: "Enter Date",
                          labelText: "Date",
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xff363062), width: 1.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          labelStyle:
                              TextStyle(color: Color(0xff363062), fontSize: 16),
                        ),
                        readOnly: true, // when true user cannot edit text
                        onTap: () async {
                          //when click we have to show the datepicker

                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate: DateTime
                                  .now(), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(pickedDate);
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(formattedDate);
                            setState(() {
                              _dateController.text = formattedDate;
                            });
                          } else {
                            print("Date is not selected");
                          }
                        }),
                    gaps(.25),
                    CustomButtom(
                      text: 'Add Task',
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
