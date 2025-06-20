import 'package:assessment/model/tasks_model.dart';
import 'package:flutter/material.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _filesController = TextEditingController();

  int selectedHour = 6;
  int selectedMinute = 0;
  String period = 'AM';

  final FixedExtentScrollController _hourController =
      FixedExtentScrollController();
  final FixedExtentScrollController _minuteController =
      FixedExtentScrollController();
  final FixedExtentScrollController _periodController =
      FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
    // Set initial position for hour controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _hourController.jumpToItem(selectedHour);
      _minuteController
          .jumpToItem(selectedMinute ~/ 5); // For 5-minute intervals
      _periodController.jumpToItem(period == 'AM' ? 0 : 1);
    });
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _notesController.dispose();
    _filesController.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FloatingActionButton(
          backgroundColor: Colors.orange,
          shape: const CircleBorder(),
          onPressed: _saveTask,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Task',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 20),
              const Text('Task Name'),
              const SizedBox(height: 15),
              TextFormField(
                controller: _taskNameController,
                decoration: InputDecoration(
                  hintText: 'Example: Wake up',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Colors.orange),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Colors.orange),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Colors.orange),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Time'),
              const SizedBox(height: 15),
              _buildTimePicker(),
              const SizedBox(height: 20),
              const Text('Notes'),
              const SizedBox(height: 15),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  hintText: 'Tap Here to add notes',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Colors.orange),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Colors.orange),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Colors.orange),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Files'),
              const SizedBox(height: 15),
              TextFormField(
                controller: _filesController,
                decoration: InputDecoration(
                  hintText: 'Tap here to add files',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Colors.orange),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Colors.orange),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Colors.orange),
                  ),
                ),
              ),
              const SizedBox(height: 80), // Space for FAB
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hour picker
                Expanded(
                  child: ListWheelScrollView(
                    controller: _hourController,
                    itemExtent: 50,
                    perspective: 0.01,
                    diameterRatio: 1.2,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedHour = index;
                      });
                    },
                    children: List.generate(12, (index) {
                      final hour = index + 1;
                      return Center(
                        child: Text(
                          hour.toString().padLeft(2, '0'),
                          style: TextStyle(
                            fontSize: 30,
                            color: selectedHour == hour
                                ? Colors.white
                                : Colors.white.withOpacity(0.8),
                            fontWeight: selectedHour == hour
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15),
        // Minute picker
        Expanded(
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListWheelScrollView(
              controller: _minuteController,
              itemExtent: 50,
              perspective: 0.01,
              diameterRatio: 1.2,
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedMinute = index * 5; // 5-minute intervals
                });
              },
              children: List.generate(12, (index) {
                final minute = index * 5;
                return Center(
                  child: Text(
                    minute.toString().padLeft(2, '0'),
                    style: TextStyle(
                      fontSize: 30,
                      color: selectedMinute == minute
                          ? Colors.white
                          : Colors.white.withOpacity(0.8),
                      fontWeight: selectedMinute == minute
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        const SizedBox(width: 15),
        // AM/PM picker
        Expanded(
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListWheelScrollView(
              controller: _periodController,
              itemExtent: 50,
              perspective: 0.01,
              diameterRatio: 1.2,
              onSelectedItemChanged: (index) {
                setState(() {
                  period = index == 0 ? 'AM' : 'PM';
                });
              },
              children: ['AM', 'PM'].map((item) {
                return Center(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 30,
                      color: period == item
                          ? Colors.white
                          : Colors.white.withOpacity(0.8),
                      fontWeight:
                          period == item ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  void _saveTask() {
    if (_taskNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task name')),
      );
      return;
    }

    final time =
        '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} $period';

    Navigator.pop(
        context,
        TaskModel(
          title: _taskNameController.text,
          time: time,
          notes: _notesController.text,
        ));
  }
}
