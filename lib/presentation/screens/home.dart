import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:test_soft_to_do/core/functions/setup_dependencies.dart';
import 'package:test_soft_to_do/domain/entities/task.dart';
import 'package:test_soft_to_do/domain/state/home_store.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = sl<HomeStore>();
    return Observer(
      builder: (_) => store.isLoading
          ? const CircularProgressIndicator()
          : const HomeScreenView(),
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
    return Observer(builder: (context) {
      final tasks = sl<HomeStore>().tasks.toList();
      return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TaskWidget(
            task: task,
          );
        },
      );
    });
  }
}

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, required this.task});
  final Task task;
  @override
  Widget build(BuildContext context) {
    final store = sl<HomeStore>();
    return ListTile(
      title: Text(task.name),
      onTap: () {
        store.updateTask(task.id!, task.selected);
      },
      leading: task.selected == 0
          ? const Icon(Icons.check_box_outline_blank)
          : const Icon(Icons.check_box_outlined),
      trailing: IconButton(
        onPressed: () {
          store.deleteTask(task.id!);
        },
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

  @override
  Widget build(BuildContext context) {
    final store = sl<HomeStore>();
    return FloatingActionButton(
      onPressed: () {
        showDialog(
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
                      await store.createTask(text);
                      _textEditingController.clear();
                      if (mounted) {
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
