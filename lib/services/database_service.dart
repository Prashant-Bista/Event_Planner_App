import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner_app/components.dart';
import 'package:event_planner_app/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../pages/Events/event.dart';

class DatabaseService {
  late FirebaseFirestore db;
  late String _userId;

  DatabaseService() {
    db = FirebaseFirestore.instance;
    _userId = FirebaseAuth.instance.currentUser!.uid;
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

    DocumentReference docref= await db.collection("Users").doc(_userId).collection("Events").add({"guest_no":thisEvent!.guestsCount,"name":thisEvent.eventName,"selected_venue":thisEvent.eventVenue!.venueId??"not_added","tasks_no":thisEvent.eventTasks.length,"vendors_no":thisEvent.vendorsCount,"expense":thisEvent.eventBudget.total_expenses,"presence":true,"venuecost":0});
    thisEvent.eventId=docref.id;

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
