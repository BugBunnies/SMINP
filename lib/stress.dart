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
    return Scaffold(
      body:
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.deepPurple[600],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                    Text("Your current stress level is:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                  SizedBox(height: 20),
                    Text("70",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 70.0,
                          fontWeight: FontWeight.w600,
                        )
                    )
                  ],
              ),
          ),
        drawer: SideMenu([Calendar(), WeeklyTasks(), Stressometer()]),
    );
  }
}