import 'package:expenser/bloc/ExpenseCatType/expense_type_bloc.dart';
import 'package:expenser/bloc/expense_bloc.dart';
import 'package:expenser/constants.dart';
import 'package:expenser/models/cat_model.dart';
import 'package:expenser/models/expense_model.dart';
import 'package:expenser/ui/custom_widgets/custom_rounded_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../ui/ui_helper.dart';

class AddExpensePage extends StatefulWidget {
  double balanceTillNow;

  AddExpensePage(this.balanceTillNow);


  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  var amtController = TextEditingController();
  var titleController = TextEditingController();
  var descController = TextEditingController();

  var _selectedIndex = -1;

  List<CatModel> arrExpenseType = [];

  var defaultDropDownValue = 'Debit';

  List<String> arrTransType = ['Debit', 'Credit'];

  bool selflag = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExpenseTypeBloc>(context).add(FetchAllCatExpenseType());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.bgBColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Stack(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: mTextStyle16(mColor: Colors.black),
                      )),
                  Center(
                      child: Text(
                    'Expense',
                    style: mTextStyle16(mColor: Colors.black),
                  ))
                ],
              ),
            ),
            Expanded(
                child: Container(
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      style: mTextStyle52(mColor: MyColor.textBColor),
                      controller: amtController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.currency_rupee_outlined,
                            size: 25,
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1))),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextField(
                    style: mTextStyle16(mColor: MyColor.textBColor),
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Add Title',
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1))),
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  TextField(
                    textAlign: TextAlign.end,
                    style: mTextStyle16(mColor: MyColor.textBColor),
                    controller: descController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Add Desc',
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1))),
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  BlocListener<ExpenseTypeBloc, ExpenseTypeState>(
                    listener: (context, state) {
                      if (state is ExpenseTypeLoadedState) {
                        arrExpenseType = state.arrExpenseType;
                        setState(() {});
                      }
                    },
                    child: Visibility(
                      visible: arrExpenseType.isNotEmpty,
                      child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(21),
                                            topRight: Radius.circular(21))),
                                    builder: (context) {
                                      return GridView.builder(
                                          shrinkWrap: true,
                                          itemCount: arrExpenseType.length,
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                                  maxCrossAxisExtent: 100),
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                _selectedIndex = index;
                                                setState(() {});
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Image.asset(
                                                    arrExpenseType[index]
                                                        .imgPath),
                                              ),
                                            );
                                          });
                                    });
                              },
                              child: _selectedIndex == -1
                                  ? Text(
                                      'Select Expense Type',
                                      style: mTextStyle16(mColor: Colors.grey),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Selected - ',
                                          style: mTextStyle16(
                                              mColor: MyColor.textBColor),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                              arrExpenseType[_selectedIndex]
                                                  .imgPath),
                                        )
                                      ],
                                    ))),
                    ),
                  ),
                  SizedBox(
                    height: 21,
                  ),


                  DropdownButton(
                    icon: Icon(Icons.arrow_drop_down_circle_outlined),
                      dropdownColor: Colors.black,
                      value: defaultDropDownValue,
                      items: arrTransType
                          .map((value) => DropdownMenuItem(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(value, style: mTextStyle16(mColor: Colors.white),),
                          ), value: value,))
                          .toList(),
                      onChanged: (dynamic selectedValue){
                        defaultDropDownValue = selectedValue;
                        setState((){

                        });
                      }),
                  SizedBox(
                    height: 21,
                  ),
                  BlocListener<ExpenseBloc, ExpenseState>(
                    listener: (context, state) {
                      if (state is ExpenseLoadingState) {
                        print("Loading");
                      } else if (state is ExpenseLoadedState) {
                        print("Loaded");
                        Navigator.pop(context);
                      }
                    },
                    child: CustomRoundedButton(
                        callback: () {
                          /*var frmt = DateFormat.y();
                          var frmt2 = DateFormat.MMMMd();
                          var frmt3 = DateFormat.Hms();

                          var currentTime =
                              '${frmt.format(DateTime.now())} ${frmt2.format(DateTime.now())} ${frmt3.format(DateTime.now())}.${DateTime.now().millisecond}';
                          print(currentTime);*/

                          var newBalance = 0.0;

                          if(defaultDropDownValue==arrTransType[0]){
                            //debit
                            newBalance = widget.balanceTillNow - double.parse(
                                amtController.text.toString());
                          } else {
                            //credit
                            newBalance = widget.balanceTillNow + double.parse(
                                amtController.text.toString());
                          }


                          if (_selectedIndex != -1) {
                            BlocProvider.of<ExpenseBloc>(context).add(
                                NewExpenseEvent(ExpenseModel(
                                    title: titleController.text,
                                    desc: descController.text,
                                    amt: double.parse(
                                        amtController.text.toString()),
                                    bal: newBalance,
                                    expenseType: defaultDropDownValue,
                                    catId: arrExpenseType[_selectedIndex].catId,
                                    time: DateTime.now().toString())));
                          }
                        },
                        text: 'Add'),
                  ),

                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

 /* @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.bgBColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 21.0),
          child: Column(
              children: [
                CustomRoundedButton(callback: (){
                  selflag = true;
                  setState((){});
                },
                    text: 'Credit', borderColor: selflag?Colors.red:Colors.transparent,),
                SizedBox(
                  height: 21,
                ),
                CustomRoundedButton(callback: (){
                  selflag = false;
                  setState((){});
                },
                    text: 'Debit', borderColor: selflag==false?Colors.red:Colors.transparent,)
              ],
            ),
        ),
      ),
    );
  }*/


}
