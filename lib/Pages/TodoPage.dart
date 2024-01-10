import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<String> todoList = ["늦지않게 기상", "아침운동", "영어회화", "1일 1Todo 해결"];

  @override
  Widget build(BuildContext context) {
    List<CheckboxListTile> listTileList = makeListTileList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Todo"),
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
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
            ),
            Divider(),
            ...listTileList,
          ],
        ),
      ),
            floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => AddPage(todoInstanceList))) // 리스트를 넘겨주며 페이지이동
              .then((value) {
                Todo.saveList(todoInstanceList);
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  List<CheckboxListTile> makeListTileList() {  //인스턴스 메소드 : 인스턴스가 갖고 있는 메소드.
    List<CheckboxListTile> list = [];

    for (Todo todoInstance in todoInstanceList) {
      list.add(
        CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            selected: todoInstance.checked,
            activeColor: Colors.grey,
            title: Text(
              todoInstance.content,
            ),
            value: todoInstance.checked,
            onChanged: (gueguegue) {
              if (gueguegue != null) {
                todoInstanceList.remove(todoInstance);
                todoInstanceList.add(todoInstance.copyWith(checked: gueguegue));              
              }
              Todo.saveList(todoInstanceList);
              setState(() {});
            }),
      );
    }
    return list;
  }
}
