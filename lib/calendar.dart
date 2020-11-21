import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'all.dart';

//optimized to use one list for tasks
class Task{
  String taskName;
  int stressLevel;

  Task(this.taskName, this.stressLevel);
}

List<Task> tasks = List<Task>();

//second screen ->schedule
class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  final TextEditingController eCtrl = new TextEditingController();
  @override
  Widget build (BuildContext ctxt) {
    final List<Color> colorCodes = <Color>[Colors.lightBlue, Colors.cyan,
      Colors.teal, Colors.green, Colors.lightGreen, Colors.lime, Colors.yellow,
      Colors.orange, Colors.deepOrange, Colors.red];
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
            Text("Today's tasks", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
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
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                    ),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(10),
                      itemCount: tasks.length,
                      itemBuilder: (context, index){

                        final item = tasks[index];
                        return Dismissible(
                          key: Key(item.taskName),
                          onDismissed: (direction){
                            setState(() {
                              tasks.removeAt(index);
                            });
                          },
                          child: Container(decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: colorCodes[tasks[index].stressLevel % (colorCodes.length + 1) - 1],
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40), topLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40.0), bottomLeft: Radius.circular(40.0)),
                            boxShadow: [
                              BoxShadow(
                                color: colorCodes[tasks[index].stressLevel % (colorCodes.length + 1) - 1].withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 4,
                                offset: Offset(7, 5), // changes position of shadow
                              ),
                            ],

                          ),
                            height: 70,
                            child: Center(child: ListTile(
                              title: Text("${tasks[index].taskName}", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),),
                              subtitle: Text("Text box of the task", style: TextStyle(color: Colors.grey[700]),),
                              trailing: Icon(Icons.check_circle, color: Colors.greenAccent,),
                              isThreeLine: true,
                            )),
                          ),
                          background: Container(
                            color: Colors.red,
                          ),
                        );
                        // return ListTile(
                        //   title: Text("Task's name", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),),
                        //   subtitle: Text("Text box of the task", style: TextStyle(color: Colors.grey[700]),),
                        //   trailing: Icon(Icons.check_circle, color: Colors.greenAccent,),
                        //   isThreeLine: true,
                        // );
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
                          return showDialog(context: context, builder:(dialogContext) {
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
                                            labelText: "Stress Level",
                                            fillColor: Colors.white,
                                            border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                              ),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          //   controller: new TextEditingController(),
                                          onSubmitted: (text) {
                                            setState(() {
                                              final activeTask = Task(nameController.text,
                                                  int.parse(text));
                                              tasks.add(activeTask);
                                              eCtrl.clear();
                                            });
                                            Navigator.of(context).pop();
                                          }
                                      )]
                                )
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
      drawer: SideMenu([Calendar(), WeeklyTasks()]),
    );
  }
}