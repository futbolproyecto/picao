import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Utility {
  String? formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('yyyy-MM-dd').format(date);
    }

    return null;
  }

  String? formatHour(TimeOfDay? hour) {
    if (hour != null) {
      return '${hour.hour.toString().padLeft(2, '0')}:${hour.minute.toString().padLeft(2, '0')}';
    }

    return null;
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
