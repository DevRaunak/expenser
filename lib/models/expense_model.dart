import 'package:expenser/db_helper.dart';

class ExpenseModel {
  int? eid;
  String? title;
  String? desc;
  double? amt;
  int? catId;
  String? expenseType;
  String? time;

  ExpenseModel(
      {this.eid,
      this.title,
      this.desc,
      this.amt,
      this.catId,
      this.expenseType,
      this.time});

  factory ExpenseModel.fromMap(Map<String, dynamic> map){
    return ExpenseModel(
      eid: map[DBHelper.EXPENSE_COLUMN_ID],
      title: map[DBHelper.EXPENSE_COLUMN_TITLE],
      desc: map[DBHelper.EXPENSE_COLUMN_DESC],
      amt: map[DBHelper.EXPENSE_COLUMN_AMT],
      catId: map[DBHelper.EXPENSE_COLUMN_CAT_ID],
      expenseType: map[DBHelper.EXPENSE_COLUMN_EXPENSE_TYPE],
      time: map[DBHelper.EXPENSE_COLUMN_TIME]
    );
  }

  Map<String, dynamic> toMap(){
    return {
      DBHelper.EXPENSE_COLUMN_TITLE : title,
      DBHelper.EXPENSE_COLUMN_DESC : desc,
      DBHelper.EXPENSE_COLUMN_AMT : amt,
      DBHelper.EXPENSE_COLUMN_CAT_ID : catId,
      DBHelper.EXPENSE_COLUMN_EXPENSE_TYPE : expenseType,
      DBHelper.EXPENSE_COLUMN_TIME : time,
    };
  }

}
