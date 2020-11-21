import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {

  final List<Widget> components;
  SideMenu(this.components);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
              child:
                  Container(
                    decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.topCenter,
                          colors: [
                            Colors.blueAccent,
                            Colors.lightGreen,
                            Colors.white,
                          ],
                          stops: [0.2, 0.3, 0.2],
                          radius: 2,
                        ),
                    ),
                    child:
                  Column(
                    children: <Widget> [
                      Container(
                        //comically large width to ensure that the header is the size
                        //of the menu
                          width: 10000,
                          height: 100,
                          child:
                          DrawerHeader(
                            child: Text(
                              'More options',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          )
                      ),
                  GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    children: components.map((value){
                      return new GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => value)
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Text(value.toString()),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blue,
                            ),
                          )
                      );
                    }).toList(),
                  ),
                ])
                  )
        ),
            );
  }
}