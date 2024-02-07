import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test getSummary function', () {
    // Mock the overallExpenseList
    List<Expense> overallExpenseList = [
      Expense(name: "Food",amount: '50',des: "This is Food", dateTime: DateTime(2024, 2, 3),catogary: 'Food', ),
      Expense(name: "Travel", amount: '30',des: "This is Travel", dateTime: DateTime(2024, 2, 5),catogary: 'Travel',),
      Expense(name: "Food", amount: '20',des: "This is Food", dateTime: DateTime(2024, 2, 7),catogary: 'Food',),
    ];

    // Create an instance of the class containing getSummary method
    YourClassContainingGetSummary instance = YourClassContainingGetSummary();

    // Call the getSummary method
    instance.overallExpenseList = overallExpenseList;
    instance.getSummary();

    // Check if totalSummaryList and weekSummaryList are as expected
    expect(instance.totalSummaryList, [
      {'Food': 70}, // Total amount of category1 expenses
      {'Travel': 30}  // Total amount of category2 expenses
    ]);

  });
}

class Expense {
  final String name;
  final String amount;
  final String des;
  final DateTime dateTime;
  final String catogary;

  Expense({required this.name, required this.amount,required this.des, required this.dateTime,required this.catogary});

}

class YourClassContainingGetSummary {
  List<Expense> overallExpenseList = [];
  List<Map<String, double>> totalSummaryList = [];
  List<Map<String, double>> weekSummaryList = [];

  // my function
  Future<void> getSummary() async {
    DateTime currentDate = DateTime.now();
    // Get the start and end dates of the current week
    DateTime startOfWeek =
    currentDate.subtract(Duration(days: currentDate.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
    totalSummaryList = [];
    weekSummaryList = [];
    Map<String, double> totalSummary = {};
    Map<String, double> weeklySummary = {};
    // Calculate total amount for each category
    for (var expense in overallExpenseList) {
      /// Total Summary
      if (totalSummary.containsKey(expense.catogary)) {
        totalSummary[expense.catogary] =
            totalSummary[expense.catogary]! + double.parse(expense.amount);
      } else {
        totalSummary[expense.catogary] = double.parse(expense.amount);
      }

      /// Weekly Summary
      bool isInCurrentWeek = (expense.dateTime.isAfter(startOfWeek) ||
          (expense.dateTime.day == startOfWeek.day &&
              expense.dateTime.month == startOfWeek.month &&
              expense.dateTime.year == startOfWeek.year)) &&
          (expense.dateTime.isBefore(endOfWeek) ||
              (expense.dateTime.day == endOfWeek.day &&
                  expense.dateTime.month == endOfWeek.month &&
                  expense.dateTime.year == endOfWeek.year));
      if (weeklySummary.containsKey(expense.catogary) && isInCurrentWeek) {
        weeklySummary[expense.catogary] =
            weeklySummary[expense.catogary]! + double.parse(expense.amount);
      } else if (isInCurrentWeek) {
        weeklySummary[expense.catogary] = double.parse(expense.amount);
      }
    }
    totalSummary.forEach((category, totalAmount) {
      totalSummaryList.add({category: totalAmount});
    });
    weeklySummary.forEach((category, totalAmount) {
      weekSummaryList.add({category: totalAmount});
    });

  }
}
