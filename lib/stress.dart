import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smip/all.dart';


class Stressometer extends StatefulWidget {
  @override
  State<StatefulWidget> createState () {
    return _HomeState();
  }
}

class _HomeState extends State<Stressometer> {
  @override
  Widget build (BuildContext context) {
    final List<int> stresslevels = <int>[100, 75, 20, 32, 40, 120, 65];
    int sum=0, i = 0;
    stresslevels.forEach((num)=> sum+=num);
    stresslevels.forEach((index)=> i++);
    double avg = sum/i;
    i = avg.toInt();
    String stringValue = i.toString();
    return Scaffold(
      body: Stack(
          alignment: Alignment.center,

          children: <Widget>[
          Container(
          width: 400,
          height: 600,
          child: Image(
            image : AssetImage('image2.png'),
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