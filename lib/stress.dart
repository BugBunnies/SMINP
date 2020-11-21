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
    megaTasks[DateTime.now().weekday - 1].forEach((num)=> sum+=num.stressLevel);
    megaTasks[DateTime.now().weekday - 1].forEach((index)=> i++);
    double avg;
    if(i != 0)
      avg = sum/i;
    else avg = 0.0;
    String stringValue = avg.toStringAsPrecision(2);
    return Scaffold(
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
}