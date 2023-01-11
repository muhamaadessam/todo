import 'package:todo_app/data/models/tasks_model.dart';
import 'package:todo_app/domain/repository/base_task_repository.dart';

class UpdateTaskUseCase{
  final BaseTaskRepository baseTaskRepository;

  UpdateTaskUseCase(this.baseTaskRepository);

  void call(int id,TaskModel taskModel)async{
    baseTaskRepository.updateTask(id: id,taskModel: taskModel);
  }
}