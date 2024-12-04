import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_soft_to_do/core/functions/setup_dependencies.dart';
import 'package:test_soft_to_do/domain/entities/task.dart';
import 'package:test_soft_to_do/presentation/screens/bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>()..add(const HomeInit()),
      child: const HomeScreenView(),
    );
  }
}

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Задачи'),
      ),
      floatingActionButton: const ButtonCreateTask(),
      body: const TasksList(),
    );
  }
}

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case HomeStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case HomeStatus.initial:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case HomeStatus.failure:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case HomeStatus.success:
            if (state.tasks.isEmpty) {
              return const Center(
                child: Text('No tasks'),
              );
            }
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return TaskWidget(
                  key: ValueKey(task.id),
                  task: task,
                );
              },
            );
        }
      },
    );
  }
}

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, required this.task});
  final Task task;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.name),
      onTap: () => context.read<HomeBloc>().add(
            HomeUpdateTask(
              idTask: task.id!,
              select: task.selected,
            ),
          ),
      leading: task.selected == 0
          ? const Icon(Icons.check_box_outline_blank)
          : const Icon(Icons.check_box_outlined),
      trailing: IconButton(
        onPressed: () => context.read<HomeBloc>().add(
              HomeDeleteTask(idTask: task.id!),
            ),
        icon: const Icon(Icons.delete),
      ),
    );
  }
}

class ButtonCreateTask extends StatefulWidget {
  const ButtonCreateTask({super.key});

  @override
  State<ButtonCreateTask> createState() => _ButtonCreateTaskState();
}

class _ButtonCreateTaskState extends State<ButtonCreateTask> {
  late TextEditingController _textEditingController;
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<String?> openDialog() async {
    final String? text = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(child: Text('Новая задача')),
        actions: [
          TextField(
            autofocus: true,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            controller: _textEditingController,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ElevatedButton.icon(
                label: const Text('Добавить'),
                onPressed: () async {
                  final text = _textEditingController.text.trim();

                  Navigator.of(context).pop(text);

                  _textEditingController.clear();
                },
              ),
            ),
          )
        ],
      ),
    );
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final String? text = await openDialog();
        if (text != null && context.mounted) {
          context.read<HomeBloc>().add(HomeCreateTask(text: text));
        }
      },
      child: const Icon(Icons.add),
    );
  }
}
