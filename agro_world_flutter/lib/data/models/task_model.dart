class TaskModel {
  final int id;
  final String task;
  final String desc;
  final String date;
  final String time;
  final String priority;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.task,
    required this.desc,
    required this.date,
    required this.time,
    this.priority = "Medium",
    this.isCompleted = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) ?? 0 : 0,
      task: json['task']?.toString() ?? '',
      desc: json['desc']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      time: json['time']?.toString() ?? '',
      priority: json['priority']?.toString() ?? 'Medium',
      isCompleted: json['isCompleted'] == true || json['isCompleted'] == 'true',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task': task,
      'desc': desc,
      'date': date,
      'time': time,
      'priority': priority,
      'isCompleted': isCompleted,
    };
  }

  TaskModel copyWith({
    int? id,
    String? task,
    String? desc,
    String? date,
    String? time,
    String? priority,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      task: task ?? this.task,
      desc: desc ?? this.desc,
      date: date ?? this.date,
      time: time ?? this.time,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
