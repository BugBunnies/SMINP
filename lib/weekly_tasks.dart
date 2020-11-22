import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'all.dart';

// Weekly Tasks
class WeeklyTasks extends StatefulWidget
{
  @override
  _WeeklyTasksState createState() => _WeeklyTasksState();
}

class _WeeklyTasksState extends State<WeeklyTasks> {

  final List<String> entries = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  final List<int> colorCodes = <int>[100, 200, 300, 400, 500, 600, 700];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Stack(
        alignment: Alignment.center,

        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image(
                image : AssetImage('background.png'),
                fit: BoxFit.fitWidth,
              )
          ),

          Positioned(
            child:
            Text("Weekly Tasks", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
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
                      itemCount: entries.length,
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index){
                        return GestureDetector(
                          // When the child is tapped, show a snackbar.
                            onTap: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (BuildContext context) => Calendar.string(entries[index])));
                            },
                            child: Container(

                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40), topLeft: Radius.circular(40),
                                    bottomRight: Radius.circular(40.0), bottomLeft: Radius.circular(40.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color : Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(4, 5), // changes position of shadow
                                  ),
                                ],

                              ),
                              height:80,
                              child: Center(
                                  child: Text('${entries[index]}',style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold))),

                            )
                        );

                      }, separatorBuilder: (BuildContext context, int index) => const Divider(),
                      controller: scrolController,
                    ),
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