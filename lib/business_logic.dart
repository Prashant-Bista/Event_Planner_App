import 'dart:ui';

import 'package:event_planner_app/pages/Budget/budget.dart';
import 'package:event_planner_app/pages/Events/event.dart';
import 'package:event_planner_app/pages/Todo/tasks.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'components.dart';
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
        eventBudget: thisBudget);
    eventBox.putAt(eventIndex, updatedEvent!);
    notifyListeners();
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
    eventBox.putAt(eventIndex, thisEvent!);
    notifyListeners();

  }

  VoidCallback? taskCompletion(bool value,int eventIndex, int index){
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    List<Tasks>? updated= thisEvent!.eventTasks;
    updated[index]= Tasks(title: thisEvent!.eventTasks[index].title, isDone: value!);
    eventBox.putAt(eventIndex, Event(eventBudget: thisEvent!.eventBudget,eventDate: thisEvent!.eventDate,eventExpenses: thisEvent!.eventExpenses,eventGuests: thisEvent!.eventGuests,eventName: thisEvent!.eventName,eventTasks: updated));
    notifyListeners();

  }
  VoidCallback? taskDelete(int eventIndex, int index){
    Box<Event> eventBox = Hive.box<Event>('event');
    Event? thisEvent = eventBox.getAt(eventIndex);
    thisEvent!.eventTasks.removeAt(index);
    eventBox.putAt(eventIndex, thisEvent!);
    notifyListeners();
  }
}

