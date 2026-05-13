class PaymentModel {
  final int? id;
  final int personId;
  final double amount;
  final String date;

  PaymentModel({
    this.id,
    required this.personId,
    required this.amount,
    required this.date,
  });

  factory PaymentModel.fromMap(Map<String, dynamic> map) => PaymentModel(
    id: map['id'],
    personId: map['person_id'],
    amount: map['amount'],
    date: map['date'],
  );
}
