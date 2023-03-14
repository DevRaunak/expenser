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
}
