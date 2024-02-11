import 'package:flutter/material.dart';
import '../Classes_freezed/Todo.dart';

class AddPage extends StatefulWidget {
  List<Todo> todoList;

  AddPage(this.todoList, {super.key}); //생성자... 특별한 함수.

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              textInputAction: TextInputAction.next,
              controller: myController,
              decoration: InputDecoration(labelText: 'Write down your task'),
            ),
            OutlinedButton(
                onPressed: () {
                  widget.todoList
                      .add(Todo(content: myController.text, checked: false));
                  Navigator.of(context).pop();
                },
                child: Text('Add'))
          ],
        ),
      ),
    );
  }
}
