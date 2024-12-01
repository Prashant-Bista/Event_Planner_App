import 'package:event_planner_app/pages/Schedule/schedule.dart';
import 'package:event_planner_app/pages/Venue/venueList_view.dart';
import 'package:hive/hive.dart';
import '../Budget/budget.dart';
import '../Guests/guests.dart';
import '../Todo/tasks.dart';
import '../Vendors/vendors.dart';
import '../Venue/venue_model.dart';

part 'event.g.dart';

@HiveType(typeId: 6)
class Event {
  @HiveField(0)
  final Budget eventBudget;

  @HiveField(1)
  final List<Expenses> eventExpenses;

  @HiveField(2)
  final List<Tasks> eventTasks;

  @HiveField(3)
  final List<Guests> eventGuests;

  @HiveField(4)
  final List<Vendors> eventVendors;

  @HiveField(5)
  final String eventName;

  @HiveField(6)
  final DateTime? eventDate;

  @HiveField(7)
  final int vendorsCount;

  @HiveField(8)
  final int guestsCount;

  @HiveField(9)
  final List<Schedule> eventSchedule;

  @HiveField(10)
  final Venue? eventVenue ;
  @HiveField(11)
  late double? predictedBudget ;
  Event({
   required this.eventBudget,
    required this.eventExpenses,
    required this.eventGuests,
    required this.eventTasks,
    required this.eventName,
    required this.eventDate,
    required this.eventVendors,
    required this.vendorsCount,
    required this.guestsCount,
    required this.eventSchedule,
    required this.eventVenue,
    this.predictedBudget

  });
}

