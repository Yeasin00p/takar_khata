import '../../data/model/person_model.dart';
import '../../data/repository/raising_repository.dart';

class GetPersonsWithPayments {
  final RaisingRepository _repo;
  GetPersonsWithPayments(this._repo);

  Future<List<PersonModel>> call() => _repo.getPersonsWithPayments();
}

class AddPayment {
  final RaisingRepository _repo;
  AddPayment(this._repo);

  Future<void> call({
    required String name,
    required String floor,
    required double amount,
    required String date,
  }) => _repo.addPayment(name: name, floor: floor, amount: amount, date: date);
}

class DeletePayment {
  final RaisingRepository _repo;
  DeletePayment(this._repo);

  Future<void> call(int paymentId) => _repo.deletePayment(paymentId);
}

class DeletePerson {
  final RaisingRepository _repo;
  DeletePerson(this._repo);

  Future<void> call(int personId) => _repo.deletePerson(personId);
}

class GetTotalRaised {
  final RaisingRepository _repo;
  GetTotalRaised(this._repo);

  Future<double> call() => _repo.getTotalRaised();
}
