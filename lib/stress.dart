import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'all.dart';
import 'globals.dart';

class Stressometer extends StatefulWidget {
  @override
  State<StatefulWidget> createState () {
    return _HomeState();
  }
}

class _HomeState extends State<Stressometer> {
  @override
  Widget build (BuildContext context) {
    int sum=0, i = 0;
    // print(megaTasks.length);
    megaTasks[DateTime.now().weekday - 1].forEach((num)=> sum+=num.stressLevel);
    megaTasks[DateTime.now().weekday - 1].forEach((index)=> i++);
    double avg;
    if(i != 0)
      avg = sum/i;
    else avg = 0.0;
    String stringValue = avg.toStringAsPrecision(2);
    //in order to remove the stressful tasks
    //hope stress level would be from 0 to 100
    bool avgMandatory = sumOfMandatory();//check if svg mandatory > 50 => no need to try to remove tasks
    if(avg > 5 && avgMandatory == true){
      //level of stress greater than avg permitted for a day
      //=>remove the most stressful task that is not mandatory, then compute again avg
      return AlertDialog(
        title : Text("Average Stress Level Exceeded"),
        content: Text("Do you want to remove a non-mandatory, stressful task?"),
        actions: [
          FlatButton(
            child:Text("No"),
            onPressed: (){Navigator.of(context).pop();},
          ),
          FlatButton(child:Text("Yes"),
              onPressed:(){
                removeStressfulTasks(megaTasks, avg);
                setState(() {
                  writeList();
                });
                Navigator.of(context).pop();
              }),
        ],
        elevation: 24.0,
        backgroundColor: Colors.amber[200],
      );
    }
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
              width: 400,
              height: 600,
              child: Image(
                image : AssetImage('background.png'),
                fit: BoxFit.contain,
              )
          ),
          Positioned(
            child:
            Text("Wellness Statistics", style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),),
            top: 40,
            left: 20,
          ),

          Positioned(
            child:
            Container(
              child: Center(
                  child: Text('Today\'s stress level \n               $stringValue',style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold))),
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.deepPurple[600],
                borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40),bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
              ),
            ),

            top: 130,
            left: 55,
          ),
        ],
      ),
      drawer: SideMenu([Calendar(), WeeklyTasks(), Stressometer()]),
    );
  }

  //function that removes stressful activities until everything is ok
  void removeStressfulTasks(List<List<Task>> megaTasks, double i) {
    var listOfNonMandatoryTasks = GetListOfNonMandatory();
    int index = 0;
    while (i > 5 && listOfNonMandatoryTasks != null && listOfNonMandatoryTasks.length != 0){
      //after removing one stressful activity we could be still above max avg
      int maximum = -1;
      //find max in list of stresses
      //bool mandatory = false;
      for(var j=0; j < listOfNonMandatoryTasks.length; j++){
        if(maximum < listOfNonMandatoryTasks[j]){
          maximum = listOfNonMandatoryTasks[j];
        }
      }

      print("maximum: $maximum");

      for (var i = 0; i < listOfNonMandatoryTasks.length; i++){
        if (maximum == megaTasks[DateTime
            .now()
            .weekday - 1][i].stressLevel)
          index = i;
      }
      int sum = 0;
      int nr = 0;
      for(var i = 0; i < listOfNonMandatoryTasks.length; i++) {
        if (index != i) {
          sum = sum + listOfNonMandatoryTasks[i];
          nr = nr + 1;
        }
      }
      i = sum/nr;
      print("index: $index");
      listOfNonMandatoryTasks.removeAt(index);
    }
    RemoveElementFromMegaTasks(listOfNonMandatoryTasks, index);
  }

  bool sumOfMandatory() {
    int sum = 0;
    int nr=0;
    for(int i = 0; i < megaTasks[DateTime.now().weekday-1].length; i++) {
      if (megaTasks[DateTime.now().weekday - 1][i].isMandatory) {
        sum = sum + megaTasks[DateTime
            .now()
            .weekday - 1][i].stressLevel;
        nr = nr + 1;
      }
    }

    double avg = sum/nr;
    print("AVG IS");
    print(avg);
    if(avg > 5)
      return false;
    else
      return true;
  }

  List<int> GetListOfNonMandatory() {
    //List<Task> list;
    var list = List<int>();
    for(var i=0; i<megaTasks[DateTime.now().weekday - 1].length; i++){
      if(!megaTasks[DateTime.now().weekday - 1][i].isMandatory){
        list.add(megaTasks[DateTime.now().weekday - 1][i].stressLevel);
      }
    }
    for(var e in list)
      print(e);
    return list;
  }

  void RemoveElementFromMegaTasks(List<int> listOfNonMandatoryTasks, int index) {
    setState(() {
      megaTasks[DateTime
          .now()
          .weekday - 1].removeAt(index);});
  }
}