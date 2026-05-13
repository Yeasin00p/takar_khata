import 'package:intl/intl.dart';

class DateHelper {
  static String today() => DateFormat('yyyy-MM-dd').format(DateTime.now());
  static String format(String date) {
    final d = DateTime.tryParse(date);
    if (d == null) return date;
    return DateFormat('dd MMM yyyy').format(d);
  }
}