import 'package:equatable/equatable.dart';

class Tasks extends Equatable {
  final int id;
  final String title;
  final String time;
  final String date;
  final String status;

  const Tasks({
    required this.id,
    required this.title,
    required this.time,
    required this.date,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        time,
        date,
        status,
      ];
}
