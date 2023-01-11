import 'package:equatable/equatable.dart';
import 'package:todo_app/core/utils/enums.dart';

class TaskState extends Equatable {
  final List<Map<dynamic, dynamic>> newTasks;
  final RequestState newTasksState;
  final String newTasksMessage;
  final List<Map<dynamic, dynamic>> doneTasks;
  final RequestState doneTasksState;
  final String doneTasksMessage;
  final List<Map<dynamic, dynamic>> archivedTasks;
  final RequestState archivedTasksState;
  final String archivedTasksMessage;
  final int currentIndex;

  const TaskState({
    this.newTasks = const [],
    this.newTasksState = RequestState.loading,
    this.newTasksMessage = '',
    this.doneTasks = const [],
    this.doneTasksState = RequestState.loading,
    this.doneTasksMessage = '',
    this.archivedTasks = const [],
    this.archivedTasksState = RequestState.loading,
    this.archivedTasksMessage = '',
    this.currentIndex = 0,
  });

  TaskState copyWith({
    List<Map<dynamic, dynamic>>? newTasks,
    RequestState? newTasksState,
    String? newTasksMessage,
    List<Map<dynamic, dynamic>>? doneTasks,
    RequestState? doneTasksState,
    String? doneTasksMessage,
    List<Map<dynamic, dynamic>>? archivedTasks,
    RequestState? archivedTasksState,
    String? archivedTasksMessage,
    int? currentIndex,
  }) {
    return TaskState(
      newTasks: newTasks ?? this.newTasks,
      newTasksMessage: newTasksMessage ?? this.doneTasksMessage,
      newTasksState: newTasksState ?? this.newTasksState,
      doneTasks: doneTasks ?? this.doneTasks,
      doneTasksMessage: doneTasksMessage ?? this.doneTasksMessage,
      doneTasksState: doneTasksState ?? this.doneTasksState,
      archivedTasks: archivedTasks ?? this.archivedTasks,
      archivedTasksMessage: archivedTasksMessage ?? this.archivedTasksMessage,
      archivedTasksState: archivedTasksState ?? this.archivedTasksState,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object> get props => [
        newTasks,
        newTasksState,
        newTasksMessage,
        doneTasks,
        doneTasksState,
        doneTasksMessage,
        archivedTasks,
        archivedTasksState,
        archivedTasksMessage,
        currentIndex,
      ];
}
