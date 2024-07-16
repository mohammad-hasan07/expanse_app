import 'package:expanse_app/view/screens/expense/widgets/expense_item_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/services_controller.dart';
import '../../../data/model/response/expense_model.dart';

class ExpenseListScreen extends StatefulWidget {
  final DateTime? selectedDate;

  const ExpenseListScreen({super.key, this.selectedDate});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServicesController>(builder: (expenseController) {
      List<Expense> displayList = widget.selectedDate!=null
          ? expenseController.filterList
          : expenseController.expenses;

      return displayList.isNotEmpty
          ? ListView.builder(
        itemCount: displayList.length + 1,
        itemBuilder: (context, index) {
          if (index == displayList.length) {
            return const SizedBox(height: 50); // Empty space at the end
          }
          final expense = displayList[index];
          return ExpenseItemWidget(expense: expense);
        },
      )
          : const Center(child: Text("No data found"));
    });
  }
}
