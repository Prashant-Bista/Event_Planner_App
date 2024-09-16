import 'package:hive/hive.dart';

part 'budget.g.dart';

@HiveType(typeId: 2)
class Budget {
  @HiveField(0)
  final double budget;
  Budget({
    required this.budget
});
}

@HiveType(typeId: 3)
class Expenses{
  @HiveField(0)
  final double expenses;
  Expenses({
    required this.expenses
  });

}