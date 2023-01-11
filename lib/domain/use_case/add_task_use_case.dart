import 'package:todo_app/domain/repository/base_task_repository.dart';
import '../../data/models/tasks_model.dart';

class AddTaskUesCase {
  final BaseTaskRepository baseTaskRepository;

  AddTaskUesCase(this.baseTaskRepository);

  void call(TaskModel taskModel) {
    baseTaskRepository.addTask(taskModel);
  }
}
