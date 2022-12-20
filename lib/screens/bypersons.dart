import 'package:evpsup/models/person.dart';
import 'package:evpsup/models/task.dart';
import 'package:flutter/material.dart';

class ByPersons extends StatefulWidget {
  const ByPersons({Key? key, required this.tasks, required this.persons}) : super(key: key);
  final List<Task> tasks;
  final List<Person> persons;

  @override
  State<ByPersons> createState() => _ByPersonsState();
}

class _ByPersonsState extends State<ByPersons>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.persons.map((e) => Card(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.name),
                  //...widget.tasks.map((e) => Text(e.text)).toList()
                ],
              ),
            ),
          )).toList()
        ),
      ),
    );
  }
}