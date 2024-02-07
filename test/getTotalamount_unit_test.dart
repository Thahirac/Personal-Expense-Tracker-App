import 'package:flutter_test/flutter_test.dart';
void main() {
  test('Test getTotalAmount function', () {
    // Define a sample list to test the function
    final totalSummaryList = [
      {'item1': 10.0},
      {'item2': 20.0},
      {'item3': 30.0}
    ];

    // Calculate the expected total amount manually
    double expectedTotal = 0.0;
    for (var element in totalSummaryList) {
      expectedTotal += element.values.first;
    }

    //my function
    double getTotalAmount(List totalSummaryList) {
      double totalAmount = 0.0;
      for (var element in totalSummaryList) {
        totalAmount += element.values.first;
      }
      return totalAmount;
    };

    // Call the function and store the result
    final actualTotal = getTotalAmount(totalSummaryList);

    // Assert that the result matches the expected total
    expect(actualTotal, equals(expectedTotal));
  });
}
