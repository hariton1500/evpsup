import 'dart:convert';
import 'dart:io';

import 'package:evpsup/helpers/enums.dart';
import 'package:evpsup/models/person.dart';
import 'package:evpsup/models/settings.dart';
import 'package:evpsup/models/task.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Raspred extends StatefulWidget {
  const Raspred(
      {Key? key,
      required this.tasks,
      required this.persons,
      required this.settings})
      : super(key: key);
  final Settings settings;
  final List<Task> tasks;
  final List<Person> persons;

  @override
  State<Raspred> createState() => _RaspredState();
}

class _RaspredState extends State<Raspred> {
  NetworkStatus status = NetworkStatus.loading;

  Map<Person, Task> newOrders = {};

  @override
  void initState() {
    loadTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Распределение задач между сотрудниками'),
        actions: [
          newOrders.isNotEmpty ? ElevatedButton.icon(onPressed: () {
            sendNewOrders().then((isOk) {
              if (isOk) {
                setState(() {
                  newOrders.clear();
                });
              }
            });
          }, icon: const Icon(Icons.save), label: Text(newOrders.entries.length.toString())) : Container()
        ],
      ),
      body: status == NetworkStatus.done
          ? Wrap(
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
                              if (!p.tasks.contains(t)) {p.tasks.add(t); newOrders[p] = t;}
                              if (!t.persons.contains(p)) {t.persons.add(p);}
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
                                if (!p.tasks.contains(t)) {p.tasks.add(t); newOrders[p] = t;}
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
            )
          : Center(
              child: Card(
                  child: status == NetworkStatus.loading
                      ? const Text('Загрузка...')
                      : ElevatedButton.icon(
                          label: const Text('Повторить запрос'),
                          onPressed: () {
                            setState(() {
                              status = NetworkStatus.loading;
                              loadTasks();
                            });
                          },
                          icon: const Icon(Icons.repeat)))),
    );
  }

  Future<void> loadTasks() async {
    try {
      var response = await http.get(Uri.parse('${widget.settings.url}/gettasks'), headers: {'login': widget.settings.login, 'password': widget.settings.password});
      print(response.body);
      setState(() {
        status = NetworkStatus.done;
      });
    } on SocketException {
      print('socket error');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Нет ответа от сервера')));
      setState(() {
        status = NetworkStatus.none;
      });
    } catch (e) {
      print(e);
    }
  }
  
  Future<bool> sendNewOrders() async {
    try {
      String data = jsonEncode({'persons': newOrders.keys.toList(), 'tasks': newOrders.values.toList()});
      print(data);
      print(json.decode(data));
      var response = await http.post(Uri.parse('${widget.settings.url}/neworders'), body: data);
      if (response.body == 'added new orders.') {
        return true;
      } else {print('bad body text') ;return false;}
    } on SocketException {
      print('socket error');
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
