import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import './model.dart';

const API_URL = "https://todoapp-api-vldfm.ondigitalocean.app";
const API_KEY = "3ec2d3c6-7371-44f5-b2dc-0aae341a4c43";

//send a todo to the server
class TodoApi {
  static Future addTodoItem(TodoItem todoItem) async {
    Map<String, dynamic> jsonTodo = {
      "id": todoItem.id,
      "title": todoItem.todoText,
      "done": todoItem.isChecked
    };
    var body = jsonEncode(jsonTodo);
    await http.post("$API_URL/todos?key=$API_KEY",
        body: body, headers: {'Content-Type': 'application/json'});
  }

  //update a todo on the server
  static Future updateTodoItem(TodoItem todoItem) async {
    Map<String, dynamic> jsonTodo = {
      "id": todoItem.id,
      "title": todoItem.todoText,
      "done": todoItem.isChecked
    };
    String id = todoItem.id;
    var body = jsonEncode(jsonTodo);
    await http.put("$API_URL/todos/$id?key=$API_KEY",
        body: body, headers: {'Content-Type': 'application/json'});
  }

  //delete a todo on the server
  static Future deleteTodoItem(TodoItem todoItem) async {
    String id = todoItem.id;
    await http.delete("$API_URL/todos/$id?key=$API_KEY");
  }

  //display the whole list currently on the server
  static Future<List<TodoItem>> getTodoItems() async {
    var httpresponse = await http.get("$API_URL/todos?key=$API_KEY");
    var json = jsonDecode(httpresponse.body);
    List<TodoItem> todoList = json.map<TodoItem>((data) {
      return TodoItem(
          id: data['id'], todoText: data['title'], isChecked: data['done']);
    }).toList();
    return todoList;
  }
}
