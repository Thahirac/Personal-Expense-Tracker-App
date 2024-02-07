import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker_app/modal/expense_item.dart';

void main() {
  group('resetFilter', () {
    test('should reset filter values and update overallExpenseList', () {
      DateTime? selecteMin = DateTime(2024, 1, 1); // Define your min and max dates
      DateTime? selectedMax = DateTime(2024, 2, 1);

      List<ExpenseItem> overallExpenseList = [
        ExpenseItem(name: "Food",amount: '50',des: "This is Food", dateTime: DateTime(2024, 1, 15),catogary: 'Food', ),
        ExpenseItem(name: "Travel", amount: '30',des: "This is Travel", dateTime: DateTime(2024, 2, 15),catogary: 'Travel',),
      ];

      List<ExpenseItem> _tempOverallExpenseList = List.from(overallExpenseList); // Make a copy for resetting

      // my function
      void resetFilter() {
        selecteMin = null;
        selectedMax = null;
        overallExpenseList = _tempOverallExpenseList;// Assuming this is available in your code
      }

      resetFilter();

      // Check if selecteMin and selectedMax are null after resetting
      expect(selecteMin, isNull);
      expect(selectedMax, isNull);

      // Check if overallExpenseList is updated to its original state
      expect(overallExpenseList, _tempOverallExpenseList);
    });
  });
}
