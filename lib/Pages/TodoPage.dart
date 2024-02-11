import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Classes_freezed/Todo.dart';
import 'AddPage.dart';

class TodoPage extends StatefulWidget {
  TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  var now = DateTime.now();
  late List<Todo> todoInstanceList = [];
  List<String> todoList = ["Wake up on time", "Morning exercise", "English conversation", "Solve 1 Todo a day"];

  @override
  Widget build(BuildContext context) {
    List<Widget> checkedList = [];
    List<Widget> uncheckedList = [];

    for (int index = 0; index < todoInstanceList.length; index++) {
      Widget tile = Dismissible(
        key: Key(todoInstanceList[index].content),
        onDismissed: (direction) {
          setState(() {
            todoInstanceList.removeAt(index);
            Todo.saveList(todoInstanceList);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Todo deleted"),
              duration: Duration(seconds: 2),
            ),
          );
        },
        background: Container(
          alignment: Alignment.centerRight,
          color: Colors.red,
          child: Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        child: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          selected: todoInstanceList[index].checked,
          activeColor: Colors.grey,
          title: Text(todoInstanceList[index].content),
          value: todoInstanceList[index].checked,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                todoInstanceList[index] =
                    todoInstanceList[index].copyWith(checked: value);
                Todo.saveList(todoInstanceList);
              });
            }
          },
        ),
      );

      if (todoInstanceList[index].checked) {
        uncheckedList.add(tile);
      } else {
        checkedList.add(tile); 
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("PureTask", style: TextStyle(fontWeight: FontWeight.bold)), 
        backgroundColor: Colors.pink.shade50,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "${DateFormat('yyyy-MM-dd').format(now)}",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
            ),
            Text(
              "${DateFormat('EEEE').format(now)}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            const Divider(),
            ...checkedList,
            ...uncheckedList,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) =>
                      AddPage(todoInstanceList))) // 리스트를 넘겨주며 페이지 이동
              .then((value) {
            Todo.saveList(todoInstanceList);
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
