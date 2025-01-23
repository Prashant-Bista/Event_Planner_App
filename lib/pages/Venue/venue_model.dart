
import 'package:hive/hive.dart';

part 'venue_model.g.dart';
@HiveType(typeId: 8)
class Venue{

  @HiveField(0)
  String venueId;

  @HiveField(1)
  double venueCost;

  @HiveField(2)
  Venue({
     required this.venueCost,
    required this.venueId
  });
}
