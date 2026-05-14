import 'package:takar_khata/core/database/daos/market_dao.dart';
import 'package:takar_khata/core/database/database_provider.dart';

import '../model/market_model.dart';

class MarketRepository {
  final MarketDao _marketDao;

  MarketRepository() : _marketDao = DatabaseProvider.instance.marketDao;

  Future<List<MarketModel>> getAllMarkets() async {
    final rows = await _marketDao.getAllMarkets();
    return rows.map(MarketModel.fromMap).toList();
  }

  Future<void> addMarket(MarketModel m) => _marketDao.insertMarket(m.toMap());
  Future<void> markPaid(int id) => _marketDao.markMarketPaid(id);
  Future<void> deleteMarket(int id) => _marketDao.deleteMarket(id);
  Future<double> getTotalPaid() => _marketDao.getTotalPaid();
  Future<double> getTotalDue() => _marketDao.getTotalDue();
  Future<double> getBalance() => _marketDao.getRemainingBalance();
}
