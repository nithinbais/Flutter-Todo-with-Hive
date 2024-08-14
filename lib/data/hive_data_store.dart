import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todohive/models/task_model.dart';

class HiveDataStore {
  // Box Name String
  static const boxName = 'taskBox';

// Our current Box with all the saved data inside -Box<Task>
  final Box<TaskModel> box = Hive.box<TaskModel>(boxName);

// Add new task to box
  Future<void> addTask({required TaskModel task_model}) async {
    await box.put(task_model.id, task_model);
  }

  //show Task
  Future<TaskModel?> getTask({required String Id}) async {
    return box.get(Id);
  }

  // update task
  Future<void> updateTask({required TaskModel task_model}) async {
    await task_model.save();
  }

  // dalete task
  Future<void> deleteTask({required TaskModel task_model}) async {
    await task_model.delete();
  }

  // Listen to Box Changes
  // using this method we will listen to box changes and update the Ui accordingly
  ValueListenable<Box<TaskModel>> listenable() {
    return box.listenable();
  }
}
