import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_soft_to_do/domain/entities/task.dart';
import 'package:test_soft_to_do/domain/repositories/to_do.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._toDoRepository) : super(const HomeState()) {
    on<HomeInit>(_init);
    on<HomeCreateTask>(_createTask);
    on<HomeDeleteTask>(_deleteTask);
    on<HomeUpdateTask>(_updateTask);
  }

  final ToDoRepository _toDoRepository;

  Future<void> _init(
    HomeInit event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final res = await _toDoRepository.getTasks();
    emit(state.copyWith(
      status: HomeStatus.success,
      tasks: res,
    ));
  }

  Future<void> _createTask(
    HomeCreateTask event,
    Emitter<HomeState> emit,
  ) async {
    final res = await _toDoRepository.createTask(text: event.text);

    if (res != null) {
      emit(
        state.copyWith(
          status: HomeStatus.success,
          tasks: List.of(state.tasks)..add(res),
        ),
      );
    }
  }

  Future<void> _deleteTask(
    HomeDeleteTask event,
    Emitter<HomeState> emit,
  ) async {
    final res = await _toDoRepository.deleteTask(idTask: event.idTask);
    if (res != null) {
      state.tasks.removeWhere((el) => el.id == event.idTask);

      emit(state.copyWith(
        status: HomeStatus.success,
        tasks: List.of(state.tasks),
      ));
    }
  }

  Future<void> _updateTask(
    HomeUpdateTask event,
    Emitter<HomeState> emit,
  ) async {
    final res = await _toDoRepository.updateTask(
      idTask: event.idTask,
      select: event.select == 0 ? 1 : 0,
    );
    if (res != null) {
      final index = state.tasks.indexWhere((el) => el.id == event.idTask);
      state.tasks[index] = res;
      emit(
        state.copyWith(
          status: HomeStatus.success,
          tasks: List.of(state.tasks),
        ),
      );
    }
  }
}
