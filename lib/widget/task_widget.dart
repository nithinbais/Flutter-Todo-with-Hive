import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todohive/models/task_model.dart';
import 'package:todohive/screens/task_screen.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.taskModel.title;
    subTitleController.text = widget.taskModel.subTitle;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    subTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // navigate to task view to see task details
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => TaskScreen(
                    titleController: titleController,
                    descriptionController: subTitleController,
                    taskModel: widget.taskModel)));
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(milliseconds: 600),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              widget.taskModel.isCompleted = !widget.taskModel.isCompleted;
              widget.taskModel.save();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              decoration: BoxDecoration(
                color: widget.taskModel.isCompleted ? Colors.red : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 0.8),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
          title: Text(
            titleController.text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              decoration: widget.taskModel.isCompleted
                  ? TextDecoration.lineThrough
                  : null,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subTitleController.text,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  decoration: widget.taskModel.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('dd-MM-yyyy')
                            .format(widget.taskModel.createdAtDate),
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        DateFormat('hh:mm a')
                            .format(widget.taskModel.createdAtTime),
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
