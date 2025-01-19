
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'venue_model.g.dart';
@HiveType(typeId: 8)
class Venue{

  @HiveField(0)
  int? selectedDocumentIndex;
  String venueId;
  double? venueCost;
  Venue({
     this.selectedDocumentIndex,
     this.venueCost,
    required this.venueId
  });
}
