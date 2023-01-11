import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/data/models/tasks_model.dart';

class DBHelper {
  static Database _database = createDatabase() as Database;
  static String tableName = 'tasks';

  static Future<Database> createDatabase() async {
    _database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
                'CREATE TABLE $tableName (id INTEGER PRIMARY KEY ,title TEXT ,time TEXT ,date TEXT ,status TEXT)')
            .then((value) {
          debugPrint('table created');
        }).catchError((error) {
          debugPrint('error when creating ${error.toString()}');
        });
      },
      onOpen: (database) {
        debugPrint('database opened');
      },
    );
    return _database;
  }

  static Future<TaskModel> insert(TaskModel taskModel) async {
    await _database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO $tableName(title, time, date, status) VALUES("${taskModel.title}", "${taskModel.time}", "${taskModel.date}", "new")');
    }).then((value) {
      debugPrint("data is add is $taskModel");
    });
    return taskModel;
  }

  static Future<int> delete(int id) async {
    return await _database
        .rawDelete('DELETE FROM $tableName WHERE id = ?', [id]);
  }

  static update(TaskModel taskModel, int id) async {
    return await _database.rawUpdate(
        'UPDATE $tableName SET title = ?, time = ?, date = ?, status = ? WHERE id = ?',
        [
          taskModel.title,
          taskModel.time,
          taskModel.date,
          taskModel.status,
          id,
        ]).then((value) => debugPrint(taskModel.title));

  }

  static Future<List<Map>> getData(String status) async {
    var data =
        await _database.rawQuery('SELECT * FROM $tableName WHERE status = ?', [
      status,
    ]);
    List<Map> list = data;
    print('$status = ${list.length}');
    return data;
  }

  static Future close() async => _database.close();
}
