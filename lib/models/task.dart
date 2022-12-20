enum TaskTypes {fix, connection, reconstruction}
class Task {
  TaskTypes type;
  String text;
  String address;
  

  Task({required this.type, required this.text, required this.address});
}