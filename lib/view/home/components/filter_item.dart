import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker_app/provider/expense_provider.dart';
import 'package:provider/provider.dart';
import '../../../helpers/showtoast_const.dart';



class FilteItem extends StatelessWidget {
  const FilteItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(builder: (context, value, child) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius
                      .vertical(
                      top: Radius.circular(20)),
                  color: Theme.of(context)
                      .primaryColor),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 3,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius
                                .circular(2)),
                        alignment:
                        Alignment.center,
                      )),
                  Text(
                    "FILTER BY",
                    style: TextStyle(
                        fontWeight:
                        FontWeight.w500,
                        color: Colors.white,
                        fontSize:
                        Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.fontSize),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
              EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              showDatePicker(
                                  context: context,
                                  initialDate: value.selecteMin ??
                                      value.minDate,
                                  firstDate: value.minDate,
                                  lastDate: value.maxDate)
                                  .then((v) {
                                if (v != null) {
                                  value.selecteMin = v;
                                  if (value.selectedMax != null &&
                                      value.maxDate.isBefore(v)) {
                                    value.maxDate = v;
                                  }
                                  value.updateState();
                                }
                              });
                            },
                            icon: Row(
                              children: [
                                Icon(
                                  Icons.calendar_month_outlined,
                                  color: value.selecteMin != null? Theme.of(context).primaryColor : Colors.deepPurple.shade100 ,
                                  size: 30,
                                ),

                                SizedBox(width: 5,),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('From Date',style: TextStyle(color: Colors.grey,fontSize: 12),),

                                    if (value.selecteMin != null)
                                      Text(
                                        "${DateFormat.yMMMd().format(value.selecteMin!)}",
                                        style: TextStyle(fontWeight: FontWeight.w500),
                                      ),
                                  ],
                                )
                              ],
                            )),


                        VerticalDivider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),



                        IconButton(
                            onPressed: () {
                              showDatePicker(
                                  context: context,
                                  initialDate: value.selectedMax ??
                                      value.maxDate,
                                  firstDate:
                                  value.selecteMin ?? value.minDate,
                                  lastDate: value.maxDate)
                                  .then((v) {
                                if (v != null) {
                                  value.selectedMax = v;
                                  value.updateState();
                                }
                              });
                            },
                            icon: Row(
                              children: [
                                Icon(
                                  Icons.calendar_month_outlined,
                                  color: value.selectedMax != null ? Theme.of(context).primaryColor :  Colors.deepPurple.shade100,
                                  size: 30,
                                ),

                                SizedBox(width: 5,),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('To Date',style: TextStyle(color: Colors.grey,fontSize: 12),),

                                    if (value.selectedMax != null)
                                      Text(
                                        "${DateFormat.yMMMd().format(value.selectedMax!)}",
                                        style: TextStyle(fontWeight: FontWeight.w500),
                                      ),
                                  ],
                                )
                              ],
                            )),


                      ],
                    ),
                  ),

                  Divider(color: Colors.grey,thickness: 0.5,),

                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    Theme.of(context).cardColor),
                                onPressed: () {
                                  value.resetFilter();
                                  Navigator.pop(context);
                                },
                                child: Text('Reset'))),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    Theme.of(context).primaryColor),
                                onPressed: () {
                                  if (value.selecteMin == null ||
                                      value.selectedMax == null ||
                                      value.minDate == null ||
                                      value.maxDate == null) {
                                    CustomToast.showToast("Please select a From date and To Date");
                                    Navigator.pop(context);
                                  } else {
                                    print("YES");
                                    value.applyFilter();
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  'Apply',
                                  style: TextStyle(color: Colors.white),
                                )))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}




