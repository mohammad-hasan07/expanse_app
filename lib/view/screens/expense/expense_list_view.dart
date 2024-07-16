import 'package:expanse_app/view/screens/expense/widgets/expense_item_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/services_controller.dart';
import '../../../data/model/response/expense_model.dart';

class ExpenseListView extends StatefulWidget {
  final DateTime? selectedDate;

  const ExpenseListView({super.key, this.selectedDate});

  @override
  State<ExpenseListView> createState() => _ExpenseListViewState();
}

class _ExpenseListViewState extends State<ExpenseListView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpenseController>(builder: (expenseController) {
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
