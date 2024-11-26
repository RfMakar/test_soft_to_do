import 'package:test_soft_to_do/domain/entities/task.dart';

abstract class ToDoRepository {
  Future<List<Task>> getTasks();
  Future<bool> createTask({required String text});
  Future<bool> deleteTask({required int idTask});
  Future<bool> updateTask({
    required int idTask,
    required int select,
  });
}
