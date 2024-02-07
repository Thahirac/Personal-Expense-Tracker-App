import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker_app/provider/expense_provider.dart';
import 'package:provider/provider.dart';

class SummaryPieChart extends StatefulWidget {
  const SummaryPieChart({super.key});

  @override
  State<StatefulWidget> createState() => SummaryPieChartState();
}

class SummaryPieChartState extends State {
  int totalTouchedIndex = -1;
  int weekTouchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
        builder: (context, expenseProvider, child) {
          final double total = expenseProvider.getTotalAmount();
          final double weekTotal = expenseProvider.getWeekTotal();
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: expenseProvider.weekSummaryList.isNotEmpty ? 1 : 0,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        child: Visibility(
                          visible: expenseProvider.weekSummaryList.isNotEmpty,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  offset: const Offset(
                                    3.0,
                                    3.0,
                                  ),
                                  blurRadius: 5.0,
                                  spreadRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "This week Summary",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 200,
                                    //width: 150,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: PieChart(
                                        PieChartData(
                                          pieTouchData: PieTouchData(
                                            touchCallback: (FlTouchEvent event,
                                                pieTouchResponse) {
                                              setState(() {
                                                if (!event
                                                    .isInterestedForInteractions ||
                                                    pieTouchResponse == null ||
                                                    pieTouchResponse
                                                        .touchedSection ==
                                                        null) {
                                                  weekTouchedIndex = -1;
                                                  return;
                                                }
                                                weekTouchedIndex = pieTouchResponse
                                                    .touchedSection!
                                                    .touchedSectionIndex;
                                              });
                                            },
                                          ),
                                          borderData: FlBorderData(
                                            show: false,
                                          ),
                                          sectionsSpace: 2,
                                          centerSpaceRadius: 25,
                                          sections: ChartSelction(
                                              expenseProvider.weekSummaryList,
                                              weekTotal,true),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "\u{20B9} ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        '${weekTotal}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: expenseProvider.totalSummaryList.isNotEmpty ? 1 : 0,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        child: Visibility(
                          visible: expenseProvider.totalSummaryList.isNotEmpty,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  offset: const Offset(
                                    3.0,
                                    3.0,
                                  ),
                                  blurRadius: 5.0,
                                  spreadRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Total Summary",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 200,
                                    //width: 150,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: PieChart(
                                        PieChartData(
                                          pieTouchData: PieTouchData(
                                            touchCallback: (FlTouchEvent event,
                                                pieTouchResponse) {
                                              setState(() {
                                                if (!event
                                                    .isInterestedForInteractions ||
                                                    pieTouchResponse == null ||
                                                    pieTouchResponse
                                                        .touchedSection ==
                                                        null) {
                                                  totalTouchedIndex = -1;
                                                  return;
                                                }
                                                totalTouchedIndex = pieTouchResponse
                                                    .touchedSection!
                                                    .touchedSectionIndex;
                                              });
                                            },
                                          ),
                                          borderData: FlBorderData(
                                            show: false,
                                          ),
                                          sectionsSpace: 2,
                                          centerSpaceRadius: 25,
                                          sections: ChartSelction(
                                              expenseProvider.totalSummaryList,
                                              total,false),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "\u{20B9} ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        '${total}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: expenseProvider.weekSummaryList.isNotEmpty ||
                    expenseProvider.totalSummaryList.isNotEmpty,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: [
                            Indicator(
                              color: Colors.lightBlue.shade700,
                              text: 'Food',
                              isSquare: true,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 22,
                        ),
                        Indicator(
                          color: Colors.yellow.shade900,
                          text: 'Travel',
                          isSquare: true,
                        ),
                        const SizedBox(
                          width: 22,
                        ),
                        Indicator(
                          color: Colors.deepPurple.shade500,
                          text: 'Entertainment',
                          isSquare: true,
                        ),
                        const SizedBox(
                          width: 22,
                        ),
                        Indicator(
                          color: Colors.green.shade500,
                          text: 'Others',
                          isSquare: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  List<PieChartSectionData> ChartSelction(
      List<Map<String, double>> list, double total,bool isWeekly) {
    return List.generate(list.length, (i) {
      double percentage = (list[i].values.last / total) * 100;
      final isTouched = i == (isWeekly?weekTouchedIndex:totalTouchedIndex);
      final fontSize = isTouched ? 16.0 : 10.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.grey, blurRadius: 5)];

      return PieChartSectionData(
        color: getColors(list[i].keys.first),
        value: list[i].values.last,
        title: "${percentage.toDouble().toStringAsFixed(2)}%",
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    });
  }

  Color getColors(String item) {
    switch (item) {
      case 'Food':
        {
          return Colors.lightBlue.shade700;
        }
      case 'Travel':
        {
          return Colors.yellow.shade900;
        }
      case 'Entertainment':
        {
          return Colors.deepPurple.shade500;
        }
      default:
        {
          return Colors.green.shade500;
        }
    }
  }

}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 10,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.rectangle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: textColor,
              fontFamily: "Raleway"),
        )
      ],
    );
  }
}
