import 'package:event_planner_app/business_logic.dart';
import 'package:event_planner_app/components.dart';
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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const FrenchCannon(
          text: "Vendors",
          color: Colors.white,
          weight: FontWeight.bold,
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: eventBox.listenable(), // Listen to the eventBox
        builder: (context, Box<Event> box, _) {
          thisEvent = box.getAt(eventIndex); // Update thisEvent on change
          provider.counterVendor(eventIndex);

          if (thisEvent!.eventVendors.isEmpty) {
            return const Center(
              child: FrenchCannon(
                text: "No Vendors added yet",
                size: 25.0,
                color: Color.fromRGBO(11, 13, 23, 1),
              ),
            );
          } else {
            return CommonFilledWindow(thisEvent: thisEvent!, isGuest: false, eventIndex: eventIndex);

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
          showDialog(context: context, builder: (BuildContext context){
            return GuestAlert(eventIndex: eventIndex, isUpdate: false, itemIndex: 0, isVendor: true);

          });        },
      ),
      bottomNavigationBar: BottomBar(eventIndex: eventIndex),
    );
  }
}
