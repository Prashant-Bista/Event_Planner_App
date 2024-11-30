
import 'package:event_planner_app/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components.dart';
import '../Events/event.dart';

class AddGuests extends ConsumerWidget {
  final int eventIndex;
  const AddGuests({super.key, required this.eventIndex});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final provider = ref.watch(stateProvider);
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const FrenchCannon(text: "Guest Management", color: Colors.white),
      ),
      body: ValueListenableBuilder(
        valueListenable:eventBox.listenable(), // Listen to the eventBox
        builder: (context, Box<Event> box, _) {
          provider.counterGuests(eventIndex);
          thisEvent = box.getAt(eventIndex); // Update thisEvent on change

          if (thisEvent!.eventGuests.isEmpty) {
            return const Center(
              child: FrenchCannon(
                text: "No Guests added yet",
                size: 25.0,
                color: Color.fromRGBO(11, 13, 23, 1),
              ),
            );
          } else {
            return CommonFilledWindow(thisEvent: thisEvent!, isGuest: true, eventIndex: eventIndex);

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
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return GuestAlert(isUpdate: false, eventIndex: eventIndex,itemIndex:0,isVendor: false,);
              },
          );
        },
      ),
      bottomNavigationBar: BottomBar(eventIndex: eventIndex),
    );
  }
}
