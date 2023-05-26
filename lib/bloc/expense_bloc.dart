import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expenser/db_helper.dart';
import 'package:expenser/models/expense_model.dart';
import 'package:meta/meta.dart';

part 'expense_state.dart';
part 'expense_event.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final DBHelper dbHelper;
  ExpenseBloc({required this.dbHelper}) : super(ExpenseInitialState()) {

    on<NewExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      if(await dbHelper.addExpense(event.newExpense)){
        var arrExpenses = await dbHelper.fetchData();
        emit(ExpenseLoadedState(arrExpenses));
      } else {
        emit(ExpenseErrorState("Expense not Added!!"));
      }

    });

    on<FetchExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      var arrExpenses = await dbHelper.fetchData();
      emit(ExpenseLoadedState(arrExpenses));
    });
  }
}
