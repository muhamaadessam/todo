import 'package:flutter/material.dart';
import 'package:todo_app/presentation/components/task_item_builder.dart';
import 'package:todo_app/presentation/controller/task_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.state, required this.taskBloc})
      : super(key: key);
  final TaskBloc taskBloc;
  final List<Map<dynamic, dynamic>> state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: index == 0
                ? const EdgeInsets.only(top: 16.0, bottom: 8)
                : (index == state.length - 1
                    ? const EdgeInsets.only(bottom: 16.0, top: 8)
                    : const EdgeInsets.symmetric(vertical: 8)),
            child: TaskItemBuilder(
              index: index,
              state: state,
              taskBloc: taskBloc,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 0,
          );
        },
        itemCount: state.length,
      ),
    );
  }
}
