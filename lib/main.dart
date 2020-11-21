import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'all.dart';
import 'globals.dart';

void main() {
      megaTasks = new List<List<Task>>();
      if(megaTasks.isEmpty)
            initList();
      runApp(MaterialApp(
            theme:
            ThemeData(
                primaryColor: Colors.lightBlue,
                accentColor: Colors.black12
            ),
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
      ));
}