import 'package:app_hive/feature/model/todo_model.dart';
import 'package:app_hive/product/hive/todo_fun.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import '../../product/hive/todo_box.dart';
import '../../product/widget/todo_form.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<TodoList> transactions = [];

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Todo List Tracker'),
        centerTitle: true,
      ),
      body:
          //  buildContent(transactions),
          ValueListenableBuilder<Box<TodoList>>(
        // hive ekrana bildirme işini listene ile dinleyerek sağlar
        valueListenable: Boxes.getTransactions().listenable(),
        builder: (context, box, _) {
          final transactions = box.values.toList().cast<TodoList>();
          return buildContent(transactions);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
            context: context,
            builder: (context) => const TodoForm(
                  onClickedDone: addTransaction,
                )),
      ));

  Widget buildContent(List<TodoList> transactions) {
    if (transactions.isEmpty) {
      return const Center(
        child: Text(
          'No expenses yet!',
          style: const TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                final transaction = transactions[index];
                return buildTransaction(context, transaction);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildTransaction(BuildContext context, TodoList todo) {
    final date = DateFormat.yMMMd().format(todo.createdDate);
    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          todo.taskName,
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          children: [Text(date)],
        ),

        //trailing: Icon(Icons.check_box),
        children: [
          buildButtons(context, todo),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, TodoList todo) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: const Text('Edit'),
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TodoForm(
                    todo: todo,
                    onClickedDone: (name, date, type) =>
                        editTransaction(todo, name, date, type),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: const Text('Delete'),
              icon: const Icon(Icons.delete),
              onPressed: () => deleteTransaction(todo),
            ),
          )
        ],
      );
}
