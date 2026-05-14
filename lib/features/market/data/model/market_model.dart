class MarketModel {
  final int? id;
  final String item;
  final double cost;
  final String date;
  final String status; // 'due' | 'paid'

  MarketModel({
    this.id,
    required this.item,
    required this.cost,
    required this.date,
    required this.status,
  });

  bool get isDue => status == 'due';

  factory MarketModel.fromMap(Map<String, dynamic> m) => MarketModel(
    id: m['id'],
    item: m['item'],
    cost: (m['cost'] as num).toDouble(),
    date: m['date'],
    status: m['status'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'item': item,
    'cost': cost,
    'date': date,
    'status': status,
  };
}
