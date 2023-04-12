import 'package:expenser/models/cat_model.dart';
import 'package:expenser/models/expense_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  //Expense Table
  static const String EXPENSE_TABLE = "expense";
  static const String EXPENSE_COLUMN_ID = "eid";
  static const String EXPENSE_COLUMN_TITLE = "title";
  static const String EXPENSE_COLUMN_DESC = "desc";
  static const String EXPENSE_COLUMN_AMT = "amount";
  static const String EXPENSE_COLUMN_CAT_ID = "cat_id";
  static const String EXPENSE_COLUMN_EXPENSE_TYPE = "expense_type";
  static const String EXPENSE_COLUMN_TIME = "time";

  //Category Table
  static const String CAT_TABLE = "expense_cat";
  static const String CAT_COLUMN_ID = "cat_id";
  static const String CAT_COLUMN_NAME = "name";
  static const String CAT_COLUMN_PATH = "img_path";




  Future<Database> openDB() async {
    var directory = await getApplicationDocumentsDirectory();

    await directory.create(recursive: true);

    var path = "${directory.path}expense_db.db";

    return await openDatabase(path, version: 1, onCreate: (db, version) {

      //Creating Expense Table
      db.execute(
          "create table $EXPENSE_TABLE ( $EXPENSE_COLUMN_ID integer primary key autoincrement, $EXPENSE_COLUMN_TITLE text, $EXPENSE_COLUMN_DESC text, $EXPENSE_COLUMN_AMT real, $EXPENSE_COLUMN_CAT_ID integer, $EXPENSE_COLUMN_EXPENSE_TYPE integer, $EXPENSE_COLUMN_TIME text)"
      );

      //Creating Category Table
      db.execute(
          "create table $CAT_TABLE ( $CAT_COLUMN_ID integer primary key autoincrement, $CAT_COLUMN_NAME text, $CAT_COLUMN_PATH text)"
      );

      db.insert(CAT_TABLE, CatModel(name: "Travel", imgPath: "assets/images/expense_type/travel.png").toMap());
      db.insert(CAT_TABLE, {CAT_COLUMN_NAME : "Snacks", CAT_COLUMN_PATH: "assets/images/expense_type/snack.png"});
      db.insert(CAT_TABLE, {CAT_COLUMN_NAME : "Restaurant", CAT_COLUMN_PATH: "assets/images/expense_type/restaurant.png"});
      db.insert(CAT_TABLE, {CAT_COLUMN_NAME : "Movie", CAT_COLUMN_PATH: "assets/images/expense_type/popcorn.png"});
      db.insert(CAT_TABLE, {CAT_COLUMN_NAME : "Shopping", CAT_COLUMN_PATH: "assets/images/expense_type/shopping-bag.png"});
      db.insert(CAT_TABLE, {CAT_COLUMN_NAME : "FastFood", CAT_COLUMN_PATH: "assets/images/expense_type/fast-food.png"});
      db.insert(CAT_TABLE, {CAT_COLUMN_NAME : "Coffee", CAT_COLUMN_PATH: "assets/images/expense_type/coffee.png"});
      db.insert(CAT_TABLE, {CAT_COLUMN_NAME : "T-Shirt", CAT_COLUMN_PATH: "assets/images/expense_type/hawaiian-shirt.png"});
      db.insert(CAT_TABLE, {CAT_COLUMN_NAME : "Watch", CAT_COLUMN_PATH: "assets/images/expense_type/watch.png"});
      db.insert(CAT_TABLE, {CAT_COLUMN_NAME : "Vegetables", CAT_COLUMN_PATH: "assets/images/expense_type/vegetables.png"});
      db.insert(CAT_TABLE, {CAT_COLUMN_NAME : "Gift", CAT_COLUMN_PATH: "assets/images/expense_type/gift-box.png"});
      db.insert(CAT_TABLE, {CAT_COLUMN_NAME : "Recharge", CAT_COLUMN_PATH: "assets/images/expense_type/mobile-transfer.png"});

    });
  }



  Future<bool> addExpense(ExpenseModel expense) async{

    var myDB = await openDB();

    /*return myDB.insert(EXPENSE_TABLE, {
      EXPENSE_COLUMN_TITLE : expense.title,
      EXPENSE_COLUMN_DESC: expense.desc,
      EXPENSE_COLUMN_AMT: expense.amt,
      EXPENSE_COLUMN_CAT_ID : expense.catId,
      EXPENSE_COLUMN_EXPENSE_TYPE : expense.expenseType,
      EXPENSE_COLUMN_TIME: expense.time
    });*/

    return await myDB.insert(EXPENSE_TABLE, expense.toMap())>0;

  }

  Future<List<ExpenseModel>> fetchData() async{

    var myDB = await openDB();

    List<Map<String, dynamic>> data;

    data = await myDB.query(EXPENSE_TABLE);

    List<ExpenseModel> arrExpense = [];

    for(Map<String, dynamic> expense in data){
      /*ExpenseModel model = ExpenseModel();

      model.eid = expense[EXPENSE_COLUMN_ID];
      model.title = expense[EXPENSE_COLUMN_TITLE];
      model.desc = expense[EXPENSE_COLUMN_DESC];
      model.amt = expense[EXPENSE_COLUMN_AMT];
      model.catId = expense[EXPENSE_COLUMN_CAT_ID];
      model.expenseType = expense[EXPENSE_COLUMN_EXPENSE_TYPE];
      model.time = expense[EXPENSE_COLUMN_TIME];*/

      arrExpense.add(ExpenseModel.fromMap(expense));

    }

    return arrExpense;
  }

  Future<List<CatModel>> fetchAllCat() async{
    var myDB = await openDB();

    List<Map<String, dynamic>> data;

    data = await myDB.query(CAT_TABLE);

    List<CatModel> arrCat = [];

    for(Map<String, dynamic> category in data){
      arrCat.add(CatModel.fromMap(category));
    }

    return arrCat;
  }


}
