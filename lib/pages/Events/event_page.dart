import 'package:event_planner_app/pages/Budget/budget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import '../../components.dart';
import 'event.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  TextEditingController nameController = TextEditingController();
  DateTime? picked;
  Box<Event> event = Hive.box<Event>('event');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dusty_rose,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: muave,
        title: const FrenchCannon(text:"Events", color: Colors.white,weight: FontWeight.bold,),
        elevation: 20.0,
        shadowColor: Colors.grey,
      ),
      body: ValueListenableBuilder(valueListenable: event.listenable(), builder: (context,Box box,widget){
        if(box.isEmpty){
          return const Center(child: FrenchCannon(text: "No Events yet",size: 30.0,));
        }
        else{
          return ListView.builder(itemCount:box.length,itemBuilder: (context,index){
            return EventWindow(isSchedule: false, eventIndex: index, box: box,isUpdate: false,index: index,);}
          );
        }
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){

          picked=null;
          showDialog(context: context, builder: (BuildContext context){
            return EventAlert(eventIndex: 0, isSchedule: false, isUpdate: false,itemIndex: 0,);
          });

      }, child: const Icon(Icons.add),),
    );
  }
}
