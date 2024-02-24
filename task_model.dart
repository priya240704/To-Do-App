class TaskModel {
  final String taskId;
  final String title;
  final String notes;
  final String remind;
  final String date;
  final String time;
  final int color;

  TaskModel({
    required this.taskId,
    required this.title,
    required this.notes,
    required this.remind,
    required this.date,
    required this.time,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'title': title,
      'notes': notes,
      'remind': remind,
      'date': date,
      'time': time,
      'color': color,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskId: map['taskId'],
      title: map['title'],
      notes: map['notes'],
      remind: map['remind'],
      date: map['date'],
      time: map['time'],
      color: map['color'],
    );
  }
}
