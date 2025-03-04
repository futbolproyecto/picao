import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Utility {
  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static void validateAllFields(FormGroup form) {
    for (final key in form.controls.keys) {
      if (form.controls[key]!.invalid) {
        form.controls[key]!.markAsTouched();
        form.controls[key]!.focus();
        break;
      }
    }
  }
}
