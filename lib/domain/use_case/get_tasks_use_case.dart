import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/domain/repository/base_task_repository.dart';

class GetTasksUseCase{
  final BaseTaskRepository baseTaskRepository;

  GetTasksUseCase(this.baseTaskRepository);

  Future<Either<Failure, List<Map>>> call(String status)async{
    return await baseTaskRepository.getTasks(status);
  }
}