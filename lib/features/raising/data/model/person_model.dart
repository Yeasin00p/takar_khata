import 'payment_model.dart';

class PersonModel {
  final int? id;
  final String name;
  final String floor;
  final double totalAmount;
  final List<PaymentModel> payments;

  PersonModel({
    this.id,
    required this.name,
    required this.floor,
    this.totalAmount = 0.0,
    this.payments = const [],
  });

  factory PersonModel.fromMap(Map<String, dynamic> map) =>
      PersonModel(id: map['id'], name: map['name'], floor: map['floor']);

  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'floor': floor};

  PersonModel copyWith({double? totalAmount, List<PaymentModel>? payments}) =>
      PersonModel(
        id: id,
        name: name,
        floor: floor,
        totalAmount: totalAmount ?? this.totalAmount,
        payments: payments ?? this.payments,
      );
}
