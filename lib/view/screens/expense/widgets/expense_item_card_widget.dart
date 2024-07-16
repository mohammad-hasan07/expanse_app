

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/services_controller.dart';
import '../../../../data/model/response/expense_model.dart';
import '../../../../util/dimensions.dart';
import '../add_expense_screen.dart';

class ExpenseItemWidget extends StatelessWidget {
  final Expense expense;

  const ExpenseItemWidget({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(   key: Key(expense.id.toString()), // Unique key for each expense
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          color: Colors.red,
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF99ABC6).withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(0, 5))
          ],
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        // Show a confirmation dialog before deleting
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm"),
              content: const Text("Are you sure you want to delete this expense?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("CANCEL"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("DELETE"),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (DismissDirection direction) {
        // Delete the expense item
        // Note: Implement the delete logic in your controller or wherever you manage expenses
        Get.find<ExpenseController>().deleteExpense(expense.id);
      },
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () {
            Get.to(() => AddExpenseScreen(expense: expense));
          },
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                       expense.description,
                       style: const TextStyle(
                         fontSize: 16.0,
                         overflow: TextOverflow.ellipsis,
                       ),
                     ),Text('${expense.date.toLocal()}'.split(' ')[0]),
                  ],
                         ),
                ),
               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                  Text('\$${expense.amount.toStringAsFixed(2)}',style: TextStyle(
                       fontSize: Dimensions.fontSizeLarge,fontWeight: FontWeight.w500
                   ),),
                 ],
               ),
             ],
           ),
        ),
      ),
    );
  }
}
