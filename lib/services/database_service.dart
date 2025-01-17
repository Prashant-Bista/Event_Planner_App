import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner_app/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../pages/Events/event.dart';

class DatabaseService {
  late FirebaseFirestore db;
  late String _userId;

  DatabaseService() {
    db = FirebaseFirestore.instance;
  }

  Future<void> createuser(BuildContext context, String _uid, String name,
      
      String email, String phoneNo) async {
    _userId= _uid;
    try {
      await db.collection("Users").doc(_uid).set(
          {"email": email, "name": name, "phone_no": phoneNo});
    } catch (e) {
      alertMessages(context: context, message: e.toString());
    }
  }
  Future<void> createEvent(int eventIndex)async{
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    Map<String,dynamic> venue= db.collection("Venues").where("index",isEqualTo: 2).get() as Map<String,dynamic>;
    print(venue);
    await db.collection("Users").doc(_userId).collection("Events").add({"guest_no":thisEvent!.guestsCount,"name":thisEvent.eventName,"selected_venue":thisEvent.eventVenue!.selectedDocumentIndex,"":thisEvent.eventTasks.length,"vendors_no":thisEvent.vendorsCount,});
    
  }
    Future<void> updateEvent(String _eventId,eventIndex, BuildContext context) async {
      Box<Event> eventBox = Hive.box<Event>('event');
      Event? thisEvent = eventBox.getAt(eventIndex);
      try {
        Future<QuerySnapshot> dbEvent= db.collection("Users").doc(_userId).collection("Events").where("name",isEqualTo: thisEvent!.eventName).get();

      } catch (e) {
        alertMessages(context: context, message: e.toString());
      }
    }
  }
