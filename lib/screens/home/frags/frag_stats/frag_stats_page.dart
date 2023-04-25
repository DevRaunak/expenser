import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../bloc/expense_bloc.dart';
import '../../../../constants.dart';
import '../../../../models/expense_model.dart';
import '../../../../ui/ui_helper.dart';

class FragStatsPage extends StatefulWidget {
  const FragStatsPage({Key? key}) : super(key: key);

  @override
  State<FragStatsPage> createState() => _FragStatsPageState();
}

class _FragStatsPageState extends State<FragStatsPage> {
  List<ExpenseModel> arrExpense = [];
  List<Map<String, dynamic>> arrMonthWiseBal = [];

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ExpenseBloc>(context).add(FetchExpenseEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (context, state) {
            if (state is ExpenseLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ExpenseLoadedState) {
              arrExpense = state.arrExpenses.reversed.toList();
              if (state.arrExpenses.isNotEmpty) {
                arrMonthWiseBal.clear();
                List<String> arrUniqueMonths = [];

                for (ExpenseModel expense in arrExpense) {
                  var date = DateTime.parse(expense.time!);

                  var eachMonth =
                      '${date.year}-${date.month.toString().length == 1 ? '0${date.month}' : '${date.month}'}';

                  if (!arrUniqueMonths.contains(eachMonth)) {
                    arrUniqueMonths.add(eachMonth);
                  }
                }

                print(arrUniqueMonths);

                filterExpenseMonthWise(arrUniqueMonths);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Month',
                        style: TextStyle(fontSize: 34, color: MyColor.bgWColor),
                      ),
                      SizedBox(
                        height: 21,
                      ),
                      /*arrMonthWiseBal.isNotEmpty ? SfCartesianChart(
                       primaryXAxis: CategoryAxis(),
                       series: <ChartSeries<Map<String, dynamic>, String>>[
                         ColumnSeries(
                             dataSource: arrMonthWiseBal,
                             xValueMapper: (Map<String, dynamic> data, _)=> data['month'],
                             yValueMapper: (Map<String, dynamic> data, _)=> data['bal'])
                       ],
                     ) : Container()*/

                     /* SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        series: <LineSeries<Map<String, dynamic>, String>>[
                          LineSeries<Map<String, dynamic>, String>(
                              dataSource: arrMonthWiseBal,
                              xValueMapper: (Map<String, dynamic> data, _) =>
                                  data['month'],
                              yValueMapper: (Map<String, dynamic> data, _) =>
                                  data['bal'])
                        ],
                      )*/
                    ],
                  ),
                );
              } else {
                return Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No Expense Yet!',
                          style: mTextStyle43(
                              mColor: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                            onTap: () {}, child: Icon(Icons.add_box_outlined))
                      ],
                    ),
                  ),
                );
              }
            }

            return Container();
          },
        ),
      ),
    );
  }

  void filterExpenseMonthWise(List<String> uniqueMonths) {
    for (String eachMonth in uniqueMonths) {
      List<ExpenseModel> arrEachMonthExpense = [];

      for (ExpenseModel expense in arrExpense) {
        if (expense.time!.contains(eachMonth)) {
          arrEachMonthExpense.add(expense);
        }
      }

      double eachMonthBal = 0.0;

      for (ExpenseModel expense in arrEachMonthExpense) {
        if (expense.expenseType == "Debit") {
          eachMonthBal += expense.amt!;
        } else {
          eachMonthBal -= expense.amt!;
        }
      }

      print(Constants.mapMonth.toString());

      arrMonthWiseBal.add({
        'month': Constants.mapMonth[eachMonth.split('-')[1]],
        'bal': eachMonthBal
      });
    }

    print(arrMonthWiseBal);
  }
}
