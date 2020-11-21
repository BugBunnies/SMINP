import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'all.dart';

//optimized to use one list for tasks
class Task{
  String taskName;
  int stressLevel;
  DateTime taskDateTime;
  bool isMandatory;
  int period;

  Task(this.taskName, this.stressLevel, this.taskDateTime, this.isMandatory);
}

List<List<Task>> megaTasks = List<List<Task>>();

//second screen -> schedule
class Calendar extends StatefulWidget {

  String date = "";


  Calendar.string(this.date);
  Calendar();

  // @override
  // _CalendarState createState() => _CalendarState();

  @override
  _CalendarState createState() => _CalendarState.string(date);
}

void initList(){
  for(int i = 0; i < 7; ++i){
    megaTasks.add(new List<Task>());
  }
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

class _CalendarState extends State<Calendar> {

  DateTime activeDate = DateTime.now();
  String currentDay;

  _CalendarState.date(this.activeDate);
  _CalendarState.string(this.currentDay);
  _CalendarState(){
    this.activeDate = DateTime.now();
  }

  final TextEditingController eCtrl = new TextEditingController();
  @override
  Widget build (BuildContext ctxt) {

    if(megaTasks.isEmpty)
      initList();

    final List<Color> colorCodes = <Color>[Colors.lightBlue, Colors.cyan,
      Colors.teal, Colors.green, Colors.lightGreen, Colors.lime, Colors.yellow,
      Colors.orange, Colors.deepOrange, Colors.red];

    if(currentDay == "") {
      if (activeDate.day == DateTime.now().day && activeDate.month == DateTime.now().month &&
          activeDate.year == DateTime
              .now()
              .year)
        currentDay = "Today";
      else
        currentDay = days[activeDate.weekday - 1];
    }


    return Scaffold(
      backgroundColor: Colors.deepPurple[600],
      body: Stack(
        alignment: Alignment.center,

        children: <Widget>[
          Container(
              width: 400,
              height: 600,
              child: Image(
                image : AssetImage('image.png'),
                fit: BoxFit.contain,
              )
          ),

          Positioned(
            child:
            Text("${currentDay}'s tasks", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
            top: 40,
            left: 20,
          ),

          DraggableScrollableSheet(
            maxChildSize: 0.85,
            minChildSize: 0.1,
            builder: (BuildContext context, ScrollController scrolController){
              return Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top:10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                    ),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(10),
                      itemCount: megaTasks[DateTime.now().weekday - 1].length,
                      itemBuilder: (context, index){
                        return OnSlide(
                            items: <ActionItems>[
                              new ActionItems(icon: new IconButton(
                                  icon: new Icon(Icons.delete),
                                  onPressed: () {}, color: Colors.red,
                                ),
                                onPress: (){}, backgroudColor: Colors.white),
                              new ActionItems(icon: new IconButton(
                                icon: new Icon(Icons.edit),
                                onPressed: () {}, color: Colors.green,
                              ),
                                  onPress: (){}, backgroudColor: Colors.white)
                            ],
                            child: Container(
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: colorCodes[megaTasks[DateTime.now().weekday - 1][index].stressLevel % (colorCodes.length + 1) - 1].withOpacity(0.7),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40), topLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40.0), bottomLeft: Radius.circular(40.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: colorCodes[megaTasks[DateTime.now().weekday - 1][index].stressLevel % (colorCodes.length + 1) - 1].withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(4, 5), // changes position of shadow
                                ),
                              ],

                            ),
                              height: 80,
                              child: Center(
                                  child: ListTile(
                                    title: Text("${megaTasks[DateTime.now().weekday - 1][index].taskName}", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold)),
                                    subtitle: Text("Text box of the task", style: TextStyle(color: Colors.grey[700]),),
                                    trailing: Icon(Icons.check_circle, color: Colors.greenAccent,),
                                    isThreeLine: true,
                                  )),
                            ),
                        );
                      },
                      controller: scrolController,
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                    ),
                  ),

                  Positioned(
                    child: FloatingActionButton(
                        child: Icon(Icons.add, color: Colors.white,),
                        backgroundColor: Colors.pinkAccent,
                        onPressed: (){
                          final nameController = TextEditingController();
                          final stressLevelController = TextEditingController();
                          final hourController = TextEditingController();
                          final minuteController = TextEditingController();

                          return showDialog(context: context, builder:(dialogContext) {

                            bool _isMandatory = false;

                            //alert dialog button to submit whatever the user wrote
                            Widget okButton = FlatButton(
                                onPressed: () {
                                  setState(() {
                                    final activeTask = Task(nameController.text,
                                        int.parse(stressLevelController.text),
                                        DateTime.now(), _isMandatory);
                                    int hour = int.parse(hourController.text);
                                    int minute = int.parse(minuteController.text);
                                    activeTask.taskDateTime = DateTime(activeTask.taskDateTime.year,
                                        activeTask.taskDateTime.month, activeTask.taskDateTime.day,
                                        hour, minute);
                                    megaTasks.elementAt(DateTime.now().weekday - 1).add(activeTask);
                                    Navigator.of(context, rootNavigator: true).pop();
                                  });
                                },
                                child: Text("Add Task")
                            );

                            return AlertDialog(
                                title : Text("Input the Stress Level "),
                                content: Column(
                                    children: [
                                      TextField(
                                        decoration: new InputDecoration(
                                          labelText: "Enter task: ",
                                          fillColor: Colors.white,
                                          border: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                            ),
                                          ),
                                        ),
                                        controller: nameController,
                                      ),
                                      TextField(
                                          decoration: new InputDecoration(
                                            labelText: "Stress Level: ",
                                            fillColor: Colors.white,
                                            border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                              ),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          controller: stressLevelController,
                                      ),
                                      TextField(
                                        decoration: new InputDecoration(
                                          labelText: "Hour: ",
                                          fillColor: Colors.white,
                                          border: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                            ),
                                          ),
                                        ),
                                        keyboardType: TextInputType.datetime,
                                        controller: hourController,
                                      ),
                                      TextField(
                                        decoration: new InputDecoration(
                                          labelText: "Minute: ",
                                          fillColor: Colors.white,
                                          border: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                            ),
                                          ),
                                        ),
                                        keyboardType: TextInputType.datetime,
                                        controller: minuteController,
                                      ),
                                      CheckboxListTile(
                                          title: Text("Is your task mandatory?"),
                                          tristate: true,
                                          value: _isMandatory,
                                          onChanged: (bool value) {
                                            setState(() {
                                              _isMandatory = !_isMandatory;
                                            });
                                        },
                                      ),
                                    ],
                                ),
                              actions: [
                                okButton
                              ],
                            );
                          });
                        }
                    ),
                    top: -30,
                    right: 30,
                  )
                ],
              );
            },
          )

        ],
      ),
      drawer: SideMenu([Calendar(), WeeklyTasks(), Stressometer()]),
    );
  }
}