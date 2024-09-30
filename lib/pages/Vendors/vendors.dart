import 'package:hive/hive.dart';

part 'vendors.g.dart';
@HiveType(typeId: 4)
class Vendors{
  @HiveField(0)
  final String? name;

  @HiveField(1)
  final String? contact;

  @HiveField(2)
  final bool? isBooked;

  Vendors({
    required this.name,
    required this.contact,
    required this.isBooked,

  });
}