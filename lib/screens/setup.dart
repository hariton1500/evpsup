import 'package:evpsup/models/settings.dart';
import 'package:flutter/material.dart';

class Setup extends StatefulWidget {
  const Setup({Key? key, required this.settings}) : super(key: key);
  final Settings settings;

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Настройка:'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              color: Colors.blue,
              child: Text('Код доступа:'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.blue,
              child: TextField(
                keyboardType: const TextInputType.numberWithOptions(),
                obscureText: true,
                controller:
                    TextEditingController(text: widget.settings.accessCode),
                onChanged: (text) {
                  widget.settings.accessCode = text;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop(widget.settings);
                },
                icon: const Icon(Icons.save),
                label: const Text('Сохранить код доступа')),
          )
        ],
      ),
    );
  }
}
