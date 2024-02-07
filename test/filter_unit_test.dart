import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker_app/modal/expense_item.dart';

void main() {
  group('applyFilter', () {
    test('should filter expenses within the selected range', () {
      DateTime? selecteMin = DateTime(2024, 1, 1); // Define your min and max dates
      DateTime? selectedMax = DateTime(2024, 2, 1);

      List<ExpenseItem> overallExpenseList = [
        ExpenseItem(name: "Food",amount: '50',des: "This is Food", dateTime: DateTime(2024, 1, 15),catogary: 'Food', ),
        ExpenseItem(name: "Travel", amount: '30',des: "This is Travel", dateTime: DateTime(2024, 2, 15),catogary: 'Travel',),
      ];


      List<ExpenseItem> _tempOverallExpenseList = List.from(overallExpenseList); // Make a copy for filtering


      // my function
      void applyFilter() {
        overallExpenseList = _tempOverallExpenseList.where((element) {
          return (element.dateTime.isAfter(selecteMin) &&
              element.dateTime.isBefore(selectedMax)) ||
              (element.dateTime.isAtSameMomentAs(selecteMin) ||
                  element.dateTime.isAtSameMomentAs(selectedMax));
        }).toList();
      }

      applyFilter();

      // Check if the filtered list contains only the expected item
      expect(overallExpenseList.length, 1);
      expect(overallExpenseList[0].dateTime, DateTime(2024, 1, 15));
    });
  });
}
