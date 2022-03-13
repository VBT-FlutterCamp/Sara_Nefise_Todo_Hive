// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoListAdapter extends TypeAdapter<TodoList> {
  @override
  final int typeId = 0;

  @override
  TodoList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoList()
      ..taskName = fields[0] as String
      ..createdDate = fields[1] as DateTime
      ..type = (fields[2] as List).cast<String>();
  }

  @override
  void write(BinaryWriter writer, TodoList obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.taskName)
      ..writeByte(1)
      ..write(obj.createdDate)
      ..writeByte(2)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
