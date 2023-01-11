import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/text_styel.dart';
import '../../data/models/tasks_model.dart';
import '../controller/task_bloc.dart';
import '../controller/task_event.dart';
class TaskItemBuilder extends StatelessWidget {
  TaskItemBuilder({Key? key, required this.index,required this.state, required this.taskBloc}) : super(key: key);
 final int index;
 final TaskBloc taskBloc;
  List<Map<dynamic, dynamic>> state;
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state[index]['title'].toString(),
                style: CustomTextStyle.titleStyle,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                state[index]['time'].toString(),
                style: CustomTextStyle.timeStyle,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                state[index]['date'].toString(),
                style: CustomTextStyle.dateStyle,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              state[index]['status'] == 'done'
                  ? Container()
                  : InkWell(
                onTap: () {

                },
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.edit_note_outlined),
                ),
              ),
              Row(
                children: [
                  state[index]['status'] == 'done'
                      ? Container()
                      : InkWell(
                    onTap: () {
                      taskBloc.add(
                        ChangeTaskStatusEvent(
                          id: state[index]['id'],
                          taskModel: TaskModel(
                            id: state[index]['id'],
                            title: state[index]['title'],
                            time: state[index]['time'],
                            date: state[index]['date'],
                            status: 'done',
                          ),
                        ),
                      );
                      taskBloc
                          .add(const GetRunTasksEvent('new'));
                      taskBloc
                          .add(const GetDoneTasksEvent('done'));
                      taskBloc.add(
                          const GetArchivedTasksEvent(
                              'archived'));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.check_circle_outline),
                    ),
                  ),
                  state[index]['status'] == 'archived'
                      ? Container()
                      : const SizedBox(
                    width: 8,
                  ),
                  state[index]['status'] == 'archived'
                      ? Container()
                      : InkWell(
                    onTap: () {
                      debugPrint(state[index]['id'].toString());
                      taskBloc.add(
                        ChangeTaskStatusEvent(
                          id: state[index]['id'],
                          taskModel: TaskModel(
                            id: state[index]['id'],
                            title: state[index]['title'],
                            time: state[index]['time'],
                            date: state[index]['date'],
                            status: 'archived',
                          ),
                        ),
                      );
                      taskBloc
                          .add(const GetRunTasksEvent('new'));
                      taskBloc
                          .add(const GetDoneTasksEvent('done'));
                      taskBloc.add(
                          const GetArchivedTasksEvent(
                              'archived'));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.archive_outlined),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      debugPrint(state[index]['id'].toString());
                      taskBloc.add(
                        DeleteTaskEvent(state[index]['id']),
                      );
                      taskBloc
                          .add(const GetRunTasksEvent('new'));
                      taskBloc
                          .add(const GetDoneTasksEvent('done'));
                      taskBloc
                          .add(const GetArchivedTasksEvent('archived'));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.delete_outline),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
