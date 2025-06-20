class TaskModel {
  final String title;
  final String time;
  final String? notes;
  bool isChecked;

  TaskModel({
    required this.title,
    required this.time,
    this.notes,
    this.isChecked = false,
  });
}
