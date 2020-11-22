library sminp.globals;

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Task{
  String taskName;
  int stressLevel;
  DateTime taskDateTime;
  bool isMandatory;

  Task(this.taskName, this.stressLevel, this.taskDateTime, this.isMandatory);

  @override
  String toString(){
    return this.taskName + ";" + this.stressLevel.toString() + ";" +
    this.taskDateTime.toString() + ";" + this.isMandatory.toString();
  }

}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/tasks.txt');
}

Task stringToTask(String str){
  var contents = str.split(';');

  return new Task(contents[0], int.parse(contents[1]),
      DateTime.parse(contents[2]), (contents[3] == "true"));
}

final days = <String>[
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

int getInt(String day){
  for(int i = 0; i < days.length; ++i)
    if(days[i] == day)
      return i;
}

Future<List<List<Task>>> readList() async {
  try{
    final file = await _localFile;
    List<String> contents = await file.readAsLines();

    for(int i = 0; i < contents.length; ++i){
      Task activeTask = stringToTask(contents[i]);
      print(activeTask.toString());
      megaTasks[activeTask.taskDateTime.weekday - 1].add(activeTask);
    }
  }
  catch (e){
    return Future.value(null);
  }
}

Future<File> writeList() async {
  final file = await _localFile;

  String text = "";

  for(int i = 0; i < 7; ++i)
    for(int j = 0; j < megaTasks[i].length; ++j)
      text += megaTasks[i][j].toString() + "\n";

  file.writeAsString(text);

  return file;
}

List<List<Task>> megaTasks;

void initList(){
  for(int i = 0; i < 7; ++i){
    megaTasks.add(new List<Task>());
  }
  readList();
}
