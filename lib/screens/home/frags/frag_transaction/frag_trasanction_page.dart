import 'package:expenser/bloc/ExpenseCatType/expense_type_bloc.dart';
import 'package:expenser/bloc/expense_bloc.dart';
import 'package:expenser/constants.dart';
import 'package:expenser/db_helper.dart';
import 'package:expenser/models/cat_model.dart';
import 'package:expenser/screens/add_expense/add_expense_page.dart';
import 'package:expenser/ui/custom_widgets/custom_rounded_btn.dart';
import 'package:expenser/ui/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../models/date_wise_expense_model.dart';
import '../../../../models/expense_model.dart';

class FragTransactionPage extends StatefulWidget {
  @override
  State<FragTransactionPage> createState() => _FragTransactionPageState();
}

class _FragTransactionPageState extends State<FragTransactionPage> {
  bool isLight = true;

  List<ExpenseModel> arrExpense = [];
  List<DateWiseExpenseModel> arrData = [];
  var frmt = DateFormat.y();
  var frmt2 = DateFormat.MMMMd();
  var frmt3 = DateFormat.MMMM();
  var frmt4 = DateFormat.d();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExpenseBloc>(context).add(FetchExpenseEvent());
    BlocProvider.of<ExpenseTypeBloc>(context).add(FetchAllCatExpenseType());
  }

  @override
  Widget build(BuildContext context) {
    isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: [
            Expanded(flex: 1, child: addTransactionUI(context)),
            Expanded(
              flex: 18,
              child: BlocBuilder<ExpenseBloc, ExpenseState>(
                builder: (ctx, state) {
                  if (state is ExpenseLoadingState) {
                    return CircularProgressIndicator();
                  } else if (state is ExpenseLoadedState) {
                    arrExpense = state.arrExpenses.reversed.toList();
                    if (state.arrExpenses.isNotEmpty) {
                      arrData.clear();
                      List<String> arrUniqueDates = [];
                      List<String> arrUniqueMonths = [];

                      for (ExpenseModel expense in arrExpense) {
                        var date = DateTime.parse(expense.time!);

                        var eachDate =
                            '${date.year}-${date.month.toString().length == 1 ? '0${date.month}' : '${date.month}'}-${date.day}';
                        print(eachDate);

                        var eachMonth =
                            '${date.year}-${date.month.toString().length == 1 ? '0${date.month}' : '${date.month}'}';

                        if (!arrUniqueDates.contains(eachDate)) {
                          arrUniqueDates.add(eachDate);
                        }

                        if(!arrUniqueMonths.contains(eachMonth)){
                          arrUniqueMonths.add(eachMonth);
                        }
                      }

                      print(arrUniqueDates);
                      print(arrUniqueMonths);

                      filterExpensesDateWise(arrUniqueDates);
                      //filterExpenseMonthWise(arrUniqueMonths);

                      return MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? portraitUI(context, arrData)
                          : landscapeUI(context, arrData);
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
                                  onTap: () {

                                  },
                                  child: Icon(Icons.add_box_outlined))
                            ],
                          ),
                        ),
                      );
                    }
                  } else if (state is ExpenseErrorState) {
                    return Container();
                  }
                  return Container();
                },
              ),
            ),
          ],
        ));
  }

  void navigateToAddExpensePage(){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddExpensePage(
              arrExpense.isNotEmpty
                  ? arrExpense[0]
                  .bal!
                  : 0.0),
        ));
  }

  void filterExpensesDateWise(List<String> uniqueDates) {
    for (String date in uniqueDates) {
      List<ExpenseModel> eachDayTransactions = [];

      eachDayTransactions =
          arrExpense.where((expense) => expense.time!.contains(date)).toList();

      double eachDayAmt = 0.0;

      for (ExpenseModel trans in eachDayTransactions) {
        eachDayAmt = trans.expenseType == "Debit"
            ? eachDayAmt + trans.amt!
            : eachDayAmt - trans.amt!;
      }

      var todayDate = '${DateTime
          .now()
          .year}-${DateTime
          .now()
          .month
          .toString()
          .length == 1 ? '0${DateTime
          .now()
          .month}' : '${DateTime
          .now()
          .month}'}-${DateTime
          .now()
          .day}';

      var yesterdayDate =
          '${DateTime
          .now()
          .year}-${DateTime
          .now()
          .month
          .toString()
          .length == 1 ? '0${DateTime
          .now()
          .month}' : '${DateTime
          .now()
          .month}'}-${DateTime
          .now()
          .day - 1}';

      if (date == todayDate) {
        date = 'Today';
      } else if (date == yesterdayDate) {
        date = 'Yesterday';
      }

      arrData.add(DateWiseExpenseModel(
          date: date,
          amt: eachDayAmt.toString(),
          arrExpenses: eachDayTransactions));

      /* var today = DateTime.now().day;
    var month = DateTime.now().month;
    var year = DateTime.now().year;*/

      /*var frmt = DateFormat.y();
    var frmt2 = DateFormat.MMMMd();

    var todayMonthYear =
        '${frmt.format(DateTime.now())} ${frmt2.format(DateTime.now())}';

    print(todayMonthYear);*/
      /*arrExpense.where((expense) {
      if(expense.time!.contains(todayMonthYear)){
        arrTransactions.add(expense);
      }
      return true;
    });*/

      /*for (ExpenseModel expense in arrExpense) {
        if (expense.time!.contains(date)) {
          eachDayTransactions.add(expense);
        }
      }*/

      /* arrExpense.removeWhere((expense) {
        if (expense.time!.contains(todayMonthYear)) {
          return true;
        } else {
          return false;
        }
      });*/

      /*var totalOtherAmt = 0.0;
      for (ExpenseModel expense in arrExpense) {
        if (expense.expenseType == "Debit") {
          totalOtherAmt += expense.amt!;
        } else {
          totalOtherAmt -= expense.amt!;
        }
      }

      arrData.add(DateWiseExpenseModel(
          date: 'Prev',
          amt: totalOtherAmt.toString(),
          arrExpenses: arrExpense));
    }*/
    }
  }

  /*void filterExpenseMonthWise(List<String> uniqueMonths){

    List<Map<String,dynamic>> arrMonthWiseBal = [];

    for(String eachMonth in uniqueMonths){

      List<ExpenseModel> arrEachMonthExpense = [];

      for(ExpenseModel expense in arrExpense){
        if(expense.time!.contains(eachMonth)){
          arrEachMonthExpense.add(expense);
        }
      }

      double eachMonthBal = 0.0;

      for(ExpenseModel expense in arrEachMonthExpense){
        if(expense.expenseType=="Debit"){
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

  }*/


    Widget landscapeUI(BuildContext context, List<DateWiseExpenseModel> arrDayWiseExpense) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              totalBalanceUI(),
              SizedBox(
                height: 21,
              ),
              SizedBox(
                width: 200,
                height: 40,
                child: CustomRoundedButton(
                    callback: () {

                    },
                    text: "",
                    mChild: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: isLight ? MyColor.bgWColor : MyColor.bgBColor),
                        Text('Add Expense', style : mTextStyle16(mColor: isLight ? MyColor.bgWColor : MyColor.bgBColor))
                      ],
                    )),
              )
            ],
          ),
        ),
        Expanded(child: allTransactionsUI(arrDayWiseExpense))
      ],
    );
  }

  Widget portraitUI(
      BuildContext context, List<DateWiseExpenseModel> arrDayWiseExpense) {
    return Column(
      children: [
        Expanded(flex: 7, child: totalBalanceUI()),
        Expanded(flex: 11, child: allTransactionsUI(arrDayWiseExpense))
      ],
    );
  }

  Widget addTransactionUI(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
            navigateToAddExpensePage();
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircleAvatar(
              backgroundColor: isLight ? MyColor.bgBColor : MyColor.bgWColor,
              child: Icon(
                Icons.add,
                color: isLight ? MyColor.bgWColor : MyColor.bgBColor,
                size: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget totalBalanceUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Spent Till now',
            style: mTextStyle12(
                mColor: isLight
                    ? MyColor.secondaryWColor
                    : MyColor.secondaryBColor)),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: '\$ ',
              style: mTextStyle26(
                  mColor: isLight
                      ? MyColor.secondaryWColor
                      : MyColor.secondaryBColor,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: '${arrExpense[0].bal.toString().split('.')[0]}',
              style: mTextStyle52(
                  fontWeight: FontWeight.bold,
                  mColor: isLight ? MyColor.textWColor : MyColor.textBColor)),
          TextSpan(
              text: '.${arrExpense[0].bal.toString().split('.')[1]}',
              style: mTextStyle26(
                  fontWeight: FontWeight.bold,
                  mColor: isLight ? MyColor.textWColor : MyColor.textBColor))
        ]))
      ],
    );
  }

  Widget allTransactionsUI(List<DateWiseExpenseModel>arrDayWiseExpense) {
    return ListView.builder(
      itemCount: arrDayWiseExpense.length,
      itemBuilder: (context, index) => dayWiseTransactionItem(
          (arrDayWiseExpense[index]).toMap()),
    );
  }

  Widget dayWiseTransactionItem(Map dayWiseTransDetails) {
    return Padding(
      padding: const EdgeInsets.only(right: 11.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dayWiseTransDetails['date'],
                  style: mTextStyle12(
                      mColor: isLight
                          ? MyColor.secondaryWColor
                          : MyColor.secondaryBColor),
                ),
                Text(
                  '\$ ${dayWiseTransDetails['amt']}',
                  style: mTextStyle12(
                      mColor: isLight
                          ? MyColor.secondaryWColor
                          : MyColor.secondaryBColor),
                )
              ],
            ),
          ),
          BlocBuilder<ExpenseTypeBloc, ExpenseTypeState>(
            builder: (context, state) {
              if (state is ExpenseTypeLoadedState) {
                return ListView.builder(
                  itemCount: dayWiseTransDetails['arrExpenses'].length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => detailTransactionItem(
                      (dayWiseTransDetails['arrExpenses'][index]
                              as ExpenseModel)
                          .toMap(),
                      state.arrExpenseType),
                );
              } else if (state is ExpenseTypeLoadingState) {
                return CircularProgressIndicator();
              }
              return Container();
            },
          ),
          SizedBox(
            height: 21,
          )
        ],
      ),
    );
  }

  Widget detailTransactionItem(
      Map detailedTrans, List<CatModel> arrExpenseType) {
    var catImgPath = "";

    print(detailedTrans[DBHelper.EXPENSE_COLUMN_CAT_ID]);

    for (CatModel cat in arrExpenseType) {
      if (cat.catId == detailedTrans[DBHelper.EXPENSE_COLUMN_CAT_ID]) {
        catImgPath = cat.imgPath;
      }
    }

    print(catImgPath);

    return ListTile(
      leading: Image.asset(catImgPath),
      title: Text(detailedTrans[DBHelper.EXPENSE_COLUMN_TITLE],
          style: mTextStyle12(
              mColor: isLight ? MyColor.textWColor : MyColor.textBColor,
              fontWeight: FontWeight.bold)),
      subtitle: Text(detailedTrans[DBHelper.EXPENSE_COLUMN_DESC],
          style: mTextStyle12(
              mColor: isLight ? MyColor.textWColor : MyColor.textBColor)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('\$ ${detailedTrans[DBHelper.EXPENSE_COLUMN_AMT]}',
              style: mTextStyle12(
                  mColor: isLight ? MyColor.textWColor : MyColor.textBColor,
                  fontWeight: FontWeight.bold)),
          Text('\$ ${detailedTrans[DBHelper.EXPENSE_COLUMN_BAL]}',
              style: mTextStyle12(
                  mColor: isLight ? MyColor.textWColor : MyColor.textBColor))
        ],
      ),
    );
  }
}
