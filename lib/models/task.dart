import 'dart:convert';

import 'package:evpsup/models/person.dart';
import 'package:flutter/material.dart';

enum TaskTypes { fix, connection, reconstruction }

class Task {
  late int id;
  late int abonId;
  late int vlan;
  late TaskTypes type;
  late String text;
  late String address;
  late DateTime creationDate;
  List<String> comments = [];
  List<Person> persons = [];

  Task(
      {required this.id,
      required this.abonId,
      required this.vlan,
      required this.type,
      required this.text,
      required this.address,
      required this.creationDate});

  String toJson() {
    return json.encode({
      'id': id,
      'abonId': abonId,
      'vlan': vlan,
      'type': type.name,
      'text': text,
      'address': address,
      'creationDate': creationDate.toString(),
      'comments': comments,
      //'persons': persons
    });
  }

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    abonId = json['abonId'];
    vlan = json['vlan'];
    type = json['type'];
    text = json['text'];
    address = json['address'];
    creationDate = DateTime.parse(json['creationDate']);
    comments = List.from(json['comments'] as List<String>);
    persons = List.from(json['persons'] as List<Person>);
  }

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
