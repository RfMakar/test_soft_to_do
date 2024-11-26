import 'package:test_soft_to_do/domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    required super.id,
    required super.name,
    required super.selected,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        name: json['name'],
        selected: json['selected'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'selected': selected,
    };
  }
}
