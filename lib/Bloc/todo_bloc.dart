import 'package:animated_todo_app/Bloc/todo_events.dart';
import 'package:animated_todo_app/Bloc/todo_state.dart';
import 'package:animated_todo_app/models/todo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  int _idCounter = 0;

  TodoBloc() : super(TodoState([])) {
    on<AddTodo>((event, emit) {
      final newTodo = Todo(id: _idCounter++, title: event.title);
      emit(TodoState([...state.todos, newTodo]));
    });

    on<ToggleTodo>((event, emit) {
      final updated = state.todos.map((todo) {
        if (todo.id == event.id) {
          return todo.copyWith(isCompleted: !todo.isCompleted);
        }
        return todo;
      }).toList();
      emit(TodoState(updated));
    });

    on<EditTodo>((event, emit) {
      final updated = state.todos.map((todo) {
        if (todo.id == event.id) {
          return todo.copyWith(title: event.newTitle);
        }
        return todo;
      }).toList();
      emit(TodoState(updated));
    });

    on<DeleteTodo>((event, emit) {
      final updated = state.todos.where((todo) => todo.id != event.id).toList();
      emit(TodoState(updated));
    });
  }
}
