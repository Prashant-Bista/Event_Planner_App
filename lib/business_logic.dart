
import 'package:event_planner_app/pages/Budget/budget.dart';
import 'package:event_planner_app/pages/Events/event.dart';
import 'package:event_planner_app/pages/Guests/guests.dart';
import 'package:event_planner_app/pages/Todo/tasks.dart';
import 'package:event_planner_app/pages/Vendors/vendors.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateProvider = ChangeNotifierProvider.autoDispose<BusinessLogic>((ref)=>BusinessLogic());
class BusinessLogic extends ChangeNotifier {
  VoidCallback? AddBudget(int eventIndex,double value) {
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    Event? updatedEvent;
    Budget thisBudget = thisEvent!.eventBudget;
    thisBudget =
        Budget(budget: value, isSet: true);
    updatedEvent = Event(eventTasks: thisEvent.eventTasks,
        eventExpenses: thisEvent.eventExpenses,
        eventGuests: thisEvent.eventGuests,
        eventName: thisEvent.eventName,
        eventDate: thisEvent.eventDate,
        eventBudget: thisBudget,
      eventVendors: thisEvent.eventVendors,
    );
    eventBox.putAt(eventIndex, updatedEvent);
    notifyListeners();
    return null;
  }
  bool budgetSetCheck(int eventIndex){
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    return thisEvent!.eventBudget.isSet;
  }

  VoidCallback? addTask(int eventIndex,String task){
    Box<Event> eventBox = Hive.box<Event>('event');
  Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.eventTasks.add(Tasks(title: task, isDone: false));
    eventBox.putAt(eventIndex, thisEvent);
    notifyListeners();
    return null;

  }

  VoidCallback? taskCompletion(bool value,int eventIndex, int index){
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    List<Tasks>? updated= thisEvent!.eventTasks;
    updated[index]= Tasks(title: thisEvent.eventTasks[index].title, isDone: value);
    eventBox.putAt(eventIndex, Event(eventBudget: thisEvent.eventBudget,eventDate: thisEvent.eventDate,eventExpenses: thisEvent.eventExpenses,eventGuests: thisEvent.eventGuests,eventName: thisEvent.eventName,eventTasks: updated,eventVendors: thisEvent.eventVendors));
    notifyListeners();
    return null;

  }
  VoidCallback? taskDelete(int eventIndex, int index){
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.eventTasks.removeAt(index);
    eventBox.putAt(eventIndex, thisEvent);
    notifyListeners();
    return null;
  }
  VoidCallback? addGuest(int eventIndex,String name, int members, bool isInvited, String contact){
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.eventGuests.add(
      Guests(
        guestName: name,
        membersNo: members,
        invited: isInvited,
        contact: contact,
      ),
    );

    eventBox.putAt(eventIndex, thisEvent);
    notifyListeners();
    return null;

  }
  VoidCallback? updateGuest(int eventIndex,int guestIndex,String name, int members, bool isInvited, String contact){
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

    eventBox.putAt(eventIndex, thisEvent);
    notifyListeners();
    return null;

  }
  VoidCallback? addExpense(double value, int eventIndex,String purpose){
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.eventExpenses.add(Expenses(
        expenses:value,
      purpose: purpose
    ));
    eventBox.putAt(eventIndex, thisEvent);
    notifyListeners();
    return null;

  }
  double calcBudgetLeft(int eventIndex,){
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    List<Expenses> expenses=thisEvent!.eventExpenses;
    List<Vendors> vendors= thisEvent!.eventVendors;
    double totalExpense=0;
    double budgetRemaining;
    for(Expenses expense in expenses){
      totalExpense=totalExpense+expense.expenses;
    }
    for(Vendors vendor in vendors){
      totalExpense=totalExpense+vendor.price!;
    }
    budgetRemaining = thisEvent.eventBudget.budget-totalExpense;
    return budgetRemaining;
  }
  VoidCallback? deleteExpense(int eventIndex,index){
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.eventExpenses.removeAt(index);
    notifyListeners();
  }
  VoidCallback? removeGuest (int eventIndex,int index){
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.eventGuests.removeAt(index);
    eventBox.putAt(eventIndex, thisEvent);
    notifyListeners();
  }
  VoidCallback? addVendors(int eventIndex,String name,String contact, bool isBooked,int price){
    Box<Event> eventBox = Hive.box<Event>('event');
   Event? thisEvent= eventBox.getAt(eventIndex);
   thisEvent!.eventVendors.add(Vendors(name: name, contact: contact, isBooked: isBooked,price: price));
   notifyListeners();

  }
  VoidCallback? updateVendors(int eventIndex,int vendorIndex,String name, int price, bool isInvited, String contact){
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

    eventBox.putAt(eventIndex, thisEvent);
    notifyListeners();
    return null;

  }


}

