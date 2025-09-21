import 'package:animated_todo_app/Bloc/todo_bloc.dart';
import 'package:animated_todo_app/Bloc/todo_events.dart';
import 'package:animated_todo_app/Bloc/todo_state.dart';
import 'package:animated_todo_app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  void _showAddDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Todo"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter todo..."),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<TodoBloc>().add(AddTodo(controller.text));
              }
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, Todo todo) {
    final controller = TextEditingController(text: todo.title);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Todo"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "New title"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              context.read<TodoBloc>().add(EditTodo(todo.id, controller.text));
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animated Todo")),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state.todos.isEmpty) {
            return const Center(child: Text("No todos yet"));
          }
          return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (context, index) {
              final todo = state.todos[index];
              return Dismissible(
                key: Key(todo.id.toString()),
                background: Container(
                  color: Colors.blue,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20),
                  child: const Icon(Icons.edit, color: Colors.white),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    _showEditDialog(context, todo);
                    return false; // Prevent dismiss for edit
                  } else {
                    context.read<TodoBloc>().add(DeleteTodo(todo.id));
                    return true;
                  }
                },
                child: ListTile(
                  onTap: () {
                    context.read<TodoBloc>().add(ToggleTodo(todo.id));
                  },
                  tileColor: todo.isCompleted
                      ? Colors.green.withOpacity(0.2)
                      : null,
                  leading: todo.isCompleted
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(
                          Icons.radio_button_unchecked,
                          color: Colors.grey,
                        ),
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
