/* 
  Har inte hunnit med mer än detta denna vecka.

  Nu fungerar popup menyn och att lägga till items.
  Nästa steg är att försöka lägga till en checkbox och en sorteringsmeny - plus det som gäller för steg 3. 

*/

import 'package:flutter/material.dart';

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
  final List<String> _todoItems = <String>[];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: ListView(children: _buildTodoList()),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _popUp(context),
          tooltip: 'Add Item',
          child: Icon(Icons.add)),
    );
  }

  void _addTodoItem(String todoText) {
    setState(() {
      _todoItems.add(todoText);
    });
    _textFieldController.clear();
  }

  // Build the todo list
  Widget _buildTodoItem(String todoText) {
    return ListTile(title: Text(todoText));
  }

  List<Widget> _buildTodoList() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (String todoText in _todoItems) {
      _todoWidgets.add(_buildTodoItem(todoText));
    }
    return _todoWidgets;
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
                  _addTodoItem(_textFieldController.text);
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
}
