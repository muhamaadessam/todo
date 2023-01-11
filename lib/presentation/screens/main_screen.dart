import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/presentation/components/floating_action_button.dart';
import '../components/bottom_navigation_bar.dart';
import '../components/home_screen.dart';
import '../controller/task_bloc.dart';
import '../controller/task_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      List<List<Map<dynamic, dynamic>>> statesList = [
        state.newTasks,
        state.doneTasks,
        state.archivedTasks
      ];
      List<String> titles = [
        'New Tasks',
        'Done Tasks',
        'Archived Tasks',
      ];
      int currentIndex = state.currentIndex;
      return Scaffold(
        appBar: AppBar(
          title: Text(titles[currentIndex]),
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: currentIndex,
          taskBloc: BlocProvider.of<TaskBloc>(context),
        ),
        floatingActionButton: FloatButton(
          taskBloc: BlocProvider.of<TaskBloc>(context),
        ),
        body: HomeScreen(
          state: statesList[currentIndex],
          taskBloc: BlocProvider.of<TaskBloc>(context),
        ),
      );
    });
  }
}
