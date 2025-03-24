import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golpi/modules/widgets/custom_reactive_dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:golpi/modules/widgets/ui_text.dart';
import 'package:golpi/core/models/option_model.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';

class UiTextFiel {
  Widget textField({
    required String formControlName,
    required Map<String, String Function(Object)> validationMessages,
    required String labelText,
    required IconData prefixIcon,
    required Color colorPrefixIcon,
    IconButton? suffixIcon,
    Color? colorSuffixIcon,
    bool obscureText = false,
    TextInputType? textInputType,
  }) {
    return ReactiveTextField(
      formControlName: formControlName,
      validationMessages: validationMessages,
      keyboardType: textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontFamily: 'Montserrat',
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(prefixIcon, color: colorPrefixIcon),
        ),
        suffixIcon:
            Padding(padding: const EdgeInsets.all(8.0), child: suffixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.black26, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.black12),
        ),
      ),
    );
  }

  Widget datePickerField({
    required String formControlName,
    required Map<String, String Function(Object)> validationMessages,
    required String labelText,
    required IconData prefixIcon,
    required Color colorPrefixIcon,
    required DateTime firstDate,
    required DateTime lastDate,
    IconData? suffixIcon,
    Color? colorSuffixIcon,
    bool obscureText = false,
  }) {
    return ReactiveDateTimePicker(
      valueAccessor: DateTimeValueAccessor(
        dateTimeFormat: DateFormat('yyyy-MM-dd'),
      ),
      formControlName: formControlName,
      firstDate: firstDate,
      lastDate: lastDate,
      validationMessages: validationMessages,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontFamily: 'Montserrat',
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(prefixIcon, color: colorPrefixIcon),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(suffixIcon, color: colorSuffixIcon),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.black26, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.black12),
        ),
      ),
    );
  }

  Widget dropDownSearch({
    required String formControlName,
    required Map<String, String Function(Object)> validationMessages,
    required String labelText,
    required IconData prefixIcon,
    required Color colorPrefixIcon,
    required List<OptionModel> items,
    IconData? suffixIcon,
    Color? colorSuffixIcon,
    bool obscureText = false,
    VoidCallback? onChangeFuncion,
  }) {
    return CustomReactiveDropdownSearch<OptionModel>(
      onChanged: () {
        FocusScope.of(Get.context!).unfocus();
        if (onChangeFuncion != null) {
          onChangeFuncion();
        }
      },
      formControlName: formControlName,
      items: items,
      itemAsString: (OptionModel item) => item.name.toString(),
      dropdownBuilder: _customDropDown,
      showClearButton: true,
      filterFn: (item, filter) {
        return _normalizeText(item.name!).contains(filter.toLowerCase());
      },
      validationMessages: validationMessages,
      popupProps: PopupProps.dialog(
        showSearchBox: true,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Center(
            child: UiText(text: labelText).titlePrimaryColor(),
          ),
        ),
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.black54,
            fontFamily: 'Montserrat',
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(prefixIcon, color: colorPrefixIcon),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(suffixIcon, color: colorSuffixIcon),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.black26, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.black12),
          ),
        ),
      ),
    );
  }

  Widget _customDropDown(BuildContext context, OptionModel? item) {
    if (item == null) {
      return Text(
        'Seleccione...',
      );
    }
    return Text(
      item.name.toString(),
      style: TextStyle(color: Colors.black),
    );
  }

  String _normalizeText(String text) {
    return removeDiacritics(text).toLowerCase();
  }
}
