import 'package:flutter/material.dart';
import '../../data/model/person_model.dart';
import '../../data/repository/raising_repository.dart';
import '../../domain/usecase/raising_usecases.dart';

class RaisingProvider extends ChangeNotifier {
  late final AddPayment _addPayment;
  late final GetPersonsWithPayments _getPersons;
  late final DeletePayment _deletePayment;
  late final DeletePerson _deletePerson;
  late final GetTotalRaised _getTotalRaised;

  List<PersonModel> _persons = [];
  double _totalRaised = 0.0;

  List<PersonModel> get persons => _persons;
  double get totalRaised => _totalRaised;

  Map<String, List<PersonModel>> get byFloor {
    final map = <String, List<PersonModel>>{};
    for (final p in _persons) {
      map.putIfAbsent(p.floor, () => []).add(p);
    }
    return Map.fromEntries(
      map.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
  }

  RaisingProvider() {
    final repo = RaisingRepository();
    _addPayment = AddPayment(repo);
    _getPersons = GetPersonsWithPayments(repo);
    _deletePayment = DeletePayment(repo);
    _deletePerson = DeletePerson(repo);
    _getTotalRaised = GetTotalRaised(repo);
    load();
  }

  Future<void> load() async {
    _persons = await _getPersons();
    _totalRaised = await _getTotalRaised();
    notifyListeners();
  }

  Future<void> addPayment({
    required String name,
    required String floor,
    required double amount,
    required String date,
  }) async {
    await _addPayment(name: name, floor: floor, amount: amount, date: date);
    await load();
  }

  Future<void> deletePayment(int paymentId) async {
    await _deletePayment(paymentId);
    await load();
  }

  Future<void> deletePerson(int personId) async {
    await _deletePerson(personId);
    await load();
  }
}
