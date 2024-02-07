import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:personal_expense_tracker_app/view/settings_screen.dart';
import 'package:provider/provider.dart';
import '../../helpers/show_custom_alert.dart';
import '../../modal/expense_item.dart';
import '../../provider/expense_provider.dart';
import 'components/addOredit_expense.dart';
import 'components/expense_tile.dart';
import 'components/filter_item.dart';
import 'components/pie chart/totalandweely_piechart.dart';
import 'components/sort_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String notficationPreference = '';
  final user = Hive.box('users').get("ALL_DATA");

  ///call add new expense bottomsheet
  void _startAddNewExpense(BuildContext ctx, ExpenseItem? item) {
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
    ).then((value) {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///prepare data on startup to Hive database
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final box = await Hive.openBox('notificationTypeDb');

      final String? notifcationType = box.get('notificationType', defaultValue: '');

      if (notifcationType == null || notifcationType == '') {
        await ShowCustomAlert.showNotificationAlertDialog(context)
            .then((value) {
          box.put('notificationType', value);
          Provider.of<ExpenseProvider>(context, listen: false)
              .prepareData(notificationType: value.toString());
        });
      } else {
        Provider.of<ExpenseProvider>(context, listen: false)
            .prepareData(notificationType: null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            tooltip: "Add an expense",
            child: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              _startAddNewExpense(context, null);
            },
            backgroundColor: Colors.black,
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).primaryColor,
            title: Row(
              children: [
                Text(
                  "Hii,",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 25),
                ),
                Text(
                  " ${user.name ?? ""}",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 23),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingScreen()));
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    )),
              )
            ],
          ),
          body: value.overallExpenseList.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      /// pie chart
                      const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: SummaryPieChart(),
                      ),

                      /// sort and filter for expense
                      Visibility(
                        visible: value.overallExpenseList.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "My Expenses",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            20))),
                                            isScrollControlled: true,
                                            builder: (context) {
                                              return Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 15,
                                                          horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                          20)),
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Container(
                                                                height: 3,
                                                                width: 30,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            2)),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                              )),
                                                          Text(
                                                            "SORT BY",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge
                                                                    ?.fontSize),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 20,
                                                          bottom: 20,
                                                          left: 15,
                                                          right: 15),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Date",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  SortItem(
                                                                    type:
                                                                        'dateUp',
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  SortItem(
                                                                    type:
                                                                        'dateLow',
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Amount",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SortItem(
                                                                    type:
                                                                        'amountUp',
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  SortItem(
                                                                    type:
                                                                        'amountLow',
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(Icons.sort)),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            shape: const RoundedRectangleBorder(

                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            20)),),
                                            isScrollControlled: true,
                                            builder: (context) {
                                              return const FilteItem();
                                            });
                                      },
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(Icons.filter_alt)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      /// my expense List
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: value.overallExpenseList.length,
                        itemBuilder: (context, index) {
                          final expense = value.overallExpenseList[index];
                          return ExpenseTile(
                            item: expense,
                            index: value.overallExpenseList.indexOf(expense),
                          );
                        },
                      )
                    ],
                  ),
                )
              : const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "No Expense Added",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
        );
      },
    );
  }
}
