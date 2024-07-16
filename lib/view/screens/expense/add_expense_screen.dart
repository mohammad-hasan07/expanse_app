import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/services_controller.dart';
import '../../../data/model/response/expense_model.dart';

class AddExpenseScreen extends StatefulWidget {
  final Expense? expense;

  const AddExpenseScreen({super.key, this.expense});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final ExpenseController controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    if (widget.expense != null) {
      _amountController.text = widget.expense!.amount.toString();
      _descriptionController.text = widget.expense!.description;
      _selectedDate = widget.expense!.date;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.expense == null ? 'Add' : 'Edit'} Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16.0),
              ListTile(
                title: const Text(
                  'Date',
                  style: TextStyle(fontSize: 16.0),
                ),
                subtitle: Text(
                  '${_selectedDate.toLocal()}'.split(' ')[0],
                  style: const TextStyle(fontSize: 16.0),
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _selectedDate) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  double amount = double.tryParse(_amountController.text) ?? 0.0;
                  DateTime date = _selectedDate;
                  String description = _descriptionController.text;

                  if (amount > 0 && description.isNotEmpty) {
                    widget.expense == null
                        ? controller.addExpense(
                      amount: amount,
                      date: date,
                      description: description,
                     )
                        : controller.updateExpense(
                      widget.expense!.id,
                      Expense(
                        id: widget.expense!.id,
                        amount: amount,
                        date: date,
                        description: description,
                      ),
                    );
                    Navigator.pop(context); // Close add expense screen
                  } else {
                    Get.snackbar(
                      'Error',
                      'Please enter valid amount and description.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                child: Text(widget.expense == null ? 'Save' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
