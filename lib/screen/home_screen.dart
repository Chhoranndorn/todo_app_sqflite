import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_sqlite/controller/task_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App with GetX',
      home: TodoHome(),
    );
  }
}

class TodoHome extends StatelessWidget {
  TodoHome({super.key});

  final TaskController taskController = Get.find();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(labelText: 'Add task'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    taskController.addTask(_controller.text);
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<TaskController>(
              builder: (controller) {
                if (controller.tasks.isEmpty) {
                  return const Center(child: Text('No tasks found'));
                }

                return ListView.builder(
                  itemCount: controller.tasks.length,
                  itemBuilder: (_, i) {
                    final task = controller.tasks[i];
                    return ListTile(
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.isDone == 1
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      leading: Checkbox(
                          value: task.isDone == 1,
                          onChanged: (_) => controller.toggleDone(task)),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => controller.deleteTask(task.id!),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
