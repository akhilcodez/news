import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../models/task_model.dart';

class TaskRepository {
  Future<List<TaskModel>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(AppConstants.prefTasks);
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final List<dynamic> list = json.decode(jsonString);
        return list.map((e) => TaskModel.fromJson(e)).toList();
      } catch (_) {}
    }

    // Default agricultural routine suggestions matching the original app
    final defaultTasks = [
      TaskModel(
        id: 1,
        task: "Water Wheat Crop (CRI Stage)",
        desc: "Crown root initiation stage at 21 days after sowing. Critical for tiller establishment.",
        date: "28-09-2026",
        time: "07:00 AM",
        priority: "High",
        isCompleted: false,
      ),
      TaskModel(
        id: 2,
        task: "Apply Micronutrient Spray to Tomato",
        desc: "Spray Zinc & Boron foliar solution before flowering phase in early morning.",
        date: "29-09-2026",
        time: "06:30 AM",
        priority: "Medium",
        isCompleted: false,
      ),
      TaskModel(
        id: 3,
        task: "Inspect Pheromone Traps for Fall Armyworm",
        desc: "Count moth count per trap across corn field borders and replace lures if needed.",
        date: "30-09-2026",
        time: "05:00 PM",
        priority: "Low",
        isCompleted: false,
      ),
    ];

    await saveTasks(defaultTasks);
    return defaultTasks;
  }

  Future<void> saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(tasks.map((e) => e.toJson()).toList());
    await prefs.setString(AppConstants.prefTasks, jsonString);
  }

  Future<void> addTask(TaskModel task) async {
    final tasks = await getTasks();
    tasks.insert(0, task);
    await saveTasks(tasks);
  }

  Future<void> deleteTask(int id) async {
    final tasks = await getTasks();
    tasks.removeWhere((t) => t.id == id);
    await saveTasks(tasks);
  }

  Future<void> toggleTaskCompleted(int id) async {
    final tasks = await getTasks();
    final index = tasks.indexWhere((t) => t.id == id);
    if (index >= 0) {
      tasks[index] = tasks[index].copyWith(isCompleted: !tasks[index].isCompleted);
      await saveTasks(tasks);
    }
  }
}
