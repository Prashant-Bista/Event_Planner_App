import 'package:event_planner_app/business_logic.dart';
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
    final provider = ref.watch(stateProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const FrenchCannon(text:"Schedule", color: Colors.white,weight: FontWeight.bold,),
      ),
      body: ValueListenableBuilder(valueListenable: eventBox.listenable(), builder: (context,Box<Event> box,widget){
        Event? thisEvent = eventBox.getAt(eventIndex);
        if(thisEvent!.eventSchedule.isEmpty){
          return const Center(child: FrenchCannon(text: "No Schedule yet",size: 30.0,));
        }
        else{
          return  ListView.builder(itemCount:thisEvent.eventSchedule.length,itemBuilder: (context,index){
           return Column(
             children: [
               SizedBox(height: 20,),
               GestureDetector(
                 onTap: (){
                       showDialog(context: context, builder: (context){
                         return
                           EventAlert(eventIndex: eventIndex, isSchedule: true, isUpdate: true,itemIndex: index,);
                       });
                     },
                 child:
                 ListTile(
                   shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(25)
                   ),
                   tileColor: light_dusty_rose,
                   // trailing: ,
                   title: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [  FrenchCannon(text: thisEvent.eventSchedule[index].title),
                         FrenchCannon(

                           text: "Time remaining: ${provider.timeRemaining(thisEvent.eventSchedule[index].completeWithin,)}",size: 13.0,)]
                   ),
                   trailing: RemoveButton(onPressed: (){
            provider.removeSchedule(index, thisEvent);
            }),
                 )

               )],
           );

          }
          );
        }
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){

        showDialog(context: context, builder: (BuildContext context){
          return EventAlert(eventIndex: eventIndex, isSchedule: true, isUpdate: false,);
        });

      }, child: const Icon(Icons.add),),
    );
  }
}
