import 'package:flutter/material.dart';
import '../../data/model/market_model.dart';
import '../../data/repositories/market_repository.dart';
import '../../domain/usecase/market_usecases.dart';

class MarketProvider extends ChangeNotifier {
  final _repo = MarketRepository();

  late final GetAllMarkets _getAll;
  late final AddMarket _add;
  late final MarkMarketPaid _markPaid;
  late final DeleteMarket _delete;

  List<MarketModel> _markets = [];
  double _totalPaid = 0.0;
  double _totalDue = 0.0;
  double _balance = 0.0;

  List<MarketModel> get markets => _markets;
  List<MarketModel> get dueMarkets => _markets.where((m) => m.isDue).toList();
  List<MarketModel> get paidMarkets => _markets.where((m) => !m.isDue).toList();
  double get totalPaid => _totalPaid;
  double get totalDue => _totalDue;
  double get balance => _balance;

  MarketProvider() {
    _getAll = GetAllMarkets(_repo);
    _add = AddMarket(_repo);
    _markPaid = MarkMarketPaid(_repo);
    _delete = DeleteMarket(_repo);
    load();
  }

  Future<void> load() async {
    _markets = await _getAll();
    _totalPaid = await _repo.getTotalPaid();
    _totalDue = await _repo.getTotalDue();
    _balance = await _repo.getBalance();
    notifyListeners();
  }

  Future<void> addMarket(MarketModel m) async {
    await _add(m);
    await load();
  }

  Future<void> markPaid(int id) async {
    await _markPaid(id);
    await load();
  }

  Future<void> deleteMarket(int id) async {
    await _delete(id);
    await load();
  }
}
