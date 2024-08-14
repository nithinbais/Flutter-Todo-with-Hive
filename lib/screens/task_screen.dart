import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todohive/models/task_model.dart';
import 'package:todohive/widgets/textform_task.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.taskModel,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TaskModel taskModel;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    super.initState();
    widget.titleController.text = widget.taskModel.title;
    widget.descriptionController.text = widget.taskModel.subTitle;
  }

  void _saveTask() async {
    widget.taskModel.title = widget.titleController.text;
    widget.taskModel.subTitle = widget.descriptionController.text;
    await widget.taskModel.save();
    Navigator.pop(context);
  }

  String formatDate(DateTime? date) {
    // Handle nullable DateTime by providing a fallback or using a default value
    if (date != null) {
      return DateFormat.yMMMEd().format(date);
    } else {
      return 'No Date Selected'; // Fallback text when date is null
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveTask,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormTask(
              controller: widget.titleController,
              isForDesciption: false,
              onFieldSubmitted: (_) => _saveTask(),
              onChanged: (_) {},
            ),
            const SizedBox(height: 16),
            TextFormTask(
              controller: widget.descriptionController,
              isForDesciption: true,
              onFieldSubmitted: (_) => _saveTask(),
              onChanged: (_) {},
            ),
            const SizedBox(height: 16),
            Text(
              'Created At: ${formatDate(widget.taskModel.createdAtDate)}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              'Time: ${formatDate(widget.taskModel.createdAtTime)}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.taskModel.isCompleted = !widget.taskModel.isCompleted;
                  widget.taskModel.save();
                });
              },
              child: Text(widget.taskModel.isCompleted
                  ? 'Mark as Incomplete'
                  : 'Mark as Complete'),
            ),
          ],
        ),
      ),
    );
  }
}
