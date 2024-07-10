import 'package:flutter/material.dart';
import 'package:to_do_app/const/colors.dart';
import 'package:to_do_app/model/todo_item.dart';
import 'package:to_do_app/widgets/todo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();
  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo));
    });
    _todoController.clear();
  }

  void _editToDoItem(ToDo todo, String newToDoText) {
    setState(() {
      todo.todoText = newToDoText;
    });
  }

  void _displayEditDialog(BuildContext context, ToDo todo) {
    final _editController = TextEditingController(text: todo.todoText);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit To-Do'),
          content: TextField(
            controller: _editController,
            decoration: const InputDecoration(hintText: "Edit to-do"),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                _editToDoItem(todo, _editController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _appBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                    child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 50,
                        bottom: 20,
                      ),
                      child: const Text(
                        'To-Do List',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w100),
                      ),
                    ),
                    for (ToDo todoo in _foundToDo.reversed)
                      ToDoItem(
                        todo: todoo,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem: _deleteToDoItem,
                        onEditItem: (todo) {
                          _displayEditDialog(context, todo);
                        },
                      ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  bottom: 20, right: 20, left: 20),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 10,
                                      spreadRadius: 0.0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: _todoController,
                                decoration: const InputDecoration(
                                  hintText: 'Add a New Item',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: 20, right: 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: tdRed,
                                  minimumSize: const Size(60, 60),
                                  elevation: 10),
                              onPressed: () {
                                _addToDoItem(_todoController.text);
                              },
                              child: const Text(
                                '+',
                                style: TextStyle(
                                    fontSize: 23, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => runFilter(value),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              maxWidth: 25,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: tdGrey)),
      ),
    );
  }
}

AppBar _appBar() {
  return AppBar(
    backgroundColor: tdBGColor,
    elevation: 0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.menu),
        SizedBox(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            
          ),
        )
      ],
    ),
  );
}
