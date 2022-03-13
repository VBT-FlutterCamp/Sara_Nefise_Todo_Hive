import 'package:app_hive/feature/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../feature/model/todo_model.dart';

class TodoForm extends StatefulWidget {
  final TodoList? todo;
  final Function(String name, DateTime createdDate, List<String> type)
      onClickedDone;

  const TodoForm({
    Key? key,
    this.todo,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  String select = 'personal';
  DateTime _datetime = DateTime.now();
  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      final todo = widget.todo!;
      nameController.text = todo.taskName;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.todo != null;
    final title = isEditing ? 'Edit Todo Item' : 'Add Todo Item';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 8),
              buildName(),
              const SizedBox(height: 8),
              buildDate(),
              const SizedBox(height: 8),
              buildDropdownButtons(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What us ti be done?',
        ),
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Enter Task Here',
              suffixIcon: Icon(Icons.task)),
          validator: (name) =>
              name != null && name.isEmpty ? 'Enter a name' : null,
        )
      ],
    );
  }

  Widget buildDate() {
    return Row(children: [
      Text( DateFormat.yMMMd().format((_datetime))),
      TextButton(
        onPressed: () {
          showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100))
              .then((date) => setState(() {
                    _datetime = date ?? DateTime.now();
                  }));
        },
        child: Icon(Icons.date_range),
      ),
    ]);
  }

  Widget buildDropdownButtons() => DropdownButton<String>(
        value: select,
        icon: const Icon(Icons.arrow_downward),
        elevation: 10,
        style: const TextStyle(color: Colors.deepPurple),
        onChanged: (String? newValue) {
          setState(() {
            select = newValue!;
          });
        },
        items: type.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: const Text('Back'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final name = nameController.text;

          widget.onClickedDone(name, _datetime, type);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
