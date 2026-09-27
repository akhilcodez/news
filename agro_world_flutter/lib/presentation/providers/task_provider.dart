import 'package:flutter/material.dart';
import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository.dart';

class TaskProvider extends ChangeNotifier {
  final TaskRepository _repository = TaskRepository();

  List<TaskModel> _tasks = [];
  bool _isLoading = false;

  List<TaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading;
  int get maxId => _tasks.isEmpty ? 1 : _tasks.map((e) => e.id).reduce((a, b) => a > b ? a : b) + 1;

  TaskProvider() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _tasks = await _repository.getTasks();
    } catch (_) {}

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTask({
    required String task,
    required String desc,
    required String date,
    required String time,
    required String priority,
  }) async {
    final newTask = TaskModel(
      id: maxId,
      task: task,
      desc: desc,
      date: date,
      time: time,
      priority: priority,
      isCompleted: false,
    );

    await _repository.addTask(newTask);
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await _repository.deleteTask(id);
    await loadTasks();
  }

  Future<void> toggleCompleted(int id) async {
    await _repository.toggleTaskCompleted(id);
    await loadTasks();
  }
}
