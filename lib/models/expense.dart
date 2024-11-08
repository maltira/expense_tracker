import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();
enum Categories {food, travel, leisure, work}

const categoryItems = {
  Categories.food: Icons.lunch_dining,
  Categories.travel: Icons.flight,
  Categories.leisure: Icons.movie,
  Categories.work: Icons.work
};

class Expense{
  Expense({required this.title, required this.amount, required this.date, required this.category}) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categories category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});
  final Categories category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses.where((expense) => expense.category == category).toList();

  double get totalExpenses{
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}