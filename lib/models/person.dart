import 'package:evpsup/models/task.dart';
import 'package:flutter/material.dart';

class Person {
  String name;
  List<Task> tasks = [];

  Person({required this.name});

  Card card() {
    return Card(
      color: Colors.green,
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
                    feedback: Card(child: Text(name)),
                    child: Card(
                      color: Colors.amber,
                      child: Text('$name:'),
                    )),
                ...tasks
                    .map((t) => Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Card(
                            color: Colors.orange,
                            child: Text(t.address),
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
