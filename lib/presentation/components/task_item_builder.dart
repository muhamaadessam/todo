import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/presentation/components/text_form_field.dart';
import '../../core/theme/text_style.dart';
import '../../data/models/tasks_model.dart';
import '../controller/task_bloc.dart';
import '../controller/task_event.dart';

class TaskItemBuilder extends StatelessWidget {
  TaskItemBuilder(
      {Key? key,
      required this.index,
      required this.state,
      required this.taskBloc})
      : super(key: key);
  final int index;
  final TaskBloc taskBloc;
  List<Map<dynamic, dynamic>> state;
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        timeController.text = state[index]['time'];
                        dateController.text = state[index]['date'];
                        titleController.text = state[index]['title'];
                        showDialog(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return Form(
                              key: formKey,
                              child: AlertDialog(
                                title: const Text('Edit Task'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomTextFormField(
                                      controller: titleController,
                                      type: TextInputType.text,
                                      label: 'Title',
                                      prefix: Icons.title,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return "Title must be not empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    CustomTextFormField(
                                      controller: timeController,
                                      type: TextInputType.none,
                                      label: 'Time',
                                      prefix: Icons.watch_later_outlined,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return "Time must be not empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                      onTap: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) => {
                                                  timeController.text =
                                                      value!.format(context)
                                                });
                                      },
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    CustomTextFormField(
                                        controller: dateController,
                                        type: TextInputType.none,
                                        label: 'date',
                                        prefix: Icons.date_range,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return "Date must be not empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.utc(2030),
                                          ).then((value) => {
                                                dateController.text =
                                                    DateFormat.yMMMd()
                                                        .format(value!)
                                              });
                                        }),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    child: const Text('Update'),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        taskBloc.add(
                                          UpdateTaskEvent(
                                            id: state[index]['id'],
                                            taskModel: TaskModel(
                                              id: state[index]['id'],
                                              title: titleController.text,
                                              time: timeController.text,
                                              date: dateController.text,
                                              status: state[index]['status'],
                                            ),
                                          ),
                                        );
                                        taskBloc
                                            .add(const GetRunTasksEvent('new'));
                                        taskBloc.add(
                                            const GetDoneTasksEvent('done'));
                                        taskBloc.add(
                                            const GetArchivedTasksEvent(
                                                'archived'));
                                        Fluttertoast.showToast(
                                          msg: 'Task Update',
                                        );
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                  ElevatedButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
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
                              UpdateTaskEvent(
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
                            taskBloc.add(const GetRunTasksEvent('new'));
                            taskBloc.add(const GetDoneTasksEvent('done'));
                            taskBloc
                                .add(const GetArchivedTasksEvent('archived'));
                            Fluttertoast.showToast(
                              msg: 'Task is Done',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM_LEFT,
                              backgroundColor: Colors.green,
                            );
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
                              UpdateTaskEvent(
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
                            taskBloc.add(const GetRunTasksEvent('new'));
                            taskBloc.add(const GetDoneTasksEvent('done'));
                            taskBloc
                                .add(const GetArchivedTasksEvent('archived'));
                            Fluttertoast.showToast(
                              msg: 'Task Archived',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM_LEFT,
                              backgroundColor: Colors.green,
                            );
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
                      taskBloc.add(const GetRunTasksEvent('new'));
                      taskBloc.add(const GetDoneTasksEvent('done'));
                      taskBloc.add(const GetArchivedTasksEvent('archived'));
                      Fluttertoast.showToast(
                        msg: 'Task Deleted',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM_LEFT,
                        backgroundColor: Colors.green,
                      );
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
