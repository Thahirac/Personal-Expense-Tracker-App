import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker_app/modal/expense_item.dart';

void main() {
  group('sortExpense', () {
    test('should sort expenses correctly', () {
      List<ExpenseItem> overallExpenseList = [
        ExpenseItem(name: "Food",amount: '100',des: "This is Food", dateTime: DateTime(2024, 1, 15),catogary: 'Food', ),
        ExpenseItem(name: "Travel", amount: '50',des: "This is Travel", dateTime: DateTime(2024, 2, 15),catogary: 'Travel',),
      ];

      String type = 'dateUp'; // Change to test different sorting types

      // my function
      void sortExpense({required String type, bool isInit = false}) async {
        // Sort the overallExpenseList based on the given type
        if (type == 'dateUp') {
          overallExpenseList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
        } else if (type == 'dateLow') {
          overallExpenseList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
        } else if (type == 'amountUp') {
          overallExpenseList.sort((a, b) => double.parse(a.amount).compareTo(double.parse(b.amount)));
        } else if (type == 'amountLow') {
          overallExpenseList.sort((a, b) => double.parse(b.amount).compareTo(double.parse(a.amount)));
        }
      }

      sortExpense(type: type);

      // Assert the sorted list based on the given type
      switch (type) {
        case 'dateUp':
          expect(overallExpenseList[0].dateTime, DateTime(2024, 2, 15));
          break;
        case 'dateLow':
          expect(overallExpenseList[0].dateTime, DateTime(2024, 1, 15));
          break;
        case 'amountUp':
          expect(overallExpenseList[0].amount, '50');
          break;
        case 'amountLow':
          expect(overallExpenseList[0].amount, '100');
          break;
        default:
        // Handle unexpected types
          break;
      }
    });
  });
}
