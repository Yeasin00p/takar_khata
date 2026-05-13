import 'package:sqflite/sqlite_api.dart';

class PersonDao {
  final Database db;
  PersonDao(this.db);

  Future<int> insert(String name, String floor) async {
    return await db.insert('persons', {'name': name, 'floor': floor});
  }

  Future<List> getAll() async {
    return await db.query('persons', orderBy: 'floor ASC, name ASC');
  }

  Future<int?> find(String name, String floor) async {
    final rows = await db.query(
      'persons',
      where: 'LOWER(name) = ? AND LOWER(floor) = ?',
      whereArgs: [name.toLowerCase(), floor.toLowerCase()],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return rows.first['id'] as int;
  }

  Future<int> delete(int id) async {
    return await db.delete('persons', where: 'id = ?', whereArgs: [id]);
  }
}
