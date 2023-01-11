import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failure.dart';

import '../../data/models/tasks_model.dart';

abstract class BaseTaskRepository {
  Future<Either<Failure, List<Map>>> getTasks(String status);

  void addTask(TaskModel taskModel);

  void deleteTask(int id);

  void updateTask({required int id,required TaskModel taskModel});
}
