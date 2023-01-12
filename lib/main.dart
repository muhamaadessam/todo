import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/core/helper/db_helper.dart';
import 'package:todo_app/core/services/services_locator.dart';
import 'package:todo_app/presentation/controller/task_bloc.dart';
import 'package:todo_app/presentation/controller/task_event.dart';
import 'package:todo_app/presentation/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DBHelper.createDatabase();
  await openDatabase('todo.db');
  ServicesLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        splashColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
      home: BlocProvider(
        create: (context) => sl<TaskBloc>()
          ..add(const GetRunTasksEvent('new'))
          ..add(const GetDoneTasksEvent('done'))
          ..add(const GetArchivedTasksEvent('archived')),
        child: const MainScreen(),
      ),
    );
  }
}
