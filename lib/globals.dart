library sminp.globals;

class Task{
  String taskName;
  int stressLevel;
  DateTime taskDateTime;
  bool isMandatory;
  int period;

  Task(this.taskName, this.stressLevel, this.taskDateTime, this.isMandatory);
}

List<List<Task>> megaTasks;

void initList(){
  for(int i = 0; i < 7; ++i){
    megaTasks.add(new List<Task>());
  }
}