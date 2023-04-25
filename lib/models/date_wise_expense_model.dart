import 'expense_model.dart';

class DateWiseExpenseModel {
  String date;
  String amt;
  List<ExpenseModel> arrExpenses;

  DateWiseExpenseModel(
      {required this.date, required this.amt, required this.arrExpenses});

  factory DateWiseExpenseModel.fromMap(Map<String, dynamic> map){
    return DateWiseExpenseModel(
        date: map['date'],
        amt: map['amt'],
        arrExpenses: map['arrExpenses'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'date' : date,
      'amt' : amt,
      'arrExpenses' : arrExpenses,
    };
  }
}
