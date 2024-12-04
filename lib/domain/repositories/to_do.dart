import 'package:test_soft_to_do/domain/entities/task.dart';

abstract class ToDoRepository {
  Future<List<Task>> getTasks();
  Future<Task?> createTask({required String text});
  Future<int?> deleteTask({required int idTask});
  Future<Task?> updateTask({
    required int idTask,
    required int select,
  });
}
