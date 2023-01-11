import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/domain/repository/base_task_repository.dart';

class DeleteTaskUseCase {
  final BaseTaskRepository baseTaskRepository;

  DeleteTaskUseCase(this.baseTaskRepository);

  void call(int id) async {
    baseTaskRepository.deleteTask(id);
  }
}
