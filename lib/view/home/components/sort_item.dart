import 'package:flutter/material.dart';
import 'package:personal_expense_tracker_app/provider/expense_provider.dart';
import 'package:provider/provider.dart';

class SortItem extends StatelessWidget {
  final String type;
  const SortItem({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final value = context.read<ExpenseProvider>();
    return InkWell(
      onTap: () {
        value
            .sortExpense(
          type: type,
        )
            .then((value) {
          Navigator.pop(context);
        });
      },
      child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: value.selectedSort == type
                ? Theme.of(context).primaryColor
                : null,
            shape: BoxShape.circle,
            border: value.selectedSort != type
                ? Border.all(color: Colors.black)
                : null,
          ),
          child: Icon(
            type.contains('Up') ? Icons.arrow_drop_down : Icons.arrow_drop_up,
            size: 30,
            color: value.selectedSort == type ? Colors.white : Colors.black,
          )),
    );
  }
}
