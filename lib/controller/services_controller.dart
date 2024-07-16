import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../data/model/response/expense_model.dart';

class ExpenseController extends GetxController implements GetxService {
  late Box<Expense> _expenseBox;

  List<Expense> filterList=[];

  ExpenseController() {
    _expenseBox = Hive.box<Expense>('expenses');
  }

  List<Expense> get expenses => _expenseBox.values.toList();

  double _monthlyExpense = 0;

  double get monthlyExpense => _monthlyExpense;

  double _weeklyExpense = 0;

  double get weeklyExpense => _weeklyExpense;

  double _totalExpense = 0;

  double get totalExpense => _totalExpense;

  bool isLoading =false;

  void addExpense({
    required double amount,
    required DateTime date,
    required String description,
  }) {
    Expense newExpense = Expense.create(
      amount: amount,
      date: date,
      description: description,
    );
    _expenseBox.add(newExpense);
    calculateAllExpense();
    update();
  }
  void filterExpensesByDate(DateTime date) {
    filterList = _expenseBox.values.where((expense) => isSameDay(expense.date, date)).toList();
    update();
  }

  void clearFilter() {
    filterList.clear();
    update();
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }


  void updateExpense(String id, Expense newExpense) {
    int index = _expenseBox.values.toList().indexWhere((expense) => expense.id == id);
    if (index != -1) {
      _expenseBox.putAt(index, newExpense);
      update();
    }
    calculateAllExpense();
    update();
  }
  void deleteExpense(String expenseId) {
    int index = _expenseBox.values.toList().indexWhere((expense) => expense.id == expenseId);
    if (index != -1) {
      _expenseBox.deleteAt(index);
    }
    calculateAllExpense();
    update();
  }


  void calculateWeeklyExpenses() {

    isLoading=true;
    update();
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    _weeklyExpense= expenses.where((expense) =>
    expense.date.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
        expense.date.isBefore(endOfWeek.add(Duration(days: 1))))
        .fold(0, (sum, expense) => sum + expense.amount);

    isLoading=false;
    update();
  }

  void calculateMonthlyExpenses() {
    isLoading=true;
    update();
    DateTime now = DateTime.now();
    _monthlyExpense= expenses.where((expense) =>
    expense.date.year == now.year &&
        expense.date.month == now.month)
        .fold(0, (sum, expense) => sum + expense.amount);
    isLoading=false;
    update();
  }


  void calculateTotalExpense() {
    double total = 0.0;
    for (var expense in expenses) {
      total += expense.amount;
    }
    _totalExpense= total;
  }

  void calculateAllExpense(){
    calculateWeeklyExpenses();
    calculateMonthlyExpenses();
    calculateTotalExpense();
    update();
  }
}
