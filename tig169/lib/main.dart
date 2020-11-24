import 'package:flutter/material.dart';

import 'lkp_sorting.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final List<Items> _todoItems = [];
  final List<String> _todoItems = [];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Lkp_sorting.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: ListView(children: _buildTodoList()),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _popUp(context),
          tooltip: 'Add Item',
          child: Icon(Icons.add)),
    );
  }

  //PopupMenu
  void choiceAction(String choice) {
    if (choice == Lkp_sorting.All) {
      print(Lkp_sorting.All);
    } else if (choice == Lkp_sorting.Done) {
      print(Lkp_sorting.Done);
    } else if (choice == Lkp_sorting.Undone) {
      print(Lkp_sorting.Undone);
    }
  }

  // Build the todo list
  List<Widget> _buildTodoList() {
    bool isChecked = true;
    final List<Widget> _todoWidgets = <Widget>[];
    for (String todoText in _todoItems) {
      _todoWidgets.add(_buildTodoItem(todoText, isChecked));
    }
    return _todoWidgets;
  }

  Widget _buildTodoItem(String todoText, bool isChecked) {
    return ListTile(
        leading: Checkbox(
            value: isChecked,
            onChanged: (bool value) {
              isChecked = value;
            }),
        title: Text(todoText));
  }

  // Build a todo item
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
                    _addTodoItem(_textFieldController.text);
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

  void _addTodoItem(String todoText) {
    setState(() {
      _todoItems.add(todoText);
    });
    _textFieldController.clear();
  }
}
