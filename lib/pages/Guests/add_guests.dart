
import 'package:event_planner_app/business_logic.dart';
import 'package:flutter/material.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: const Manrope(text: "Guest Management", color: Colors.white),
        elevation: 20.0,
        shadowColor: Colors.grey,
      ),
      body: ValueListenableBuilder(
        valueListenable:eventBox.listenable(), // Listen to the eventBox
        builder: (context, Box<Event> box, _) {
          thisEvent = box.getAt(eventIndex); // Update thisEvent on change

          if (thisEvent!.eventGuests.isEmpty) {
            return const Center(
              child: Manrope(
                text: "No Guests added yet",
                size: 32.0,
                color: Color.fromRGBO(11, 13, 23, 1),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: thisEvent!.eventGuests.length,
              itemBuilder: (context, index) {
                Guests guest = thisEvent!.eventGuests[index];
                return GestureDetector(
                    onTap: (){
                    },
                    child:    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: const Color.fromRGBO(11, 13, 23, 1,),width: 1.5),
                      ),
                      child:      ListTile(
                        trailing: IconButton(onPressed: (){
                          Event? thisEvent = eventBox.getAt(eventIndex);
                          thisEvent!.eventGuests.removeAt(index);
                          eventBox.putAt(eventIndex, thisEvent);
                        }, icon: const Icon(Icons.dangerous,color: Colors.red,)),
                        title: Row(
                          children: [
                            const SizedBox(width: 20,),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Manrope(text: 'Name:'),
                                Manrope(text: 'Contact:'),
                                Manrope(text: 'No of Members:'),
                                Manrope(text: 'Invitation:'),
                              ],
                            ),
                            const SizedBox(width: 20,),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Manrope(text: guest.guestName),
                                Manrope(text: guest.contact),
                                Manrope(text: '${guest.membersNo}'),
                                Manrope(text: guest.invited?'Invited':"Not Invited"),

                              ],
                            ),
                          ],
                        ),
                      )  ,
                    )
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
                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      title: SizedBox(
                        width: 250,
                        child: Column(
                          children: [
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: "Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3),
                                  borderSide: const BorderSide(style: BorderStyle.solid, width: 1),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: contactController,
                              decoration: InputDecoration(
                                hintText: "Contact No",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3),
                                  borderSide: const BorderSide(style: BorderStyle.solid, width: 1),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: membersController,
                              decoration: InputDecoration(
                                hintText: "No of Members",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3),
                                  borderSide: const BorderSide(style: BorderStyle.solid, width: 1),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)
                              ),
                              tileColor: dusty_rose,
                              trailing: Checkbox(
                                value: isInvited,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isInvited = value!;
                                  });
                                },
                              ),
                              title: const Text("Invited"),
                            ),
                          ],
                        ),
                      ),
                      content: ElevatedButton(
                        onPressed: () {

                          provider.addGuest(eventIndex, nameController.text,int.parse(membersController.text),isInvited,contactController.text);
                          Navigator.pop(context);
                        },
                        child: const Text("Add"),
                      ),
                    );
                  },
                );
              },
          );
        },
      ),
    );
  }
}
