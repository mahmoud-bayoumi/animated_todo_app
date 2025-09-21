import 'package:animated_todo_app/Bloc/todo_bloc.dart';
import 'package:animated_todo_app/views/todo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => TodoBloc(),
      child: const AnimatedTodoApp(),
    ),
  );
}

class AnimatedTodoApp extends StatelessWidget {
  const AnimatedTodoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animated Todo App',
      home: TodoView(),
    );
  }
}
