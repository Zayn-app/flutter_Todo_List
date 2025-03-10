class ToDo {
  String? id;
  String? todoText;
  bool isDone;
  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'GO TO GYM', isDone: true),
      ToDo(id: '02', todoText: 'WORK WITH ZEYNEP', isDone: true),
      ToDo(
        id: '03',
        todoText: 'MAKE CAKE FOR KIDS',
      ),
      ToDo(id: '04', todoText: 'CLEAN UP ROOM'),
      ToDo(id: '05', todoText: 'GO FOR A WALK'),
    ];
  }
}
