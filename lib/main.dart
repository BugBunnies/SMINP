import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'all.dart';

void main() {
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