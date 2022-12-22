import 'dart:convert';

import 'package:evpsup/models/person.dart';
import 'package:evpsup/models/settings.dart';
import 'package:evpsup/models/task.dart';
import 'package:evpsup/screens/bypersons.dart';
import 'package:evpsup/screens/bytasks.dart';
import 'package:evpsup/screens/raspredelenie.dart';
import 'package:evpsup/screens/setup.dart';
import 'package:flutter/material.dart';

import 'package:evpsup/db/persons.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Система распределения задач EvpaNet'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Settings settings = Settings('');
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    loadSharedPrefs();
    super.initState();
  }

  List<Task> tasks = dbtasks.values.map((e) {
    //print(e);
    return Task(
        text: e['text'].toString(),
        type: e['type'] as TaskTypes,
        address: e['address'].toString(),
        abonId: -1,
        id: dbtasks.values.toList().indexOf(e),
        creationDate: DateTime.now().subtract(const Duration(days: 1)),
        vlan: 4020);
  }).toList();

  List<Person> persons =
      dbpersons.values.map((e) => Person(name: e['name'].toString())).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context)
                  .push<Settings>(MaterialPageRoute(
                      builder: (context) => Setup(settings: settings)))
                  .then((value) {
                if (value != null) {
                  settings = value;
                  //print('saving settings=${settings.toJson()}');
                  sharedPreferences?.setString(
                      'settings', jsonEncode(settings.toJson()));
                }
              });
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ByPersons(tasks: tasks, persons: persons)));
                },
                icon: const Icon(Icons.person_search),
                label: const Text('По сотрудникам')),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ByTasks(tasks: tasks, persons: persons)));
                },
                icon: const Icon(Icons.task),
                label: const Text('По задачам')),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Raspred(
                            settings: settings,
                            persons: persons,
                            tasks: tasks,
                          )));
                },
                icon: const Icon(Icons.add_task),
                label: const Text('Распределение')),
          ),
        ],
      ),
    );
  }

  void loadSharedPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences != null) {
      String jsonString = sharedPreferences?.getString('settings') ?? '';
      //print(jsonString);
      settings = jsonString != ''
          ? Settings.fromJson(jsonDecode(jsonString))
          : Settings('');
    }
    //setState(() {});
  }
}
