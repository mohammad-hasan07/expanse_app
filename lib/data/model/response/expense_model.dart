import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final String description;

  Expense({
    required this.id,
    required this.amount,
    required this.date,
    required this.description,
  });

  factory Expense.create({
    required double amount,
    required DateTime date,
    required String description,
  }) {
    return Expense(
      id: const Uuid().v4(),  // Generate unique ID
      amount: amount,
      date: date,
      description: description,
    );
  }
}
