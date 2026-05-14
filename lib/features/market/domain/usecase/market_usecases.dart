import '../../data/model/market_model.dart';
import '../../data/repositories/market_repository.dart';

class GetAllMarkets {
  final MarketRepository repo;
  GetAllMarkets(this.repo);
  Future<List<MarketModel>> call() => repo.getAllMarkets();
}

class AddMarket {
  final MarketRepository repo;
  AddMarket(this.repo);
  Future<void> call(MarketModel m) => repo.addMarket(m);
}

class MarkMarketPaid {
  final MarketRepository repo;
  MarkMarketPaid(this.repo);
  Future<void> call(int id) => repo.markPaid(id);
}

class DeleteMarket {
  final MarketRepository repo;
  DeleteMarket(this.repo);
  Future<void> call(int id) => repo.deleteMarket(id);
}
