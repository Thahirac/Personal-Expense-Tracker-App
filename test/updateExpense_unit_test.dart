import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker_app/modal/expense_item.dart';

void main() {
  group('updateExpense', () {
    test('should update an expense in overallExpenseList', () {
      List<ExpenseItem> overallExpenseList = [
        ExpenseItem(name: "Food",amount: '100',des: "This is Food", dateTime: DateTime(2024, 1, 15),catogary: 'Food', ),
        ExpenseItem(name: "Travel", amount: '50',des: "This is Travel", dateTime: DateTime(2024, 2, 15),catogary: 'Travel',),
      ];

      ExpenseItem updatedExpense = ExpenseItem(name: "Travel", amount: '75',des: "This is Travel", dateTime: DateTime(2024, 3, 7),catogary: 'Travel',);


      int index = 1; // Index of the expense to update

      // my function
      void updateExpense(int index, ExpenseItem updatedExpense) {
        overallExpenseList[index] = updatedExpense;
      }

      // Call the function to update the expense at the specified index
      updateExpense(index, updatedExpense);

      // Assert that the expense at the specified index is updated correctly
      expect(overallExpenseList[index], updatedExpense);
    });
  });
}
