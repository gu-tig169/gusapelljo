/*
Kom in sent i denna kurs och har inte hunnit med mer än detta. 

Det går att lägga till items på listan. 
Nästa steg är att skapa en sida där man matar in information för itemet man vill lägga till i listan.


*/

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo app with list',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'ToDo List'),
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
  List<String> _todoItems = [];

  void _addTodoItem() {
    setState(() {
      int index = _todoItems.length;
      _todoItems.add('Item ' + index.toString());
    });
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildTodoItem(_todoItems[index]);
      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText) {
    return ListTile(title: Text(todoText));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
          onPressed: _addTodoItem, tooltip: 'Add task', child: Icon(Icons.add)),
    );
  }
}
