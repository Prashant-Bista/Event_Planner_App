import 'package:event_planner_app/pages/Budget/budget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../components.dart';
import '../Events/event.dart';

class ScheduleView extends ConsumerWidget {
  final int eventIndex;
  const ScheduleView({super.key,required this.eventIndex});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    TextEditingController nameController = TextEditingController();
    DateTime? picked;
    Box<Event> event = Hive.box<Event>('event');
    double deveiceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: dusty_rose,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: muave,
        title: const FrenchCannon(text:"Schedule", color: Colors.white,weight: FontWeight.bold,),
        elevation: 20.0,
        shadowColor: Colors.grey,
      ),
      body: ValueListenableBuilder(valueListenable: event.listenable(), builder: (context,Box<Event> box,widget){
        if(box.isEmpty){
          return const Center(child: FrenchCannon(text: "No Events yet",size: 30.0,));
        }
        else{
          return ListView.builder(itemCount:box.length,itemBuilder: (context,index){
            Event? event = box.getAt(index);
            DateTime? eventDate = event!.eventDate;
            return EventWindow(isSchedule: true, eventIndex: eventIndex,box:box,isUpdate: true,);}
          );
        }
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){

        picked=null;
        showDialog(context: context, builder: (BuildContext context){
          return EventAlert(eventIndex: eventIndex, isSchedule: true, isUpdate: false);
        });

      }, child: const Icon(Icons.add),),
    );
  }
}
