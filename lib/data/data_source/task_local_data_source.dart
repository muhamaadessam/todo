import 'package:todo_app/core/helper/db_helper.dart';

import '../models/tasks_model.dart';

abstract class BaseTasksLocalDataSource {
  void addTask(TaskModel taskModel);

  void updateTask(TaskModel taskModel, int id);

  Future<List<Map>> getTasks(String status);

  void deleteTask(int id);
}

class TasksLocalDataSource extends BaseTasksLocalDataSource {
  @override
  void addTask(TaskModel taskModel) {
    DBHelper.insert(taskModel);
  }

  @override
  Future<List<Map>> getTasks(String status) {
    return DBHelper.getData(status);
  }

  @override
  void updateTask(TaskModel taskModel,  int id) {
    DBHelper.update(taskModel, id);
  }

  @override
  void deleteTask(int id) {
    DBHelper.delete(id);
  }
}
