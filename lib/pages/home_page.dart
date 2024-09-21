import 'package:event_planner_app/components.dart';
import 'package:event_planner_app/pages/Events/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
class HomePage extends StatefulWidget {
  final int eventIndex;
  const HomePage({super.key, required this.eventIndex});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box<Event> eventBox = Hive.box<Event>('event');
  Event? thisEvent;
@override
  void initState() {
    // TODO: implement initState
  thisEvent = eventBox.getAt(widget.eventIndex);
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
  double widthDevice= MediaQuery.of(context).size.width;
  double heightDevice= MediaQuery.of(context).size.height;
  double tileHeight= heightDevice/8;
  double tileWidth= widthDevice/3.5;




  return SafeArea(
    child: Scaffold(
      backgroundColor: mainColor,
        appBar: AppBar(
          backgroundColor:Colors.purple ,
          centerTitle: true,
          title: Manrope(text: "Home Page",size: 25.0,weight: FontWeight.bold,),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Wrap(
            runSpacing:widthDevice/10,
            spacing: widthDevice/10,
            children: [
              Image.asset("assets/images/Eventium_nobg.png",width: widthDevice,height: 200,),
              HomeTile(height: tileHeight,width: tileWidth, tileIcon: CupertinoIcons.money_dollar_circle_fill,tileName: "Budget",perform: (){
                Navigator.of(context).pushNamed("/budget",arguments: widget.eventIndex);

              },),
              HomeTile(height: tileHeight,width: tileWidth, tileIcon: Icons.store_sharp,tileName: "Vendors",perform: (){},),
              HomeTile(height: tileHeight,width: tileWidth, tileIcon: Icons.people,tileName: "Guests",perform: (){
                Navigator.of(context).pushNamed('/guests',arguments: widget.eventIndex );
              },),
              HomeTile(height: tileHeight,width: tileWidth, tileIcon: Icons.task_outlined,tileName: "Tasks",perform: (){
                Navigator.of(context).pushNamed("/todo",arguments: widget.eventIndex);
              },),
              HomeTile(height: tileHeight,width: tileWidth, tileIcon: Icons.schedule_outlined,tileName: "Schedule",perform: (){},),
              HomeTile(height: tileHeight,width: tileWidth, tileIcon: CupertinoIcons.house_fill,tileName: "Venue",perform: (){},),

            ],),
        ),
      ),
  ) ;
  }
}
