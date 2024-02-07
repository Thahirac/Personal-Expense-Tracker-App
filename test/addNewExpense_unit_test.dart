import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker_app/modal/expense_item.dart';

void main() {
  group('addNewExpense', () {
    test('should add a new expense to overallExpenseList', () {
      List<ExpenseItem> overallExpenseList = [];

      ExpenseItem newExpense = ExpenseItem(name: "Travel", amount: '50',des: "This is Travel", dateTime: DateTime(2024, 2, 7),catogary: 'Travel',);

      // my function
      void addNewExpense(ExpenseItem newExpense) {
        overallExpenseList.add(newExpense);
      }

      // Call the function to add the new expense
      addNewExpense(newExpense);

      // Assert that the new expense is added to the overallExpenseList
      expect(overallExpenseList.length, 1);
      expect(overallExpenseList[0], newExpense);
    });
  });
}
