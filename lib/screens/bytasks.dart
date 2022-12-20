import 'package:evpsup/models/person.dart';
import 'package:evpsup/models/task.dart';
import 'package:evpsup/screens/addtask.dart';
import 'package:flutter/material.dart';

class ByTasks extends StatefulWidget {
  const ByTasks({Key? key, required this.tasks, required this.persons})
      : super(key: key);
  final List<Task> tasks;
  final List<Person> persons;

  @override
  State<ByTasks> createState() => _ByTasksState();
}

class _ByTasksState extends State<ByTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton.icon(
        icon: const Icon(
          Icons.add,
          //color: Colors.blue,
        ),
        onPressed: () {
          Navigator.of(context)
              .push<Task>(
                  MaterialPageRoute(builder: (context) => const AddTask()))
              .then((value) {
            if (value != null) {
              setState(() {
                widget.tasks.add(value);
              });
            }
          });
        },
        label: const Text('Добавть отдельную задачу'),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.tasks.map((t) => t.card()).toList()),
      ),
    );
  }
}
