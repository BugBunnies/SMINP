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
                            Colors.purple[500],
                            Colors.purple[500],
                            Colors.purple[600],
                            Colors.purple[700],
                            Colors.purple[800],
                            Colors.purple[900],
                            Colors.white,
                          ],
                          stops: [ 0.05,0.1,0.15,0.2,0.25,0.3,0.3],
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
                              'Chill Menu',
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
                          decoration: BoxDecoration(
                            color : Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20), topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0)),
                              boxShadow: [
                          BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: Offset(4, 7), // changes position of shadow
                      ),
]
                              
                      ),
                            padding: const EdgeInsets.all(8),
                            child: Text(value.toString()),

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