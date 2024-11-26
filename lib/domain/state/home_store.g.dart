// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_HomeStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$tasksAtom = Atom(name: '_HomeStore.tasks', context: context);

  @override
  ObservableList<Task> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<Task> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_HomeStore.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$_getTasksAsyncAction =
      AsyncAction('_HomeStore._getTasks', context: context);

  @override
  Future<void> _getTasks() {
    return _$_getTasksAsyncAction.run(() => super._getTasks());
  }

  late final _$createTaskAsyncAction =
      AsyncAction('_HomeStore.createTask', context: context);

  @override
  Future<void> createTask(String text) {
    return _$createTaskAsyncAction.run(() => super.createTask(text));
  }

  late final _$deleteTaskAsyncAction =
      AsyncAction('_HomeStore.deleteTask', context: context);

  @override
  Future<void> deleteTask(int idTask) {
    return _$deleteTaskAsyncAction.run(() => super.deleteTask(idTask));
  }

  late final _$updateTaskAsyncAction =
      AsyncAction('_HomeStore.updateTask', context: context);

  @override
  Future<void> updateTask(int idTask, int select) {
    return _$updateTaskAsyncAction.run(() => super.updateTask(idTask, select));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
tasks: ${tasks}
    ''';
  }
}
