import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoList extends HiveObject {
  //Hive object save ve delete işleminin türetilmesi için kullanıldı
  @HiveField(0)
  late String taskName;
  @HiveField(1)
  late DateTime createdDate;
  @HiveField(2)
  late List<String> type;
}

List<String> type = ["personal", "shopping", "wishlist", "work"];
