import 'package:assessment/model/tasks_model.dart';
import 'package:assessment/pages/add_new_task_page.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<TaskModel> todayTasks = [
    TaskModel(title: 'Wake up', time: '06:00 AM', isChecked: true),
    TaskModel(title: 'GYM', time: '06:30 AM', isChecked: true),
    TaskModel(title: 'FEED DOG', time: '08:00 AM'),
    TaskModel(title: 'Go to supermarket', time: '05:00 PM'),
    TaskModel(title: 'Visit my friend', time: '07:30 PM'),
  ];

  void _toggleCheck(int index, bool? value) {
    setState(() {
      todayTasks[index].isChecked = value ?? false;
    });
  }

  void _removeTask(int index) {
    setState(() {
      todayTasks.removeAt(index);
    });
  }

  Future<void> _addNewTask() async {
    final newTask = await Navigator.push<TaskModel>(
      context,
      MaterialPageRoute(builder: (context) => const AddNewTask()),
    );

    if (newTask != null) {
      setState(() {
        todayTasks.add(newTask);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _todaySection(),
      ),
    );
  }

  Widget _todaySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'TODAY',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            GestureDetector(
              onTap: _addNewTask,
              child: const CircleAvatar(
                backgroundColor: Colors.orange,
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        todayTasks.isEmpty
            ? const Center(child: Text('No Tasks for today'))
            : Column(
                children: todayTasks.asMap().entries.map((entry) {
                  int index = entry.key;
                  TaskModel task = entry.value;
                  return _buildDismissibleTask(index, task);
                }).toList(),
              ),
      ],
    );
  }

  Widget _buildDismissibleTask(int index, TaskModel task) {
    return Dismissible(
      key: Key(task.title + index.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) => _removeTask(index),
      child: _listTile(
        title: task.title,
        time: task.time,
        isChecked: task.isChecked,
        onChanged: (value) => _toggleCheck(index, value),
      ),
    );
  }

  Widget _listTile({
    required String title,
    required String time,
    required bool isChecked,
    required Function(bool?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: isChecked,
                activeColor: Colors.orange,
                onChanged: onChanged,
              ),
              Text(
                title,
                style: TextStyle(
                  decoration: isChecked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: isChecked ? Colors.grey : Colors.black,
                ),
              ),
            ],
          ),
          Text(
            time,
            style: TextStyle(
              decoration:
                  isChecked ? TextDecoration.lineThrough : TextDecoration.none,
              color: isChecked ? Colors.grey : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
