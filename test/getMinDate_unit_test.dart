import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker_app/modal/expense_item.dart';
void main() {
    test('getMinDate', () {

      DateTime? minDate;

      List<ExpenseItem> overallExpenseList = [
        ExpenseItem(name: "Food",amount: '50',des: "This is Food", dateTime: DateTime(2024, 1, 15),catogary: 'Food', ),
        ExpenseItem(name: "Travel", amount: '30',des: "This is Travel", dateTime: DateTime(2024, 2, 15),catogary: 'Travel',),
      ];

      List<ExpenseItem> _tempOverallExpenseList = List.from(overallExpenseList);

      // my function
      void getMinDate() {
        minDate = _tempOverallExpenseList
            .reduce((value, element) =>
        value.dateTime.isBefore(element.dateTime) ? value : element)
            .dateTime;
      }

      getMinDate();

      // Assert that the minDate is the expected minimum date from _tempOverallExpenseList
      expect(minDate, DateTime(2024, 1, 15));
    });
}
