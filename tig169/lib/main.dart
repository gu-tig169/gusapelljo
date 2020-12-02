import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './lkpfiltering.dart';
import './model.dart';
import './todoList.dart';

void main() {
  var state = AppState();
  state.getList();
  runApp((ChangeNotifierProvider(
      create: (context) => state, child: ToDoListApp())));
}

class ToDoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textFieldController = TextEditingController();
  String filter = 'All';

  //creates the basic UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String choice) {
              setState(() {
                filter = choice;
              });
            },
            itemBuilder: (BuildContext context) {
              return Lkpfiltering.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _popUp(context),
          tooltip: 'Add Item',
          child: Icon(Icons.add)),
      body: Consumer<AppState>(
          builder: (context, state, child) =>
              TodoList(state.listFromFilter(filter))),
    );
  }

  //popup for adding new todo items
  Future<AlertDialog> _popUp(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add task'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Enter task'),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('ADD'),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (_textFieldController.text.isEmpty) {
                    print("You need to add text!");
                  } else {
                    _addTodoItem(context, _textFieldController.text);
                  }
                },
              ),
              FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  //call the addTodo method
  void _addTodoItem(BuildContext context, String input) {
    Provider.of<AppState>(context, listen: false)
        .addTodo(TodoItem(todoText: input));
    _textFieldController.clear();
  }
}
