import 'package:test_soft_to_do/data/data_soures/sqflite.dart';
import 'package:test_soft_to_do/data/model/task.dart';
import 'package:test_soft_to_do/domain/repositories/to_do.dart';

class ToDoRepositoryImpl implements ToDoRepository {
  final SqfliteClientApp _sqfliteClientApp;

  ToDoRepositoryImpl({
    required SqfliteClientApp sqfliteClientApp,
  }) : _sqfliteClientApp = sqfliteClientApp;

  @override
  Future<List<TaskModel>> getTasks() async {
    final data = await _sqfliteClientApp.getTasks();
    return data.isNotEmpty
        ? data.map((e) => TaskModel.fromJson(e)).toList()
        : [];
  }

  @override
  Future<TaskModel?> createTask({required String text}) async {
    final data = await _sqfliteClientApp.createTask(text);
    return data.isNotEmpty
        ? data.map((e) => TaskModel.fromJson(e)).toList().first
        : null;
  }

  @override
  Future<int> deleteTask({required int idTask}) async {
    final data = await _sqfliteClientApp.deleteTask(idTask);
    return data;
  }

  @override
  Future<TaskModel?> updateTask({required int idTask, required int select}) async {
    final data = await _sqfliteClientApp.updateTask(idTask, select);
    return data.isNotEmpty
        ? data.map((e) => TaskModel.fromJson(e)).toList().first
        : null;
  }
}
