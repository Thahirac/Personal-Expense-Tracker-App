import 'package:flutter_test/flutter_test.dart';// Import the file containing getWeekTotal()

void main() {
  test('Test getWeekTotal function', () {
    // Define some sample data for weekSummaryList
    List<Map<String, double>> weekSummaryList = [
      {'Monday': 10.0},
      {'Tuesday': 20.0},
      {'Wednesday': 30.0},
      {'Thursday': 15.0},
      {'Friday': 25.0},
      {'Saturday': 35.0},
      {'Sunday': 5.0},
    ];

    // Calculate the expected total
    double expectedTotal = 10.0 + 20.0 + 30.0 + 15.0 + 25.0 + 35.0 + 5.0;

    //my function
    double getWeekTotal(List weekSummaryList) {
      double totalAmount = 0.0;
      for (var element in weekSummaryList) {
        totalAmount += element.values.first;
      }
      return totalAmount;
    }

    // Call the function
    double actualTotal = getWeekTotal(weekSummaryList);

    // Check if the actual total matches the expected total
    expect(actualTotal, equals(expectedTotal));
  });
}
