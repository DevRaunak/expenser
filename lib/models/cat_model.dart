import 'package:expenser/db_helper.dart';

class CatModel {
  int? catId;
  String name;
  String imgPath;

  CatModel({this.catId, required this.name, required this.imgPath});

  factory CatModel.fromMap(Map<String, dynamic> map) {
    return CatModel(
        catId: map[DBHelper.CAT_COLUMN_ID],
        name: map[DBHelper.CAT_COLUMN_NAME],
        imgPath: map[DBHelper.CAT_COLUMN_PATH]
    );
  }

  Map<String, dynamic> toMap() => {
    DBHelper.CAT_COLUMN_NAME : name,
    DBHelper.CAT_COLUMN_PATH : imgPath
  };
}
