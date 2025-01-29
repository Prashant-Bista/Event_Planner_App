import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner_app/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../pages/Events/event.dart';

class DatabaseService {
  late FirebaseFirestore db;
  late String? _userId;

  DatabaseService() {
    db = FirebaseFirestore.instance;
    _userId = FirebaseAuth.instance.currentUser?.uid;
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
    DocumentReference docref= await db.collection("Users").doc(_userId).collection("Events").add({"guest_no":thisEvent!.guestsCount,"name":thisEvent.eventName,"tasks_no":thisEvent.eventTasks.length,"vendors_no":thisEvent.vendorsCount,"expense":thisEvent.eventBudget.total_expenses,"presence":true,"venue_cost":0,"selected_venue":thisEvent.eventVenue!.venueId});
    thisEvent.eventId=docref.id;

  }
  Future<void> eventRefresh() async {
    Box<Event> event = Hive.box("event");
    if (_userId != "") {
      QuerySnapshot querySnap = await db.collection("Users").doc(_userId)
          .collection("Events").where("presence", isEqualTo: true)
          .get();
      Set<dynamic> dbEventIds = querySnap.docs.map((docSnap) => docSnap.get("name"))
          .toSet();
      print(dbEventIds);
      for (int i = 0; i < event.length; i++) {
        Event? localEvent = event.getAt(i);
        if (dbEventIds.contains(localEvent!.eventName)==false) {
          await createEvent(i);
        }
      }
      for (DocumentSnapshot docSnap in querySnap.docs) {
        bool isPresent = false;
        for (int i = 0; i < event.length; i++) {
          if (event.getAt(i)!.eventId == docSnap.id) {
            isPresent = true;
          }
        }
        if (isPresent == false) {
          await db.collection("Users").doc(_userId).collection("Events").doc(
              docSnap.id).update({"presence": false});
        }
      }
    }
  }

  Future<void> updateEvent(String _eventId,eventIndex, BuildContext context) async {
      Box<Event> eventBox = Hive.box<Event>('event');
      Event? thisEvent = eventBox.getAt(eventIndex);
      try {
 db.collection("Users").doc(_userId).collection("Events").doc(thisEvent!.eventId).update(
     {"expense":thisEvent.eventBudget.total_expenses});
      } catch (e) {
        alertMessages(context: context, message: e.toString());
      }
    }
  }
