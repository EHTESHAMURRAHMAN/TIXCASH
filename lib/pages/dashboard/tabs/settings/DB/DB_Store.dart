import 'package:sqflite/sqflite.dart' as sql;

class SQLHELPER {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE data(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
         currency TEXT,
      addresss TEXT,

     createdAT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("database_name.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createData(
      String title, String currency, String? addresss) async {
    final db = await SQLHELPER.db();
    final data = {'title': title, 'currency': currency, 'addresss': addresss};
    final id = await db.insert('data', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await SQLHELPER.db();
    return db.query('data', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await SQLHELPER.db();
    return db.query('data', where: "id=?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateData(
      int id, String title, String currency, String? addresss) async {
    final db = await SQLHELPER.db();
    final data = {
      'title': title,
      'currency': currency,
      'addresss': addresss,
      'createdAT': DateTime.now().toString()
    };
    final result =
        await db.update('data', data, where: "id=?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteData(int id) async {
    final db = await SQLHELPER.db();
    try {
      await db.delete('data', where: "id=?", whereArgs: [id]);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
