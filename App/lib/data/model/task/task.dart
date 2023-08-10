class Task {
  String id;
  String title;
  String description;
  String username;
  String taskTime;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.username,
    required this.taskTime,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['Title'],
      description: json['Description'],
      username: json['Username'],
      taskTime: json['Task_Time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Title': title,
      'Description': description,
      'Username': username,
      'Task_Time': taskTime,
    };
  }
}
