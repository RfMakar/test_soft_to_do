part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}

class HomeInit extends HomeEvent {
  const HomeInit();
}

class HomeCreateTask extends HomeEvent {
  const HomeCreateTask({required this.text});
  final String text;
}

class HomeDeleteTask extends HomeEvent {
  const HomeDeleteTask({required this.idTask});
  final int idTask;
}

class HomeUpdateTask extends HomeEvent {
  const HomeUpdateTask({required this.idTask, required this.select});
  final int idTask;
  final int select;
}
