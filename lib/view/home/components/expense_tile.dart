import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker_app/provider/expense_provider.dart';
import 'package:provider/provider.dart';
import '../../../helpers/show_custom_alert.dart';
import '../../../modal/expense_item.dart';
import 'addOredit_expense.dart';

class ExpenseTile extends StatelessWidget {
  final ExpenseItem item;
  final int index;

  ///update expense
  void _startUpdateExpense(BuildContext ctx, ExpenseItem item) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      isScrollControlled: true,
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(ctx).size.height - kToolbarHeight * 2),
      context: ctx,
      builder: (_) {
        return AddOrEditExpense(
          expenseItem: item,
        );
      },
    );
  }

  const ExpenseTile(
      {super.key, required, required this.index, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade400)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat.yMMMd().format(item.dateTime),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 25,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              _startUpdateExpense(context, item);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          IconButton(
                              onPressed: () {
                                ShowCustomAlert.showRemoveItemAlertDialog(context,index);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 20,
                              ),
                              padding: EdgeInsets.zero),
                        ],
                      ),
                    )
                  ],
                )),
            ListTile(
              tileColor: Colors.grey.shade200,
              style: ListTileStyle.list,
              isThreeLine: true,
              title: Text(
                item.name.toString(),
                style:
                    const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(item.des),
              trailing: Text('\u{20B9} ${item.amount}'),
            ),
          ],
        ),
      ),
    );
  }
}
