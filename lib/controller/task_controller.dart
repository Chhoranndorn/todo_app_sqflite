import 'package:get/get.dart';
import 'package:todo_app_sqlite/db/db_helper.dart';
import 'package:todo_app_sqlite/model/task_model.dart';

class TaskController extends GetxController {
  final DBHelper dbHelper = DBHelper();
  List<Task> tasks = [];

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() async {
    tasks = await dbHelper.getTasks();
    update(); // update UI for GetBuilder
  }

  void addTask(String title) async {
    if (title.trim().isEmpty) return;
    await dbHelper.insertTask(Task(title: title));
    loadTasks();
  }

  void toggleDone(Task task) async {
    await dbHelper.updateTask(
        Task(id: task.id, title: task.title, isDone: task.isDone == 0 ? 1 : 0));
    loadTasks();
  }

  void deleteTask(int id) async {
    await dbHelper.deleteTask(id);
    loadTasks();
  }
}
