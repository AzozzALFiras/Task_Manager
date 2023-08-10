import 'package:flutter/material.dart';
import '../../../const/style_constant.dart';
import '../../../data/model/task/task.dart';
import '../../../data/repository/delete_task.dart';
import '../../../data/repository/update_task.dart';
import '../../widgets/cusuom_buttom.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  Task task;

  DetailsScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;
  late TextEditingController dateController;

  validateValue() {
    Update_Task(widget.task.id, titleController.text, descController.text,
        dateController.text, context);
  }

  @override
  void initState() {
    titleController = TextEditingController(text: widget.task.title);
    descController = TextEditingController(text: widget.task.description);
    dateController = TextEditingController(text: widget.task.taskTime);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appStyle.primaryColor,
        title: const Text(
          "Task Manager",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: "Cario",
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                // ignore: avoid_print
                delete_task(widget.task.username, widget.task.id, context);
              },
              // ignore: sized_box_for_whitespace
              child: Container(
                height: 10,
                width: 20,
                // color: Colors.white,
                child: const Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              maxLines: 1,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                fillColor: Colors.grey.withOpacity(0.5),
                labelStyle: TextStyle(color: Color(0xff363062), fontSize: 16),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xff363062), width: 1.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            gaps(0.02),
            TextField(
              controller: descController,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 8,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                fillColor: Colors.grey.withOpacity(0.5),
                labelStyle: TextStyle(color: Color(0xff363062), fontSize: 16),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xff363062), width: 1.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            gaps(0.02),
            TextField(
              controller: dateController,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              maxLines: 1,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                fillColor: Colors.grey.withOpacity(0.5),
                labelStyle: TextStyle(color: Color(0xff363062), fontSize: 16),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xff363062), width: 1.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            gaps(0.05),
            CustomButtom(
              text: 'Update Task',
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                validateValue();
              },
              color: appStyle.primaryColor,
              height: MediaQuery.of(context).size.width * .15,
              width: MediaQuery.of(context).size.width,
              borderRadius: 8,
            ),
          ],
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
