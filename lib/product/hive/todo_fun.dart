import '../../feature/model/todo_model.dart';
import 'todo_box.dart';

Future addTransaction(
    String taskname, DateTime createdDate, List<String> type) async {
  final todo = TodoList()
    ..taskName = taskname
    ..createdDate = createdDate
    ..type = type;

  final box = Boxes.getTransactions();
  box.add(todo);
}

void editTransaction(
    TodoList todo, String taskname, DateTime time, List<String> type) {
  todo.taskName = taskname;
  todo.type = type;
  todo.createdDate = time;

  final box = Boxes.getTransactions();
  box.put(todo.key, todo);
  todo.save();
}

void deleteTransaction(TodoList todo) {
  final box = Boxes.getTransactions();
  box.delete(todo.key);
  todo.delete();
  // setState(() => transactions.remove(transaction));
}
