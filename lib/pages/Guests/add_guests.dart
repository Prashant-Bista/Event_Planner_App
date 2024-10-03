
import 'package:event_planner_app/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components.dart';
import '../Events/event.dart';
import 'guests.dart';

class AddGuests extends ConsumerWidget {
  final int eventIndex;
  const AddGuests({super.key, required this.eventIndex});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final provider = ref.watch(stateProvider);
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    TextEditingController nameController = TextEditingController();
    TextEditingController contactController = TextEditingController();
    TextEditingController membersController = TextEditingController();
    bool isInvited = false;
    return Scaffold(
      backgroundColor: dusty_rose,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: muave,
        title: const FrenchCannon(text: "Guest Management", color: Colors.white),
        elevation: 20.0,
        shadowColor: Colors.grey,
      ),
      body: ValueListenableBuilder(
        valueListenable:eventBox.listenable(), // Listen to the eventBox
        builder: (context, Box<Event> box, _) {
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
            return ListView.builder(
              itemCount: thisEvent!.eventGuests.length,
              itemBuilder: (context, index) {
                Guests guest = thisEvent!.eventGuests[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GestureDetector(
                      onTap: (){
    showDialog(
    context: context,
    builder: (BuildContext context) {
    return GuestAlert(isUpdate: true, eventIndex: eventIndex,itemIndex: index,isVendor: false,);
                      },
    );
                      },
                      child:    Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: light_dusty_rose,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child:      ListTile(
                          trailing: RemoveButton(onPressed: (){
                            provider.removeGuest(eventIndex, index);
                          },),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: 20,),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FrenchCannon(text: 'Name:',size: 13.0,),
                                  FrenchCannon(text: 'Contact:',size: 13.0),
                                  FrenchCannon(text: 'No of Members:',size: 13.0),
                                  FrenchCannon(text: 'Invitation:',size: 13.0),
                                ],
                              ),
                              const SizedBox(width: 20,),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FrenchCannon(text: guest.guestName,size: 13.0),
                                  FrenchCannon(text: guest.contact,size: 13.0),
                                  FrenchCannon(text: '${guest.membersNo}',size: 13.0),
                                  StatefulBuilder(builder: (context,setState){
                                    return Checkbox(
                                      value: thisEvent!.eventGuests[index].invited,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isInvited = value!;
                                          provider.updateGuest(eventIndex, index, thisEvent!.eventGuests[index].guestName, thisEvent!.eventGuests[index].membersNo, isInvited, thisEvent!.eventGuests[index].contact);
                                        });
                                      },
                                    );

                                  })

                                  // FrenchCannon(text: guest.invited?'Invited':"Not Invited",size: 13.0),

                                ],
                              ),
                            ],
                          ),
                        )  ,
                      )
                  ),
                );
              },
            );
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
