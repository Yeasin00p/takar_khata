import 'package:sqflite/sqflite.dart';

class MarketDao {
  final Database db;

  MarketDao(this.db);

  Future<int> insertMarket(Map<String, dynamic> data) async {
    return await db.insert('market', data);
  }

  Future<List<Map<String, dynamic>>> getAllMarkets() async {
    return await db.query('market', orderBy: 'date DESC');
  }

  Future<int> markMarketPaid(int id) async {
    return await db.update(
      'market',
      {'status': 'paid'},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteMarket(int id) async {
    return await db.delete('market', where: 'id = ?', whereArgs: [id]);
  }

  Future<double> getTotalRaised() async {
    final result = await db.rawQuery('''
    SELECT SUM(amount) AS total
    FROM payments
  ''');

    return (result.first['total'] as num?)?.toDouble() ?? 0.0;
  }

  Future<double> getTotalPaid() async {
    final r = await db.rawQuery(
      "SELECT SUM(cost) as total FROM market WHERE status = 'paid'",
    );
    return (r.first['total'] as double?) ?? 0.0;
  }

  Future<double> getTotalDue() async {
    final r = await db.rawQuery(
      "SELECT SUM(cost) as total FROM market WHERE status = 'due'",
    );
    return (r.first['total'] as double?) ?? 0.0;
  }

  Future<double> getRemainingBalance() async {
    final raised = await getTotalRaised();
    final paid = await getTotalPaid();
    return raised - paid;
  }

  Future close() async => await db.close();
}
