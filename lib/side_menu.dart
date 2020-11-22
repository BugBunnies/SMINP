import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {

  final List<Widget> components;
  SideMenu(this.components);

  final iconList = [Icons.calendar_today, Icons.view_week, Icons.more_time];

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Drawer(
        child: SafeArea(
              child:
                  Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            alignment: Alignment.topCenter,
                            image: AssetImage('image3.png')),
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
                            child: Center(

                              child : Text( 'SMInP HUB',  style: TextStyle(color: Colors.white,fontSize: 24,),
                              ),
                            ),
                          ),
                      ),

                      SizedBox(height: 55),
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

                            child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                        child : Column(
                                children: [
                                  SizedBox(height: 25,),
                                  Icon(
                                    iconList[index++], size: 40,
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                      value.toString()
                                  ),
                                ]
                              ),

                            )
                            )
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