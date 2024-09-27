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
  double tileHeight= heightDevice/9;
  double tileWidth= widthDevice/4.5;

  return SafeArea(
    child: Scaffold(
      backgroundColor: dusty_rose,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: muave,
          title: const Manrope(text:"Home Page", color: Colors.white,weight: FontWeight.bold,),
          elevation: 20.0,
          shadowColor: Colors.grey,
        ),
        body:  Column(
          children: [
          ListTile(
          tileColor: soft_blue_grey,
          // trailing: ,
          title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Manrope(text: thisEvent!.eventName,size: 25.0,weight: FontWeight.bold,),
                Manrope(size:15.0,text: "Scheduled on :   ${thisEvent!.eventDate!.year}/ ${thisEvent!.eventDate!.month}/ ${thisEvent!.eventDate!.day}        At ${thisEvent!.eventDate!.hour}:${thisEvent!.eventDate!.minute<10?"0${thisEvent!.eventDate!.minute}":thisEvent!.eventDate!.minute}")
              ]
          ),
        ),Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Wrap(
                runSpacing:widthDevice/12,
                spacing: widthDevice/12,
                children: <Widget>[
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
          Image.asset("")],
          ),
      bottomNavigationBar: const BottomBar(),

    ),
      );
  }
}
