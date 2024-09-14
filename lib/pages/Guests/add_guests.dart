import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../components.dart';
import 'guests.dart';
class AddGuests extends StatefulWidget {
  const AddGuests({super.key});

  @override
  State<AddGuests> createState() => _AddGuestsState();
}

class _AddGuestsState extends State<AddGuests> {
  Box<Guests> guestBox = Hive.box<Guests>("guests");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Manrope(text:"Guest Manaement", color: Colors.white,),
        elevation: 20.0,
        shadowColor: Colors.grey,
      ),
      body: ValueListenableBuilder(valueListenable: guestBox.listenable(), builder: (context,Box box, widget){
        if (box.isEmpty) {
          return Center(child: Manrope(text: "No Guests added yet",size: 35.0,color: Color.fromRGBO(11, 13, 23, 1),));
        }
        else
        {
          return ListView.builder(itemCount:  box.length,itemBuilder:(context,index){
            Guests guest = box.getAt(index);
            return GuestList(contact: guest.contact, memberNo: '${guest.membersNo}', name: guest.guestName, isInvited: guest.invited);
          });

          };

        }

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(11, 13, 23, 1),
        child: Icon(Icons.add,color:Colors.white,),
        onPressed: (){
          setState(() {
            GuestAlert(context);
          });
        },),
    );
  }
}
