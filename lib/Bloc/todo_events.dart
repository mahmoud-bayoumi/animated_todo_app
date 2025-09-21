abstract class TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;
  AddTodo(this.title);
}

class EditTodo extends TodoEvent {
  final int id;
  final String newTitle;
  EditTodo(this.id, this.newTitle);
}

class DeleteTodo extends TodoEvent {
  final int id;
  DeleteTodo(this.id);
}

class ToggleTodo extends TodoEvent {
  final int id;
  ToggleTodo(this.id);
}
