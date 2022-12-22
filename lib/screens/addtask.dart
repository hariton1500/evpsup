import 'package:evpsup/models/task.dart';
import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  Task task = Task(
    type: TaskTypes.reconstruction,
    text: '',
    address: '',
    abonId: -1,
    creationDate: DateTime.now(),
    id: DateTime.now().millisecondsSinceEpoch,
    vlan: -1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавление задачи:'),
      ),
      body: Column(
        children: [
          const Text('Описание задачи:'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: const Color.fromARGB(255, 181, 199, 182),
              child: TextField(
                  maxLines: 5,
                  controller: TextEditingController(text: task.text),
                  onChanged: (value) {
                    task.text = value;
                  }),
            ),
          ),
          const Text('Адрес:'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: const Color.fromARGB(255, 181, 199, 182),
              child: TextField(
                  maxLines: 2,
                  controller: TextEditingController(text: task.address),
                  onChanged: (value) {
                    task.address = value;
                  }),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(task),
              icon: const Icon(Icons.add),
              label: const Text('Добавть задачу'))
        ],
      ),
    );
  }
}
