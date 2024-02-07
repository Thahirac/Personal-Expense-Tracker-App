import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker_app/modal/expense_item.dart';

void main() {
  group('deleteExpense', () {
    test('should delete an expense from overallExpenseList', () {
      List<ExpenseItem> overallExpenseList = [
        ExpenseItem(name: "Food",amount: '100',des: "This is Food", dateTime: DateTime(2024, 1, 15),catogary: 'Food', ),
        ExpenseItem(name: "Travel", amount: '50',des: "This is Travel", dateTime: DateTime(2024, 2, 15),catogary: 'Travel',),
      ];

      int indexToDelete = 1; // Index of the expense to delete

      // my function
      void deleteExpense(int index) {
        overallExpenseList.removeAt(index);
      }

      // Call the function to delete the expense at the specified index
      deleteExpense(indexToDelete);

      // Assert that the expense at the specified index is deleted correctly
      expect(overallExpenseList.length, 1);
      expect(overallExpenseList.contains(ExpenseItem(name: "Travel", amount: '50',des: "This is Travel", dateTime: DateTime(2024, 2, 15),catogary: 'Travel',),), false);
    });
  });
}
