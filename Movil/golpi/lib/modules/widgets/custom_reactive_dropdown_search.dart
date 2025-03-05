

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';

class CustomReactiveDropdownSearch<T> extends ReactiveFormField<T, T> {
  CustomReactiveDropdownSearch({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    ShowErrorsFunction? super.showErrors,
    List<T> items = const [],
    PopupProps<T> popupProps = const PopupProps.menu(),
    DropdownSearchOnFind<T>? asyncItems,
    DropdownSearchBuilder<T>? dropdownBuilder,
    bool showClearButton = false,
    DropdownSearchFilterFn<T>? filterFn,
    DropdownSearchItemAsString<T>? itemAsString,
    DropdownSearchCompareFn<T>? compareFn,
    ClearButtonProps clearButtonProps = const ClearButtonProps(),
    DropdownButtonProps dropdownButtonProps = const DropdownButtonProps(),
    BeforeChange<T?>? onBeforeChange,
    TextAlign? dropdownSearchTextAlign,
    TextAlignVertical? dropdownSearchTextAlignVertical,
    FocusNode? focusNode,
    FormFieldSetter<T>? onSaved,
    TextStyle? dropdownSearchTextStyle,
    DropDownDecoratorProps dropdownDecoratorProps =
        const DropDownDecoratorProps(),
    BeforePopupOpening<T>? onBeforePopupOpening,
    VoidCallback? onChanged,
  }) : super(
          builder: (field) {
            final effectiveDecoration = (dropdownDecoratorProps
                        .dropdownSearchDecoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return DropdownSearch<T>(
              onChanged: (value) {
                field.didChange(value);
                if (onChanged != null) {
                  onChanged();
                }
              },
              popupProps: popupProps,
              selectedItem: field.value,
              items: items,
              asyncItems: asyncItems,
              dropdownBuilder: dropdownBuilder,
              enabled: field.control.enabled,
              filterFn: filterFn,
              itemAsString: itemAsString,
              compareFn: compareFn,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration:
                    effectiveDecoration.copyWith(errorText: field.errorText),
                baseStyle: dropdownDecoratorProps.baseStyle,
                textAlign: dropdownDecoratorProps.textAlign,
                textAlignVertical: dropdownDecoratorProps.textAlignVertical,
              ),
              clearButtonProps: clearButtonProps,
              dropdownButtonProps: dropdownButtonProps,
              onBeforeChange: onBeforeChange,
              onSaved: onSaved,
              onBeforePopupOpening: onBeforePopupOpening,
            );
          },
        );
}
