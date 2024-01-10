import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'Todo.freezed.dart';
part 'Todo.g.dart';

@freezed
class Todo with _$Todo {
  factory Todo({
    required String content,
    required bool checked,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  const Todo._(); //커스텀하기 위한 조건.
  static const todoListPrefskey = 'todoList';
  static Future<void> saveList(List<Todo> todoInstanceList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String jsonStr = jsonEncode(todoInstanceList);
    prefs.setString(todoListPrefskey, jsonStr);
  }

  static Future<List<Todo>> loadList() async {
    List<Todo> todoInstanceList = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? todoListStr = prefs.getString(
        todoListPrefskey); // '[{content:"아침러닝",checked:true},{content:"아침러닝",checked:false}]'
    if (todoListStr != null) {
      List<dynamic> todoList = jsonDecode(todoListStr);
      for (Map<String, dynamic> todo in todoList) {
        Todo todoInstance = Todo.fromJson(todo);
        todoInstanceList.add(todoInstance);
      }
    }
    return todoInstanceList;
  }
}
