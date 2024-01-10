// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../Classes_freezed/Todo.dart';
// import 'AddPage.dart';

// class TodoPage extends StatefulWidget {
//   TodoPage({Key? key}) : super(key: key);

//   @override
//   State<TodoPage> createState() => _TodoPageState();
// }

// class _TodoPageState extends State<TodoPage> {
//   var now = DateTime.now();
//   late List<Todo> todoInstanceList = [];
//   List<String> todoList = ["늦지않게 기상", "아침운동", "영어회화", "1일 1Todo 해결"];

//   @override
//   Widget build(BuildContext context) {
//     List<CheckboxListTile> listTileList = makeListTileList();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Simple Todo"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Text(
//               "${DateFormat('yyyy-MM-dd').format(now)}",
//               style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
//             ),
//             Text(
//               "${DateFormat('EEEE').format(now)}",
//               style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
//             ),
//             Divider(),
//             ...listTileList,
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context)
//               .push(MaterialPageRoute(
//                   builder: (context) =>
//                       AddPage(todoInstanceList))) // 리스트를 넘겨주며 페이지이동
//               .then((value) {
//             Todo.saveList(todoInstanceList);
//             setState(() {});
//           });
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   List<CheckboxListTile> makeListTileList() {
//     List<CheckboxListTile> checkedList = [];
//     List<CheckboxListTile> uncheckedList = [];

//     for (Todo todoInstance in todoInstanceList) {
//       CheckboxListTile tile = CheckboxListTile(
//         controlAffinity: ListTileControlAffinity.leading,
//         selected: todoInstance.checked,
//         activeColor: Colors.grey,
//         title: Text(todoInstance.content),
//         value: todoInstance.checked,
//         onChanged: (value) {
//           if (value != null) {
//             setState(() {
//               todoInstanceList.remove(todoInstance);
//               todoInstanceList.add(todoInstance.copyWith(checked: value));
//               Todo.saveList(todoInstanceList);
//             });
//           }
//         },
//       );

//       if (todoInstance.checked) {
//         checkedList.add(tile);
//       } else {
//         uncheckedList.add(tile);
//       }
//     }

//     return [...uncheckedList, ...checkedList];
//   }
// }

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
        title: const Text("Simple Todo"),
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
                      AddPage(todoInstanceList))) // Pass the list while navigating
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
