part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

final class HomeState {
  const HomeState({
    this.status = HomeStatus.initial,
    this.tasks = const <Task>[],
  });
  final HomeStatus status;
  final List<Task> tasks;

  HomeState copyWith({
    HomeStatus? status,
    List<Task>? tasks,
  }) {
    return HomeState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
    );
  }
}
