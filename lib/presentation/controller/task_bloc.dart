import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/use_case/delete_task_use_case.dart';
import 'package:todo_app/domain/use_case/update_task_use_case.dart';
import 'package:todo_app/presentation/controller/task_event.dart';
import 'package:todo_app/presentation/controller/task_state.dart';
import '../../core/utils/enums.dart';
import '../../domain/use_case/add_task_use_case.dart';
import '../../domain/use_case/get_tasks_use_case.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AddTaskUesCase addTaskUesCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final GetTasksUseCase getTasksUseCase;

  TaskBloc(
    this.addTaskUesCase,
    this.deleteTaskUseCase,
    this.updateTaskUseCase,
    this.getTasksUseCase,
  ) : super(const TaskState()) {
    {
      on<GetRunTasksEvent>(_getRunTasks);
      on<GetDoneTasksEvent>(_getDoneTasks);
      on<GetArchivedTasksEvent>(_getArchivedTasks);
      on<AddTaskEvent>(_addTasks);
      on<DeleteTaskEvent>(_deleteTasks);
      on<ChangeIndexEvent>(_changeIndex);
      on<UpdateTaskEvent>(_changeTaskStatus);
    }
  }

  FutureOr<void> _getRunTasks(
      GetRunTasksEvent event, Emitter<TaskState> emit) async {
    final result = await getTasksUseCase(event.status);
    result.fold(
      (l) => emit(
        state.copyWith(
          newTasksState: RequestState.error,
          newTasksMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          newTasks: r,
          newTasksState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _getDoneTasks(
      GetDoneTasksEvent event, Emitter<TaskState> emit) async {
    final result = await getTasksUseCase(event.status);
    result.fold(
      (l) => emit(
        state.copyWith(
          doneTasksState: RequestState.error,
          doneTasksMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          doneTasks: r,
          doneTasksState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _getArchivedTasks(
      GetArchivedTasksEvent event, Emitter<TaskState> emit) async {
    final result = await getTasksUseCase(event.status);
    result.fold(
      (l) => emit(
        state.copyWith(
          archivedTasksState: RequestState.error,
          archivedTasksMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          archivedTasks: r,
          archivedTasksState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _addTasks(AddTaskEvent event, Emitter<TaskState> emit) async {
    addTaskUesCase(event.taskModel);
    emit(state.copyWith());
  }

  FutureOr<void> _deleteTasks(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    deleteTaskUseCase(event.id);
    emit(state.copyWith());
  }

  FutureOr<void> _changeIndex(ChangeIndexEvent event, Emitter<TaskState> emit) {
    emit(
      state.copyWith(
        currentIndex: event.currentIndex,
      ),
    );
  }

  FutureOr<void> _changeTaskStatus(
      UpdateTaskEvent event, Emitter<TaskState> emit) async {
    updateTaskUseCase(event.id, event.taskModel);
    emit(state.copyWith());
  }
}
