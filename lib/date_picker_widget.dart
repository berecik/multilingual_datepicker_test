import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'locale_utils.dart';

class DatePickerWidget extends StatefulWidget {
  final DateTime? value;
  final bool autofocus = false;
  final bool disabled = false;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? locale;
  final String? helpText;
  final String? cancelText;
  final String? confirmText;
  final TextInputType? keyboardType;
  final DatePickerMode? datePickerMode;
  final DatePickerEntryMode? datePickerEntryMode;
  final String? hintText;
  final Function? onChange;

  const DatePickerWidget(
      {super.key,
      this.value,
      this.firstDate,
      this.lastDate,
      this.locale,
      this.helpText,
      this.cancelText,
      this.confirmText,
      this.keyboardType,
      this.datePickerMode,
      this.datePickerEntryMode,
      this.hintText,
      this.onChange});

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? _value;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("DateField build");

    Locale locale;
    if (widget.locale == null) {
      locale = Localizations.localeOf(context);
    } else {
      locale = getLocale(widget.locale!);
    }

    initializeDateFormatting();

    void onChanged(DateTime? dateValue) {
      DateTime? value = dateValue;
      debugPrint(value.toString());
      setState(() {
        _value = value;
      });
      if (widget.onChange != null) {
        widget.onChange!(value);
      }
    }

    Future<void> selectDateDialog() async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _value ?? DateTime.now(),
        firstDate: widget.firstDate ?? DateTime(1900),
        lastDate: widget.lastDate ?? DateTime(2050),
        locale: locale,
        helpText: widget.helpText,
        cancelText: widget.cancelText,
        confirmText: widget.confirmText,
        keyboardType: widget.keyboardType,
        initialDatePickerMode: widget.datePickerMode ?? DatePickerMode.day,
        initialEntryMode:
            widget.datePickerEntryMode ?? DatePickerEntryMode.calendar,
        fieldHintText: widget.hintText,
      );
      if (!widget.disabled && pickedDate != null && pickedDate != _value) {
        onChanged(pickedDate);
      }
    }

    String buttonText;

    if (_value == null) {
      buttonText = widget.hintText ?? "";
    } else {
      buttonText = DateFormat.yMMMd(locale.toString()).format(_value!);
    }

    Widget button = ElevatedButton.icon(
      onPressed: selectDateDialog,
      autofocus: widget.autofocus,
      icon: const Icon(Icons.calendar_month),
      label: Text(buttonText),
    );

    return button;
  }
}
