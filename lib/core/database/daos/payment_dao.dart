import 'package:sqflite/sqlite_api.dart';

class PaymentDao {
  final Database db;
  PaymentDao(this.db);

  Future<int> insert(int personId, double amount, String date) async {
    return await db.insert('payments', {
      'person_id': personId,
      'amount': amount,
      'date': date,
    });
  }

  Future<List> getForPerson(int personId) async {
    return await db.query(
      'payments',
      where: 'person_id = ?',
      whereArgs: [personId],
      orderBy: 'date DESC',
    );
  }

  Future<int> delete(int id) async {
    return await db.delete('payments', where: 'id = ?', whereArgs: [id]);
  }

  Future<double> total() async {
    final r = await db.rawQuery('SELECT SUM(amount) as total FROM payments');
    return (r.first['total'] as double?) ?? 0.0;
  }
}
