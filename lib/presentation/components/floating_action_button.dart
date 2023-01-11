import 'package:flutter/material.dart';
import 'package:todo_app/presentation/controller/task_bloc.dart';
import '../../data/models/tasks_model.dart';
import '../controller/task_event.dart';

class FloatButton extends StatelessWidget {
  const FloatButton({Key? key, required this.taskBloc}) : super(key: key);
  final TaskBloc taskBloc;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        taskBloc.add(const AddTaskEvent(
          TaskModel(
              id: 0,
              title: 'Go to GYM',
              time: '12:30 AM',
              date: '15-9-2023',
              status: ''),
        ));
        taskBloc.add(const GetRunTasksEvent('new'));
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
