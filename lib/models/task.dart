import 'package:evpsup/models/person.dart';
import 'package:flutter/material.dart';

enum TaskTypes { fix, connection, reconstruction }

class Task {
  TaskTypes type;
  String text;
  String address;
  List<Person> persons = [];

  Task({required this.type, required this.text, required this.address});
  Card card() {
    return Card(
      color: Colors.cyan,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Draggable(
                    data: this,
                    feedback: Card(child: Text(address)),
                    child: Card(color: Colors.orange, child: Text(address))),
                ...persons
                    .map((p) => Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Card(
                            color: Colors.amber,
                            child: Text(p.name),
                          ),
                        ))
                    .toList()
              ],
            ),
            //...widget.tasks.map((e) => Text(e.text)).toList()
          ],
        ),
      ),
    );
  }
}
