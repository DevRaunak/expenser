import 'package:expenser/constants.dart';
import 'package:expenser/screens/add_expense/add_expense_page.dart';
import 'package:expenser/ui/custom_widgets/custom_rounded_btn.dart';
import 'package:expenser/ui/ui_helper.dart';
import 'package:flutter/material.dart';

class FragTransactionPage extends StatelessWidget {
  bool isLight = true;

  @override
  Widget build(BuildContext context) {
    isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: MediaQuery.of(context).orientation == Orientation.portrait
            ? portraitUI(context)
            : landscapeUI());
  }

  Widget landscapeUI() {
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
  }

  Widget portraitUI(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 1, child: addTransactionUI(context)),
        Expanded(flex: 7, child: totalBalanceUI()),
        Expanded(flex: 11, child: allTransactionsUI())
      ],
    );
  }

  Widget addTransactionUI(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddExpensePage(),));
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

  Widget allTransactionsUI() {
    return ListView.builder(
      itemCount: Constants.arrTransaction.length,
      itemBuilder: (context, index) =>
          dayWiseTransactionItem(Constants.arrTransaction[index]),
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
                  dayWiseTransDetails['day'],
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
          ListView.builder(
            itemCount: dayWiseTransDetails['transactions'].length,
            shrinkWrap: true,
            itemBuilder: (context, index) => detailTransactionItem(
                dayWiseTransDetails['transactions'][index]),
          ),
          SizedBox(
            height: 21,
          )
        ],
      ),
    );
  }

  Widget detailTransactionItem(Map detailedTrans) {
    return ListTile(
      leading: Image.asset(detailedTrans['image']),
      title: Text(detailedTrans['title'],
          style: mTextStyle12(
              mColor: isLight ? MyColor.textWColor : MyColor.textBColor,
              fontWeight: FontWeight.bold)),
      subtitle: Text(detailedTrans['desc'],
          style: mTextStyle12(
              mColor: isLight ? MyColor.textWColor : MyColor.textBColor)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('\$ ${detailedTrans['amt']}',
              style: mTextStyle12(
                  mColor: isLight ? MyColor.textWColor : MyColor.textBColor,
                  fontWeight: FontWeight.bold)),
          Text('\$ ${detailedTrans['balance']}',
              style: mTextStyle12(
                  mColor: isLight ? MyColor.textWColor : MyColor.textBColor))
        ],
      ),
    );
  }
}
