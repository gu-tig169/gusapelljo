import 'package:flutter/material.dart';
import 'package:flutter/Material.dart';
import 'package:uuid/uuid.dart';

import './api.dart';

class TodoItem {
  String todoText;
  bool isChecked;
  String id;

  TodoItem({this.id, this.todoText, this.isChecked = false});
}

class AppState extends ChangeNotifier {
  var uuid = Uuid();

  List<TodoItem> _todoItemList = [];
  List<TodoItem> get list => _todoItemList;

  //get latest list from server
  Future getList() async {
    List<TodoItem> list = await TodoApi.getTodoItems();
    _todoItemList = list;
    notifyListeners();
  }

  //filter the tasks shown in the app
  List<TodoItem> listFromFilter(String filter) {
    switch (filter) {
      case "Done":
        return _todoItemList.where((todo) => todo.isChecked == true).toList();
        break;
      case "Undone":
        return _todoItemList.where((todo) => todo.isChecked == false).toList();
        break;
      default:
        return _todoItemList;
    }
  }

  //add item
  void addTodo(TodoItem todo) async {
    todo.id = uuid.v4();
    _todoItemList.add(todo);
    TodoApi.addTodoItem(todo);
    await getList();
  }

  //remove item
  void deleteTodo(TodoItem todo) async {
    _todoItemList.remove(todo);
    TodoApi.deleteTodoItem(todo);
    await getList();
  }
}
