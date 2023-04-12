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

import '../../../../models/expense_model.dart';

class FragTransactionPage extends StatefulWidget {
  @override
  State<FragTransactionPage> createState() => _FragTransactionPageState();
}

class _FragTransactionPageState extends State<FragTransactionPage> {
  bool isLight = true;

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
        body: BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (ctx, state) {
            if (state is ExpenseLoadingState) {
              return CircularProgressIndicator();
            } else if (state is ExpenseLoadedState) {
              if (state.arrExpenses.isNotEmpty) {
                return MediaQuery.of(context).orientation ==
                        Orientation.portrait
                    ? portraitUI(context, state.arrExpenses)
                    : portraitUI(context, state.arrExpenses);
              } else {
                return Container(
                  child: Center(
                    child: Text(
                      'No Expense Yet!',
                      style: mTextStyle43(
                          mColor: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              }
            } else if (state is ExpenseErrorState) {
              return Container();
            }
            return Container();
          },
        ));
  }

  /*Widget landscapeUI() {
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
        Expanded(child: allTransactionsUI())
      ],
    );
  }*/

  Widget portraitUI(BuildContext context, List<ExpenseModel> arrExpense) {
    return Column(
      children: [
        Expanded(flex: 1, child: addTransactionUI(context)),
        Expanded(flex: 7, child: totalBalanceUI()),
        Expanded(flex: 11, child: allTransactionsUI(arrExpense))
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
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddExpensePage(),
                ));
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
        Text('Spent this Week',
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
              text: '292',
              style: mTextStyle52(
                  fontWeight: FontWeight.bold,
                  mColor: isLight ? MyColor.textWColor : MyColor.textBColor)),
          TextSpan(
              text: '.50',
              style: mTextStyle26(
                  fontWeight: FontWeight.bold,
                  mColor: isLight ? MyColor.textWColor : MyColor.textBColor))
        ]))
      ],
    );
  }

  Widget allTransactionsUI(arrExpense) {
    return ListView.builder(
      itemCount: arrExpense.length,
      itemBuilder: (context, index) =>
          dayWiseTransactionItem((arrExpense[index] as ExpenseModel).toMap()),
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
                  'Today',
                  /*dayWiseTransDetails['day'],*/
                  style: mTextStyle12(
                      mColor: isLight
                          ? MyColor.secondaryWColor
                          : MyColor.secondaryBColor),
                ),
                Text(
                  '\$100' /*'\$ ${dayWiseTransDetails['amt']}'*/,
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
              if(state is ExpenseTypeLoadedState) {
                return detailTransactionItem(dayWiseTransDetails, state.arrExpenseType);
              } else if(state is ExpenseTypeLoadingState){
                return CircularProgressIndicator();
              }
              return Container();
            },
          ),
          /*ListView.builder(
            itemCount: dayWiseTransDetails['transactions'].length,
            shrinkWrap: true,
            itemBuilder: (context, index) => detailTransactionItem(
                dayWiseTransDetails['transactions'][index]),
          ),*/
          SizedBox(
            height: 21,
          )
        ],
      ),
    );
  }

  Widget detailTransactionItem(Map detailedTrans, List<CatModel>arrExpenseType) {

    var catImgPath = "";

    print(detailedTrans[DBHelper.EXPENSE_COLUMN_CAT_ID]);


    for(CatModel cat in arrExpenseType){
      if(cat.catId==detailedTrans[DBHelper.EXPENSE_COLUMN_CAT_ID]){
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
          Text('\$ ${detailedTrans[DBHelper.EXPENSE_COLUMN_AMT]}',
              style: mTextStyle12(
                  mColor: isLight ? MyColor.textWColor : MyColor.textBColor))
        ],
      ),
    );
  }
}
