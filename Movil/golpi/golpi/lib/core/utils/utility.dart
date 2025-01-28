import 'package:intl/intl.dart';

class Utility {
  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
