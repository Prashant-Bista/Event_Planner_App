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
          title: const FrenchCannon(text:"Home Page", color: Colors.white,weight: FontWeight.bold,),
          elevation: 20.0,
        ),
        body:  Column(
          children: [
            SizedBox(
              height: 15,
            ),
        EventTile( eventIndex: widget.eventIndex,isHome: true,onPressed: (){},isUpdate: false,isSchedule: false,index: 0,),
        //   ListTile(
       Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child:
              Column(
                children: [
                  SizedBox(
                    height:heightDevice/2.8,
                    child: Wrap(
                          runSpacing:widthDevice/12,
                          spacing: widthDevice/12,
                          children:[
                            HomeTile(height: tileHeight,width: tileWidth, tileIcon: CupertinoIcons.money_dollar_circle_fill,tileName: "Budget",perform: (){
                              Navigator.of(context).pushNamed("/budget",arguments: widget.eventIndex);
                            },),
                            HomeTile(height: tileHeight,width: tileWidth, tileIcon: Icons.people,tileName: "Guests",perform: (){
                              Navigator.of(context).pushNamed('/guests',arguments: widget.eventIndex );
                            },),
                            HomeTile(height: tileHeight,width: tileWidth, tileIcon: Icons.task_outlined,tileName: "Tasks",perform: (){
                              Navigator.of(context).pushNamed("/todo",arguments: widget.eventIndex);
                            },),
                            HomeTile(height: tileHeight,width: tileWidth, tileIcon: Icons.schedule_outlined,tileName: "Schedule",perform: (){
                              Navigator.of(context).pushNamed('/schedule',arguments: widget.eventIndex );
                  
                            },),
                            HomeTile(height: tileHeight,width: tileWidth, tileIcon: CupertinoIcons.house_fill,tileName: "Venue",perform: (){
                              Navigator.of(context).pushNamed('/venue' ,arguments: widget.eventIndex);

                            },),
                            HomeTile(height: tileHeight,width: tileWidth, tileIcon: Icons.store_sharp,tileName: "Vendors",perform: (){
                              Navigator.of(context).pushNamed('/vendors',arguments: widget.eventIndex);
                            },),
                  
                          ],
                    ),
                  ),
                  Image.asset("assets/images/Eventium_nobg.png",height: 200,width:250,)
                ],
              ),

        ),
          ],
          ),
      bottomNavigationBar: BottomBar(eventIndex:widget.eventIndex,)

    ),
      );
  }
}
