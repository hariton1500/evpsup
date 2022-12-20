import 'package:evpsup/models/person.dart';
import 'package:evpsup/models/task.dart';
import 'package:flutter/material.dart';

class Raspred extends StatefulWidget {
  const Raspred({Key? key, required this.tasks, required this.persons})
      : super(key: key);
  final List<Task> tasks;
  final List<Person> persons;

  @override
  State<Raspred> createState() => _RaspredState();
}

class _RaspredState extends State<Raspred> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Распределение задач между сотрудниками'),
      ),
      body: Wrap(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
              child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.persons
                .map(
                  (p) => DragTarget<Task>(
                    onAccept: (t) {
                      setState(() {
                        if (!p.tasks.contains(t)) p.tasks.add(t);
                        if (!t.persons.contains(p)) t.persons.add(p);
                      });
                    },
                    builder: (context, candidateData, rejectedData) {
                      return p.card();
                    },
                  ),
                )
                .toList(),
          )),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.tasks
                  .map(
                    (t) => DragTarget<Person>(
                      onAccept: (p) {
                        setState(() {
                          if (!p.tasks.contains(t)) p.tasks.add(t);
                          if (!t.persons.contains(p)) t.persons.add(p);
                        });
                      },
                      builder: (context, candidateData, rejectedData) {
                        return t.card();
                      },
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
