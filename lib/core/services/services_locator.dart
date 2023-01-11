import 'package:get_it/get_it.dart';
import 'package:todo_app/data/data_source/task_local_data_source.dart';
import 'package:todo_app/domain/repository/base_task_repository.dart';
import 'package:todo_app/domain/use_case/add_task_use_case.dart';
import 'package:todo_app/domain/use_case/delete_task_use_case.dart';
import 'package:todo_app/domain/use_case/get_tasks_use_case.dart';
import 'package:todo_app/domain/use_case/update_task_use_case.dart';
import 'package:todo_app/presentation/controller/task_bloc.dart';

import '../../data/repository/task_repository.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// Bloc
    sl.registerFactory(() => TaskBloc(sl(), sl(), sl(), sl()));
    // sl.registerFactory(() => MovieDetailsBloc(sl(), sl()));

    /// Use Cases
    sl.registerLazySingleton(() => GetTasksUseCase(sl()));
    sl.registerLazySingleton(() => AddTaskUesCase(sl()));
    sl.registerLazySingleton(() => UpdateTaskUseCase(sl()));
    sl.registerLazySingleton(() => DeleteTaskUseCase(sl()));

    /// Repository
    sl.registerLazySingleton<BaseTaskRepository>(
        () => TaskRepository(sl()));

    /// DATA SOURCE
    sl.registerLazySingleton<BaseTasksLocalDataSource>(
        () => TasksLocalDataSource());
  }
}
