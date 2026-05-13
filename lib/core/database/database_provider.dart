import 'daos/payment_dao.dart';
import 'daos/person_dao.dart';
import 'db_helper.dart';

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider._();
  DatabaseProvider._();
  late final PersonDao personDao;
  late final PaymentDao paymentDao;
  bool _initialized = false;
  Future<void> init() async {
    if (_initialized) return;
    final db = await DbHelper.instance.database;
    personDao = PersonDao(db);
    paymentDao = PaymentDao(db);
    _initialized = true;
  }
}
