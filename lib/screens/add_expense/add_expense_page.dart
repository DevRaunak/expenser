
import 'package:expenser/constants.dart';
import 'package:flutter/material.dart';

import '../../ui/ui_helper.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  var amtController = TextEditingController();
  var titleController = TextEditingController();
  var descController = TextEditingController();

  var _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                          onPressed: () {
                            showModalBottomSheet(context: context, 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(21), topRight: Radius.circular(21))
                                ),
                                builder: (context){
                              return GridView.builder(
                                shrinkWrap: true,
                                itemCount: Constants.arrType.length,
                                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 70),
                                  itemBuilder: (context, index){
                                return InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                    _selectedIndex = index;
                                    setState((){

                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(Constants.arrType[index]),
                                  ),
                                );
                                  });
                            });
                          },
                          child: _selectedIndex == -1 ? Text(
                            'Select Expense Type',
                            style: mTextStyle16(mColor: Colors.grey),
                          ) : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Selected - '),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(Constants.arrType[_selectedIndex]),
                              )
                            ],
                          ))),
                  SizedBox(
                    height: 21,
                  ),


                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
