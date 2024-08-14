import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  TaskModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.createdAtTime,
    required this.createdAtDate,
    required this.isCompleted,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String subTitle;

  @HiveField(3)
  DateTime createdAtTime;

  @HiveField(4)
  DateTime createdAtDate;

  @HiveField(5)
  bool isCompleted;

  factory TaskModel.create({
    required String? title,
    required String? subTitle,
    required DateTime? createdAtTime,
    required DateTime? createdAtDate,
  }) =>
      TaskModel(
        id: const Uuid().v1(),
        title: title ?? '',
        subTitle: subTitle ?? '',
        createdAtTime: createdAtTime ?? DateTime.now(),
        createdAtDate: createdAtDate ?? DateTime.now(),
        isCompleted: false,
      );
}
