import 'package:event_planner_app/business_logic.dart';
import 'package:event_planner_app/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components.dart';
import 'event.dart';

class EventPage extends ConsumerWidget {
  const EventPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AuthenticationService auth = AuthenticationService();
    final provider = ref.watch(stateProvider);
    provider.eventRefresh();
    Box<Event> event = Hive.box<Event>('event');
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
          auth.signOut(context);
        }, icon: const Icon(Icons.logout))],
        title: const FrenchCannon(
          text: "Events",
          color: Colors.white,
          weight: FontWeight.bold,
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: event.listenable(),
        builder: (context, Box<Event> box, widget) {
          if (box.isEmpty) {
            return const Center(
                child: FrenchCannon(text: "No Events yet", size: 30.0));
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                Event thisEvent =
                    box.getAt(index)!; // Make sure to make thisEvent nullable
                // Check if the event is not null
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    InkWell(
                      splashColor: darkDustyRose,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/home', arguments: index);
                      },
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        tileColor: lightDustyRose,
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FrenchCannon(text: thisEvent.eventName),
                            FrenchCannon(
                              text:
                                  "On :${thisEvent.eventDate!=null? '${thisEvent.eventDate!.year}/${thisEvent.eventDate!.month}/${thisEvent.eventDate!.day}':'No date'} "
                                  "At ${thisEvent.eventDate!=null? '${thisEvent.eventDate!.hour}:${thisEvent.eventDate!.minute < 10 ? '0${thisEvent.eventDate!.minute}' : thisEvent.eventDate!.minute}':'No time'}",
                            ),
                          ],
                        ),
                        trailing: RemoveButton(
                          onPressed: () {
                            provider.removeEvent(index);
                          },
                        ),
                      ),
                    ),
                  ],
                );
                            },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const EventAlert(
                  isSchedule: false,
                  isUpdate: false,
                  eventIndex: null,
                  itemIndex: null,
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
