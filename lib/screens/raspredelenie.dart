import 'package:flutter/material.dart';

class Raspred extends StatefulWidget {
  const Raspred({Key? key}) : super(key: key);

  @override
  State<Raspred> createState() => _RaspredState();
}

class _RaspredState extends State<Raspred> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Row(),
      ),
    );
  }
}