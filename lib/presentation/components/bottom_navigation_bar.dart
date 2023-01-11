import 'package:flutter/material.dart';
import '../controller/task_bloc.dart';
import '../controller/task_event.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
      {Key? key, required this.currentIndex, required this.taskBloc})
      : super(key: key);
  final int currentIndex;
  final TaskBloc taskBloc;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        debugPrint("currentIndex = $currentIndex");
        taskBloc.add(ChangeIndexEvent(index));
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'New Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_circle_outline),
          label: 'Done Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.archive_outlined),
          label: 'Archived Tasks',
        ),
      ],
      currentIndex: currentIndex,
    );
  }
}
