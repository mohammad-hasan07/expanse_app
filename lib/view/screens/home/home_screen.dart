import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/services_controller.dart';
import '../../base/summary_card.dart';
import '../expense/expense_list_view.dart';
import '../expense/add_expense_screen.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DateTime? _selectedDate;
  @override
  void initState() {
    Get.find<ExpenseController>().calculateMonthlyExpenses();
    Get.find<ExpenseController>().calculateWeeklyExpenses();
    Get.find<ExpenseController>().calculateTotalExpense();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      
       floatingActionButton: Container(
         padding: const EdgeInsets.all(5),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(16),
           color: Get.theme.primaryColor
         ),
         child: IconButton(
          icon: const Icon(Icons.add,color: Colors.white,size: 30,), onPressed: () {
Get.to(()=> const AddExpenseScreen());
               },
               ),
       ),
      body: GetBuilder<ExpenseController>(builder: (expenseController){

        if(expenseController.isLoading){
         return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
               SummaryCard(
                title: 'Total Expenses',
                amount: expenseController.totalExpense,
                icon: Icons.currency_rupee,
                backgroundColor: Colors.redAccent,
              ),
              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      topTitle: 'This Week',
                      amount: expenseController.weeklyExpense,
                      icon: Icons.calendar_today,
                      backgroundColor: Colors.orangeAccent,
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: SummaryCard(
                      topTitle: 'This Month',
                      amount:expenseController.monthlyExpense,
                      icon: Icons.calendar_view_month,
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('All Expenses'),   IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null) {
                        setState(() {
                          _selectedDate = picked;
                        });
                        expenseController.filterExpensesByDate(_selectedDate!);
                      }
                    },
                  ),
                ],
              ),
              _selectedDate!=null?
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Remove filters'), IconButton(
                      icon: const Icon(Icons.highlight_remove),
                      onPressed: () async {
setState(() {
  _selectedDate=null;
  expenseController.clearFilter();
});
                      },
                    ),
                  ],
                ),
              ):const SizedBox(),
              Flexible(child:  ExpenseListView(selectedDate: _selectedDate,)),
            ],
          ),
        );
      }),
    );
  }
}

