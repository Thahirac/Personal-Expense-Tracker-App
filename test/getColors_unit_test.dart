import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('getColors', () {
    test('should return light blue for Food', () {
      expect(getColors('Food'), equals(Colors.lightBlue.shade700));
    });

    test('should return yellow for Travel', () {
      expect(getColors('Travel'), equals(Colors.yellow.shade900));
    });

    test('should return deep purple for Entertainment', () {
      expect(getColors('Entertainment'), equals(Colors.deepPurple.shade500));
    });

    test('should return green for other items', () {
      expect(getColors('Other'), equals(Colors.green.shade500));
    });
  });
}
// my function
Color getColors(String item) {
  switch (item) {
    case 'Food':
      return Colors.lightBlue.shade700;
    case 'Travel':
      return Colors.yellow.shade900;
    case 'Entertainment':
      return Colors.deepPurple.shade500;
    default:
      return Colors.green.shade500;
  }
}
