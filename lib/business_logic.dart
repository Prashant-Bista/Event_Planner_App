

import 'package:event_planner_app/components.dart';
import 'package:event_planner_app/pages/Budget/budget.dart';
import 'package:event_planner_app/pages/Events/event.dart';
import 'package:event_planner_app/pages/Guests/guests.dart';
import 'package:event_planner_app/pages/Schedule/schedule.dart';
import 'package:event_planner_app/pages/Todo/tasks.dart';
import 'package:event_planner_app/pages/Vendors/vendors.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

final stateProvider = ChangeNotifierProvider.autoDispose<BusinessLogic>((ref)=>BusinessLogic());
class BusinessLogic extends ChangeNotifier {
  VoidCallback? removeEvent(int eventIndex){
    Box<Event> eventBox = Hive.box<Event>('event');
    eventBox.deleteAt(eventIndex);
    notifyListeners();
  }
  VoidCallback? AddBudget(int eventIndex, double value) {
    Box<Event> eventBox = Hive.box<Event>('event');

    Event? thisEvent = eventBox.getAt(eventIndex);
    Event? updatedEvent;
    Budget thisBudget = Budget(budget: value, isSet: true);
    updatedEvent = Event(eventTasks: thisEvent!.eventTasks,
        eventExpenses: thisEvent.eventExpenses,
        eventGuests: thisEvent.eventGuests,
        eventName: thisEvent.eventName,
        eventDate: thisEvent.eventDate,
        eventBudget: thisBudget,
        eventVendors: thisEvent.eventVendors,
        vendorsCount: thisEvent.eventVendors.length,
        guestsCount: thisEvent.guestsCount,
        eventSchedule:thisEvent.eventSchedule,
      eventVenue: thisEvent.eventVenue

    );
    eventBox.putAt(eventIndex, updatedEvent);
    notifyListeners();
    return null;
  }

  bool budgetSetCheck(int eventIndex) {
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    return thisEvent!.eventBudget.isSet;
  }

  VoidCallback? addTask(int eventIndex, String task) {
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.eventTasks.add(Tasks(title: task, isDone: false));
    notifyListeners();
    return null;
  }

  VoidCallback? taskCompletion(bool value, int eventIndex, int index) {
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    List<Tasks>? updated = thisEvent!.eventTasks;
    updated[index] =
        Tasks(title: thisEvent.eventTasks[index].title, isDone: value);
    eventBox.putAt(eventIndex, Event(eventBudget: thisEvent.eventBudget,
        eventDate: thisEvent.eventDate,
        eventExpenses: thisEvent.eventExpenses,
        eventGuests: thisEvent.eventGuests,
        eventName: thisEvent.eventName,
        eventTasks: updated,
        eventVendors: thisEvent.eventVendors,
        vendorsCount: thisEvent.eventVendors.length,
        guestsCount: thisEvent.guestsCount,
        eventSchedule:thisEvent.eventSchedule,
        eventVenue: thisEvent.eventVenue

    ));
    notifyListeners();
    return null;
  }

  VoidCallback? taskDelete(int eventIndex, int index) {
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.eventTasks.removeAt(index);
    notifyListeners();
    return null;
  }

  VoidCallback? addGuest(int eventIndex, String name, int members,
      bool isInvited, String contact) {
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    int newGuestCount = thisEvent!.guestsCount + members;
    thisEvent!.guestsCount != thisEvent!.guestsCount + members;
    thisEvent!.eventGuests.add(
      Guests(
        guestName: name,
        membersNo: members,
        invited: isInvited,
        contact: contact,
      ),
    );
    notifyListeners();
    return null;
  }

  VoidCallback? updateGuest(int eventIndex, int guestIndex, String name,
      int members, bool isInvited, String contact) {
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.eventGuests.removeAt(guestIndex);
    thisEvent!.eventGuests.insert(guestIndex,
      Guests(
        guestName: name,
        membersNo: members,
        invited: isInvited,
        contact: contact,
      ),
    );
    notifyListeners();
    return null;
  }

  VoidCallback? addExpense(double value, int eventIndex, String purpose) {
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.eventExpenses.add(Expenses(
        expenses: value,
        purpose: purpose
    ));
    notifyListeners();
    return null;
  }

  double calcBudgetLeft(int eventIndex,) {
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    List<Expenses> expenses = thisEvent!.eventExpenses;
    List<Vendors> vendors = thisEvent!.eventVendors;
    double totalExpense = 0;
    double budgetRemaining;
    for (Expenses expense in expenses) {
      totalExpense = totalExpense + expense.expenses;
    }
    for (Vendors vendor in vendors) {
      totalExpense = totalExpense + vendor.price!;
    }
    budgetRemaining = thisEvent.eventBudget.budget - totalExpense;
    return budgetRemaining;
  }

  VoidCallback? deleteExpense(int eventIndex, index) {
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.eventExpenses.removeAt(index);
    notifyListeners();
  }

  VoidCallback? removeGuest(int eventIndex, int index) {
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.vendorsCount !=
        thisEvent.vendorsCount - thisEvent.eventGuests[index].membersNo;
    thisEvent.eventGuests.removeAt(index);
    notifyListeners();
  }

  VoidCallback? addVendors(int eventIndex, String name, String contact,
      bool isBooked, int price) {
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.eventVendors.add(Vendors(
        name: name, contact: contact, isBooked: isBooked, price: price));
    notifyListeners();
  }

  VoidCallback? updateVendors(int eventIndex, int vendorIndex, String name,
      int price, bool isInvited, String contact) {
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.eventVendors.removeAt(vendorIndex);
    thisEvent!.eventVendors.insert(vendorIndex,
      Vendors(
        name: name,
        price: price,
        isBooked: isInvited,
        contact: contact,
      ),
    );
    notifyListeners();
    return null;
  }

  void counterGuests(int eventIndex) {
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    int totalGuests = 0;
    List<Guests> guests = thisEvent!.eventGuests;
    for (Guests guest in guests) {
      totalGuests = totalGuests + guest.membersNo;
    }
    eventBox.putAt(eventIndex, Event(eventBudget: thisEvent.eventBudget,
        eventExpenses: thisEvent.eventExpenses,
        eventGuests: thisEvent.eventGuests,
        eventTasks: thisEvent.eventTasks,
        eventName: thisEvent.eventName,
        eventDate: thisEvent.eventDate,
        eventVendors: thisEvent.eventVendors,
        vendorsCount: thisEvent.eventVendors.length,
        guestsCount: totalGuests,
        eventSchedule:thisEvent.eventSchedule,
        eventVenue: thisEvent.eventVenue

    ));
    notifyListeners();
  }

  void assignVenue(int eventIndex,int venueIndex,int pricePerplate){
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.eventVenue!.selectedDocumentIndex=venueIndex;
    thisEvent.eventVenue!.venueCost= double.parse(((thisEvent.guestsCount+thisEvent.vendorsCount)*pricePerplate).toString());
    eventBox.putAt(eventIndex, thisEvent);
    notifyListeners();
  }

  void counterVendor(int eventIndex) {
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    int totalGuests = 0;
    List<Guests> guests = thisEvent!.eventGuests;
    for (Guests guest in guests) {
      totalGuests = totalGuests + guest.membersNo;
    }
    eventBox.putAt(eventIndex, Event(eventBudget: thisEvent.eventBudget,
        eventExpenses: thisEvent.eventExpenses,
        eventGuests: thisEvent.eventGuests,
        eventTasks: thisEvent.eventTasks,
        eventName: thisEvent.eventName,
        eventDate: thisEvent.eventDate,
        eventVendors: thisEvent.eventVendors,
        vendorsCount: thisEvent.eventVendors.length,
        guestsCount: totalGuests,
    eventSchedule: thisEvent.eventSchedule,
        eventVenue: thisEvent.eventVenue
    ));
    notifyListeners();
  }

  Future<void> predictBudget(int eventIndex) async{
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    final model = await Interpreter.fromAsset("assets/models/model.tflite");
    var input=[[thisEvent!.guestsCount,thisEvent.eventVenue!.venueCost,thisEvent.eventTasks.length,thisEvent.vendorsCount]];
    var output = List.filled(1, 0).reshape([1,1]);
    model.run(input, output);
    thisEvent.predictedBudget=output[0][0];
    eventBox.putAt(eventIndex, thisEvent);
    notifyListeners();
  }
  void removeVendor(int eventIndex, int index) {
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.vendorsCount !=
        thisEvent.vendorsCount - 1;
    thisEvent.eventVendors.removeAt(index);
    eventBox.putAt(eventIndex, thisEvent);
    notifyListeners();
  }

  VoidCallback? updateSchedule(int itemIndex,int eventIndex,String title,DateTime? picked){
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.eventSchedule.removeAt(itemIndex);
    thisEvent!.eventSchedule.insert(itemIndex, Schedule(title: title, completeWithin: picked!));
    eventBox.putAt(eventIndex, thisEvent);
    notifyListeners();
  }
  VoidCallback? removeSchedule(int itemIndex,int eventIndex){
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.eventSchedule.removeAt(itemIndex);
    eventBox.putAt(eventIndex,thisEvent);
    notifyListeners();
  }

  VoidCallback? addSchedule(int eventIndex,String title,DateTime? picked){
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.eventSchedule.add(Schedule(title: title, completeWithin: picked!));
    eventBox.putAt(eventIndex, thisEvent);
    notifyListeners();
  }

  String timeRemaining(DateTime setDateTime) {
    Duration diff = setDateTime.difference(DateTime.now());
    int hours = diff.inHours;
    int minutes = diff.inMinutes%60;
    if (diff.isNegative){
      return "Deadline Expired";
    }
    else{
      return "${hours} hrs $minutes mins";
    }
  }

  Future<void> whatsappConnect(String contact,BuildContext context) async{
    try{
      launchUrl(Uri.parse("https://wa.me/$contact"));
    }catch(e){
      alertMessages(context: context, message: "Couldn't connect to $contact");
    }
    }
    Future<void> dialerConnect(String contact,BuildContext context) async{
    try{
      launchUrl(Uri.parse("tel:$contact"));
    }catch(e){
      alertMessages(context: context, message: "Couldn't connect to $contact");
    }
    }

  void sortSchedule(int eventIndex) {
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    Schedule tempSchedule;
    List<Schedule> thisSchedules = thisEvent!.eventSchedule;
    int scheduleLength = thisSchedules.length;
      for (int i = scheduleLength - 1; i > 0; i--) {
        for (int j = 0; j < i; j++) {
          if (thisSchedules[j].completeWithin.difference(DateTime.now()) > thisSchedules[j + 1].completeWithin.difference(DateTime.now())) {
            tempSchedule = thisSchedules[j];
            thisSchedules[j] = thisSchedules[j + 1];
            thisSchedules[j + 1] = tempSchedule;
          }
        }

    }
    thisEvent.eventSchedule!=thisSchedules;
      eventBox.putAt(eventIndex, thisEvent);
      notifyListeners();
  }
  }


