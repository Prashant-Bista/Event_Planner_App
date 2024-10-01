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

  @HiveField(3)
  final int? price;

  Vendors({
    required this.name,
    required this.contact,
    required this.isBooked,
  required this.price,

  });
}