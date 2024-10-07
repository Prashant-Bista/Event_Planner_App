import 'package:hive_flutter/adapters.dart';

part 'schedule.g.dart';
@HiveType(typeId: 5)
class Schedule{

  @HiveField(0)
  final String title;

  @HiveField(1)
  final DateTime completeWithin;

  Schedule({
    required this.title,
    required this.completeWithin
});

}