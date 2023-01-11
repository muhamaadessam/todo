import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/data/data_source/task_local_data_source.dart';
import 'package:todo_app/data/models/tasks_model.dart';
import 'package:todo_app/domain/repository/base_task_repository.dart';

import '../../core/error/exceptions.dart';

class TaskRepository extends BaseTaskRepository{
  final BaseTasksLocalDataSource baseTasksLocalDataSource;

  TaskRepository(this.baseTasksLocalDataSource);

  @override
  void addTask(TaskModel taskModel) {
    baseTasksLocalDataSource.addTask(taskModel);
  }

  @override
  void deleteTask(int id) {
    baseTasksLocalDataSource.deleteTask(id);
  }


  @override
  void updateTask({required int id, required TaskModel taskModel}) {
    baseTasksLocalDataSource.updateTask( taskModel, id);
  }

  @override
  Future<Either<Failure, List<Map>>> getTasks(String status) async {
    final result = await baseTasksLocalDataSource.getTasks(status);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }


}