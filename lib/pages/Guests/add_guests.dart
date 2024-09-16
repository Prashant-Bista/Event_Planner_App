
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../components.dart';
import '../Events/event.dart';
import 'guests.dart';

class AddGuests extends StatefulWidget {
  final int eventIndex;
  const AddGuests({super.key, required this.eventIndex});

  @override
  State<AddGuests> createState() => _AddGuestsState();
}

class _AddGuestsState extends State<AddGuests> {
  Box<Event> eventBox = Hive.box<Event>("event");
  Box<Guests> guestBox = Hive.box<Guests>("guests");

  late Event? thisEvent;


  @override
  void initState() {
    super.initState();
    thisEvent = eventBox.getAt(widget.eventIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Manrope(text: "Guest Management", color: Colors.white),
        elevation: 20.0,
        shadowColor: Colors.grey,
      ),
      body: ValueListenableBuilder(
        valueListenable:eventBox.listenable(), // Listen to the eventBox
        builder: (context, Box<Event> box, _) {
          thisEvent = box.getAt(widget.eventIndex); // Update thisEvent on change

          if (thisEvent!.eventGuests.isEmpty) {
            return Center(
              child: Manrope(
                text: "No Guests added yet",
                size: 35.0,
                color: Color.fromRGBO(11, 13, 23, 1),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: thisEvent!.eventGuests.length,
              itemBuilder: (context, index) {
                Guests guest = thisEvent!.eventGuests[index];
                return GuestList(
                  contact: guest.contact,
                  memberNo: '${guest.membersNo}',
                  name: guest.guestName,
                  isInvited: guest.invited,
                  index: index,
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(11, 13, 23, 1),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            GuestAlert(context, widget.eventIndex);
          });
        },
      ),
    );
  }
}
