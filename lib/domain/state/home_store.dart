import 'package:mobx/mobx.dart';

import 'package:test_soft_to_do/domain/entities/task.dart';
import 'package:test_soft_to_do/domain/repositories/to_do.dart';

part 'home_store.g.dart';

// ignore: library_private_types_in_public_api
class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final ToDoRepository _toDoRepository;

  _HomeStore({required ToDoRepository toDoRepository})
      : _toDoRepository = toDoRepository;

  @action
  Future<void> init() async {
    isLoading = true;
    await _getTasks();
    isLoading = false;
  }

  @observable
  bool isLoading = true;

  @observable
  ObservableList<Task> tasks = ObservableList();

  @action
  Future<void> _getTasks() async {
    final res = await _toDoRepository.getTasks();
    tasks = ObservableList.of(res);
  }

  @action
  Future<void> createTask(String text) async {
    final res = await _toDoRepository.createTask(text: text);
    if (res) {
      init();
    }
  }

  @action
  Future<void> deleteTask(int idTask) async {
    final res = await _toDoRepository.deleteTask(idTask: idTask);
    if (res) {
      tasks.removeWhere((el) => el.id == idTask);
    }
  }

  @action
  Future<void> updateTask(int idTask, int select) async {
    final res = await _toDoRepository.updateTask(
      idTask: idTask,
      select: select == 0 ? 1:0,
    );
    if (res) {
      init();
    }
  }
}
