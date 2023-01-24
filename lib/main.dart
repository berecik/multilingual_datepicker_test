import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'date_picker_widget.dart';

const List<String> LOCALES_STRINGS = [
  'en', // English, no country code
  'he', // Hebrew, no country code
  'pl', // Polish, no country code
  'be', // Belarusian, no country code
  'zh', // Chinese, no country code
];

List<Locale> LOCALES = LOCALES_STRINGS.map((code) => Locale(code)).toList();

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: LOCALES,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Function onChange(String code) {
    return (DateTime? date) => print("$code: $date");
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> dates = LOCALES_STRINGS
        .map((code) => DatePickerWidget(
              onChange: onChange(code),
              locale: code,
              hintText: code,
              value: DateTime.now(),
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("DatePicker"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: dates,
        ),
      ),
    );
  }
}
