import 'package:hive/hive.dart';

import '../../feature/model/todo_model.dart';

class Boxes {
  static Box<TodoList> getTransactions() => Hive.box<TodoList>('todolists');
}
//required