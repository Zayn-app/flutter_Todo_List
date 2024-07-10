import 'package:flutter/material.dart';
import 'package:to_do_app/const/colors.dart';
import 'package:to_do_app/widgets/todo.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem(
      {super.key,
      required this.todo,
      this.onToDoChanged,
      this.onDeleteItem,
      required Null Function(dynamic todo) onEditItem});

  final ToDo todo;
  // ignore: prefer_typing_uninitialized_variables
  final onToDoChanged;
  // ignore: prefer_typing_uninitialized_variables
  final onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: todo.isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 70,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              //Clicked on delete icon
              onDeleteItem(todo.id);
            },
            icon: const Icon(
              Icons.delete,
              size: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
