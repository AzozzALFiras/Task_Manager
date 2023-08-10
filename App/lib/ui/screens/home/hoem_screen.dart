// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/ui/screens/tasks/new_task_screen.dart';

import '../../../const/style_constant.dart';
import '../../../data/model/task/task.dart';
import '../../../data/repository/get_task.dart';
import '../splash/splash.dart';
import 'details.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Task>> _tasks;
  bool notificationStatus = false;

  Future<List<Task>> getTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String Username =
        prefs.getString('Task_Manager_Username') ?? "Dev_3zozz";
    return fetchTasks(Username);
  }

// Sender notification to user for task
  void getNotification(String Title, String Time, Task task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Username = prefs.getString('Task_Manager_Username');
    _resetStyle();

    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    String timetomrrow = DateFormat('yyyy-MM-dd').format(tomorrow);

// check time task and if notification yes
    if ((timetomrrow == Time) && notificationStatus) {
      await InAppNotifications.show(
          title: 'Task Manager',
          leading: const Icon(
            Icons.notifications_active,
            size: 50,
            color: appStyle.primaryColor,
          ),
          description: 'Hi $Username, Plz Check your tasks ($Title) at $Time ',
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailsScreen(
                      task: task,
                    )));
          },
          persistent: true);
    }
  }

  @override
  void initState() {
    _tasks = getTask();
    super.initState();
  }

  _resetStyle() {
    InAppNotifications.instance
      ..titleFontSize = 16.0
      ..descriptionFontSize = 14.0
      ..textColor = appStyle.primaryColor
      ..backgroundColor = Colors.white
      ..shadow = true
      ..animationStyle = InAppNotificationsAnimationStyle.scale;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CupertinoSwitch(
            value: notificationStatus,
            onChanged: (value) => setState(() => notificationStatus = value),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.remove('Task_Manager_Username');
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SlpashScreen()));
                });
              },
              // ignore: sized_box_for_whitespace
              child: Container(
                height: 10,
                width: 20,
                // color: Colors.white,
                child: const Icon(
                  Icons.logout_sharp,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          )
        ],
        backgroundColor: appStyle.primaryColor,
        title: const Text(
          "Task Manager",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: "Cario",
            fontSize: 20,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddTaskScreen()));
          },
          // ignore: sized_box_for_whitespace
          child: Container(
            height: 10,
            width: 20,
            // color: Colors.white,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Task>>(
        future: _tasks,
        builder: (context, snapshot) {
          // getNotification();
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Task> tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                Task task = tasks[index];
                getNotification(task.title, task.taskTime, task);
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                              task: task,
                            )));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          spreadRadius: 1,
                        )
                      ],
                      // border: Border.all(width: 1,color: Colors.black)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: appStyle.primaryColor,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.all_inbox,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    task.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: appStyle.mainFontFamily,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: appStyle.primaryColor,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.date_range_sharp,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    task.taskTime,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: appStyle.mainFontFamily),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          task.description,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
