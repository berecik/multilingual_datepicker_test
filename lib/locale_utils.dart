import 'package:flutter/material.dart';

Locale getLocale(String code) {
  var codes = code.split('_');
  if (codes.length > 1) {
    return Locale(codes[0], codes[1]);
  }
  return Locale(code);
}
