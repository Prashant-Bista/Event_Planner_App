import 'package:hive/hive.dart';

part 'budget.g.dart';

@HiveType(typeId: 2)
class Budget {
  @HiveField(0)
  final double budget;
  @HiveField(1)
  final bool isSet;
  @HiveField(2)
  double total_expenses;


  Budget({
    required this.budget,
    required this.isSet,
    required this.total_expenses,

  });
}

@HiveType(typeId: 3)
class Expenses{
  @HiveField(0)
  final double expenses;

  @HiveField(1)
  final String? purpose;

  Expenses({
    required this.expenses,
    required this.purpose
  });

}