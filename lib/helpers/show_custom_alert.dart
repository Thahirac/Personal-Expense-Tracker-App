import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../provider/expense_provider.dart';
import '../view/login_screen.dart';

class ShowCustomAlert {
  static Future<String> showNotificationAlertDialog(
      BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: Text(
              "Notification Preference",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            content: Text(
              "Choose your notification Preference",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            actionsAlignment: MainAxisAlignment.center,
            alignment: Alignment.center,
            actionsOverflowAlignment: OverflowBarAlignment.center,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'daily');
                  },
                  child: const Text("Daily")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'hourly');
                  },
                  child: const Text("Hourly")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'minute');
                  },
                  child: const Text("Every minute")),
            ],
          );
        });
  }

  static Future<void> showExitAlertDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: Text(
              "Are you sure?",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            content: Text(
              "Do you want to exit?",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            actionsAlignment: MainAxisAlignment.end,
            alignment: Alignment.center,
            actions: [
              TextButton(
                  onPressed: () async {
                    final user = await Hive.box('users').get("ALL_DATA");
                    Provider.of<AuthProvider>(context, listen: false).logout(
                        email: user?.email ?? "",
                        password: user?.pass ?? "",
                        name: user?.name ?? "",
                        isLogged: false);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login_Page()));
                  },
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: const Text("No")),
            ],
          );
        });
  }



  static Future<void> showRemoveItemAlertDialog(BuildContext context,int index) async {
    return await showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: Text(
              "Delete?",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            content: Text(
              "Are you sure you want to delete this item?",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            actionsAlignment: MainAxisAlignment.end,
            alignment: Alignment.center,
            actions: [
              TextButton(
                  onPressed: () async {
                    Provider.of<ExpenseProvider>(context, listen: false).deleteExpense(index);
                    Navigator.pop(context);
                  },
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: const Text("No")),
            ],
          );
        });
  }


}
