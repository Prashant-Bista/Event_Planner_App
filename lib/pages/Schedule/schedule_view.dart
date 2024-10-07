import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components.dart';
import '../Events/event.dart';

class ScheduleView extends ConsumerWidget {
  final int eventIndex;
  const ScheduleView({super.key,required this.eventIndex});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    Box<Event> eventBox = Hive.box<Event>('event');
    return Scaffold(
      backgroundColor: dusty_rose,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: muave,
        title: const FrenchCannon(text:"Schedule", color: Colors.white,weight: FontWeight.bold,),
        elevation: 20.0,
        shadowColor: Colors.grey,
      ),
      body: ValueListenableBuilder(valueListenable: eventBox.listenable(), builder: (context,Box<Event> box,widget){
        Event? thisEvent = eventBox.getAt(eventIndex);
        if(thisEvent!.eventSchedule.isEmpty){
          return const Center(child: FrenchCannon(text: "No Schedule yet",size: 30.0,));
        }
        else{
          return  ListView.builder(itemCount:thisEvent!.eventSchedule.length,itemBuilder: (context,index){
            return EventWindow(isSchedule: true, eventIndex: eventIndex,box:box,isUpdate: true,index:index);}
          );
        }
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){

        showDialog(context: context, builder: (BuildContext context){
          return EventAlert(eventIndex: eventIndex, isSchedule: true, isUpdate: false,itemIndex: 0,);
        });

      }, child: const Icon(Icons.add),),
    );
  }
}
