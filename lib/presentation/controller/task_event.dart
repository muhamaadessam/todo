import 'package:equatable/equatable.dart';
import 'package:todo_app/data/models/tasks_model.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class GetRunTasksEvent extends TaskEvent {
  final String status;

  const GetRunTasksEvent(this.status);

  @override
  List<Object> get props => [status];
}

class GetDoneTasksEvent extends TaskEvent {
  final String status;

  const GetDoneTasksEvent(this.status);

  @override
  List<Object> get props => [status];
}

class GetArchivedTasksEvent extends TaskEvent {
  final String status;

  const GetArchivedTasksEvent(this.status);

  @override
  List<Object> get props => [status];
}

class AddTaskEvent extends TaskEvent {
  final TaskModel taskModel;

  const AddTaskEvent(this.taskModel);

  @override
  List<Object> get props => [taskModel];
}

class ChangeIndexEvent extends TaskEvent {
  final int currentIndex;

  const ChangeIndexEvent(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}

class UpdateTaskEvent extends TaskEvent {
  final TaskModel taskModel;
  final int id;

  const UpdateTaskEvent({
    required this.taskModel,
    required this.id,
  });

  @override
  List<Object> get props => [
    taskModel,
        id,
      ];
}

class DeleteTaskEvent extends TaskEvent {
  final int id;

  const DeleteTaskEvent(this.id);

  @override
  List<Object> get props => [id];
}