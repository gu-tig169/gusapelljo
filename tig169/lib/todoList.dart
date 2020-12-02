import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './model.dart';
import './api.dart';

class TodoList extends StatefulWidget {
  final List<TodoItem> list;
  TodoList(this.list);

  @override
  TodoListState createState() => TodoListState();
}

//builds the list in the app
class TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (context, index) => todo(widget.list[index]));
  }

  Widget todo(TodoItem todo) {
    return ListTile(
        leading: Checkbox(
            value: todo.isChecked,
            onChanged: (bool value) {
              setState(() {
                todo.isChecked = value;
              });
              TodoApi.updateTodoItem(todo);
            }),
        title: Text(todo.todoText),
        trailing: RawMaterialButton(
            onPressed: () {
              Provider.of<AppState>(context, listen: false).deleteTodo(todo);
            },
            child: Icon(Icons.delete, size: 30.0)));
  }
}
