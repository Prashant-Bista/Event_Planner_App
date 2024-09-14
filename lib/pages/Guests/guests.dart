import 'package:hive/hive.dart';

part 'guests.g.dart';

@HiveType(typeId: 1)
class Guests{
  @HiveField(0)
  final String guestName;

  @HiveField(1)
  final int membersNo;

  @HiveField(2)
  final bool invited;

  @HiveField(3)
  final String contact;

  Guests({
    required this.guestName,
    required this.membersNo,
    required this.invited,
    required this.contact,
  });
}