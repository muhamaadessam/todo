import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/presentation/components/text_form_field.dart';
import 'package:todo_app/presentation/controller/task_bloc.dart';
import '../../data/models/tasks_model.dart';
import '../controller/task_event.dart';

class FloatButton extends StatelessWidget {
  FloatButton({
    Key? key,
    required this.taskBloc,
  }) : super(key: key);
  final TaskBloc taskBloc;
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return Form(
              key: formKey,
              child: AlertDialog(
                title: const Text('Add Task'),
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
                                context: context, initialTime: TimeOfDay.now())
                            .then((value) =>
                                {timeController.text = value!.format(context)});
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
                                    DateFormat.yMMMd().format(value!)
                              });
                        }),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    child: const Text('Add'),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        taskBloc.add(
                          AddTaskEvent(
                            TaskModel(
                                id: 0,
                                title: titleController.text,
                                time: timeController.text,
                                date: dateController.text,
                                status: ''),
                          ),
                        );
                        taskBloc.add(const GetRunTasksEvent('new'));
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                          msg: 'Task Added',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM_LEFT,
                          backgroundColor: Colors.green,
                        );
                      }
                    },
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),

                  ),
                ],
              ),
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
