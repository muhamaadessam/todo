import 'package:todo_app/domain/entities/task.dart';

class TaskModel extends Tasks {
  const TaskModel({
    required super.id,
    required super.title,
    required super.time,
    required super.date,
    required super.status,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        title: json["title"],
        time: json["time"],
        date: json["date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['time'] = time;
    data['date'] = date;
    data['status'] = status;

    return data;
  }

}
