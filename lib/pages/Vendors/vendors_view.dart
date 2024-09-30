import 'package:event_planner_app/business_logic.dart';
import 'package:event_planner_app/components.dart';
import 'package:event_planner_app/pages/Todo/tasks.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../Events/event.dart';

class VendorsView extends ConsumerWidget {
  final int eventIndex;
  const VendorsView({super.key, required this.eventIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(stateProvider);
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    TextEditingController titleController = TextEditingController();
    return Scaffold(
      backgroundColor: dusty_rose,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: muave,
        title: const FrenchCannon(
          text: "Vendors",
          color: Colors.white,
        ),
        elevation: 20.0,
        shadowColor: Colors.grey,
      ),
      body: ValueListenableBuilder(
        valueListenable: eventBox.listenable(), // Listen to the eventBox
        builder: (context, Box<Event> box, _) {
          thisEvent = box.getAt(eventIndex); // Update thisEvent on change

          if (thisEvent!.eventTasks.isEmpty) {
            return const Center(
              child: FrenchCannon(
                text: "No Vendors added yet",
                size: 30.0,
                color: Color.fromRGBO(11, 13, 23, 1),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: thisEvent!.eventTasks.length,
                itemBuilder: (context, index) {
                  Tasks task = thisEvent!.eventTasks[index];
                  return ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                    ),
                    tileColor: light_dusty_rose,
                    // trailing: ,
                    title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [BulletoKilla(text: thisEvent!.eventName,),
                          ScheduleFont(text: "On :   ${thisEvent!.eventDate!.year}/${thisEvent!.eventDate!.month}/${thisEvent!.eventDate!.day}        At ${thisEvent!.eventDate!.hour}:${thisEvent!.eventDate!.minute<10?"0${thisEvent!.eventDate!.minute}":thisEvent!.eventDate!.minute}")
                        ]
                    ),
                    trailing: RemoveButton(onPressed: (){}),
                  );
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(11, 13, 23, 1),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          CommonAlert(context, eventIndex, "Task", provider);
        },
      ),
      bottomNavigationBar: BottomBar(eventIndex: eventIndex),
    );
  }
}
