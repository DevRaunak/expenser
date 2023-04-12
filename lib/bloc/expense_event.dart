part of 'expense_bloc.dart';



@immutable
abstract class ExpenseEvent {}

class NewExpenseEvent extends ExpenseEvent{
  ExpenseModel newExpense;
  NewExpenseEvent(this.newExpense);
}


class FetchExpenseEvent extends ExpenseEvent{}
