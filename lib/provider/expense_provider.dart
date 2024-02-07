import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:personal_expense_tracker_app/database/hive_database.dart';
import '../helpers/notificationservice.dart';
import '../modal/expense_item.dart';

class ExpenseProvider extends ChangeNotifier {
  /// List of all expenses
  List<ExpenseItem> overallExpenseList = [];
  /// a temp List
  List<ExpenseItem> _tempOverallExpenseList = [];
  final expensedb = HiveDataBase();
  String selectedSort = 'dateUp';
  DateTime minDate = DateTime.now(), maxDate = DateTime.now();
  DateTime? selecteMin, selectedMax;
  List<Map<String, double>> totalSummaryList = [];
  List<Map<String, double>> weekSummaryList = [];

  /// prepare expense data to display
  Future<void> prepareData({String? notificationType}) async {
    ///if there exist data, get it
    if (expensedb.readExpenseData().isNotEmpty) {
      overallExpenseList = expensedb.readExpenseData();
      _tempOverallExpenseList = overallExpenseList;
      getMinDate();
      await sortExpense(type: 'dateUp', isInit: true);
    }

    ///asking the notification permision
    final box = await Hive.openBox('notificationTypeDb');
    await notificationpermision(
        notificationType ?? box.get('notificationType'));

    /// get the total expense summary
    await getSummary();
  }

  /// add new expense
  Future<void> addNewExpense(ExpenseItem newExpense) async {
    overallExpenseList.add(newExpense);
    expensedb.saveExpenseData(overallExpenseList);
    _tempOverallExpenseList = overallExpenseList;
    await sortExpense(type: selectedSort);
  }

  /// edit expense
  void updateExpense(int index, ExpenseItem updatedExpense) {
    overallExpenseList[index] = updatedExpense;
    expensedb.saveExpenseData(overallExpenseList);
    getSummary();
    notifyListeners();
  }

  /// delete expense
  void deleteExpense(int index) {
    overallExpenseList.removeAt(index);
    expensedb.saveExpenseData(overallExpenseList);
    getSummary();
    notifyListeners();
  }

  /// notification permission
  Future<void> notificationpermision(String value) async {
    PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      NotificationService.showPeriodicNotification(
          title: "Daily Expense Notification",
          body: "Please record your daily expense",
          payload: "This is Daily Expense Notification",
          notifcationType: value);
    }
  }

  /// sort by date and amount
  Future<void> sortExpense({required String type, bool isInit = false}) async {
    selectedSort = type;
    if (type == 'dateUp') {
      overallExpenseList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    } else if (type == 'dateLow') {
      overallExpenseList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    } else if (type == 'amountUp') {
      overallExpenseList.sort(
          (a, b) => double.parse(a.amount).compareTo(double.parse(b.amount)));
    } else if (type == 'amountLow') {
      overallExpenseList.sort(
          (a, b) => double.parse(b.amount).compareTo(double.parse(a.amount)));
    }
    if (!isInit) {
      notifyListeners();
    }
  }

  ///get the min date
  void getMinDate() {
    minDate = _tempOverallExpenseList
        .reduce((value, element) =>
            value.dateTime.isBefore(element.dateTime) ? value : element)
        .dateTime;
    log('minDate is $minDate');
  }

  ///updating the state after date picked for filter
  void updateState() {
    notifyListeners();
  }

  ///reset filter
  void resetFilter() {
    selecteMin = null;
    selectedMax = null;
    overallExpenseList = _tempOverallExpenseList;
    notifyListeners();
  }

  ///filter by date
  void applyFilter() {
    overallExpenseList = _tempOverallExpenseList.where((element) {
      return (element.dateTime.isAfter(selecteMin!) &&
              element.dateTime.isBefore(selectedMax!)) ||
          (element.dateTime.isAtSameMomentAs(selecteMin!) ||
              element.dateTime.isAtSameMomentAs(selectedMax!));
    }).toList();
    notifyListeners();
  }

  ///get total expense summary and weekly summary for pie chart
  Future<void> getSummary() async {
    try {
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
    } catch (e) {
      log('ee $e');
    }
    notifyListeners();
  }

  ///calculating total expense amount
  double getTotalAmount() {
    double totalAmount = 0.0;
    for (var element in totalSummaryList) {
      totalAmount += element.values.first;
    }
    return totalAmount;
  }

  ///calculating weekly total expense amount
  double getWeekTotal() {
    double totalAmount = 0.0;
    for (var element in weekSummaryList) {
      totalAmount += element.values.first;
    }
    return totalAmount;
  }
}


