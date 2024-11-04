
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';
import 'expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(title: 'Flutter Course', amount: 19.99, date: DateTime.now(), category: Categories.work),
    Expense(title: 'Cinema', amount: 15.99, date: DateTime.now(), category: Categories.leisure),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense)
    );
  }

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
    Navigator.pop(context);
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(seconds: 3),
          content: const Text('Expense deleted'),
          action: SnackBarAction(
              label: 'Undo',
              onPressed: (){
                setState(() {
                  _registeredExpenses.insert(expenseIndex, expense);
                });
              }
          ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = _registeredExpenses.length == 0 ? Text("No expenses found. Start adding some!") : ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter ExpenseTracker"),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add)
          )
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          const SizedBox(height: 16,),
          const Text(
            'History',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24
            ),
          ),
          const SizedBox(height: 8,),
          Expanded(child: mainContent)
        ],
      ),
    );
  }
}
