import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.deepPurple[600],
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text("Your current stress level is",
                    style: TextStyle(
                    color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600
                    )
                  )
                )
              ]
            )
          )
        ]
      )
    );
  }
}