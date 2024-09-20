import 'package:hive/hive.dart';

import '../Budget/budget.dart';
import '../Guests/guests.dart';
import '../Todo/tasks.dart';

part 'event.g.dart';

@HiveType(typeId: 4)
class Event {
  @HiveField(0)
  final Budget eventBudget;

  @HiveField(1)
  final List<Expenses> eventExpenses;

  @HiveField(2)
  final List<Tasks> eventTasks;

  @HiveField(3)
  final List<Guests> eventGuests;

  @HiveField(5)
  final String eventName;

  @HiveField(6)
  final DateTime? eventDate;

  Event({
   required this.eventBudget,
    required this.eventExpenses,
    required this.eventGuests,
    required this.eventTasks,
    required this.eventName,
    required this.eventDate
  });
}
