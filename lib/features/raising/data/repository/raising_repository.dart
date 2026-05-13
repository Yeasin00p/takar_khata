import '../../../../core/database/daos/person_dao.dart';
import '../../../../core/database/daos/payment_dao.dart';
import '../../../../core/database/database_provider.dart';
import '../model/payment_model.dart';
import '../model/person_model.dart';

class RaisingRepository {
  final PersonDao _personDao;
  final PaymentDao _paymentDao;

  RaisingRepository()
    : _personDao = DatabaseProvider.instance.personDao,
      _paymentDao = DatabaseProvider.instance.paymentDao;

  Future<List<PersonModel>> getPersonsWithPayments() async {
    final personRows = await _personDao.getAll();

    final List<PersonModel> result = [];

    for (final row in personRows) {
      final person = PersonModel.fromMap(row);

      final paymentRows = await _paymentDao.getForPerson(person.id!);
      final payments = paymentRows
          .map((r) => PaymentModel.fromMap(r as Map<String, dynamic>))
          .toList();

      final total = payments.fold(0.0, (sum, p) => sum + p.amount);

      result.add(person.copyWith(totalAmount: total, payments: payments));
    }

    return result;
  }

  Future<void> addPayment({
    required String name,
    required String floor,
    required double amount,
    required String date,
  }) async {
    int? personId = await _personDao.find(name, floor);
    personId ??= await _personDao.insert(name, floor);

    await _paymentDao.insert(personId, amount, date);
  }

  Future<void> deletePayment(int paymentId) => _paymentDao.delete(paymentId);

  Future<void> deletePerson(int personId) => _personDao.delete(personId);

  Future<double> getTotalRaised() => _paymentDao.total();
}
