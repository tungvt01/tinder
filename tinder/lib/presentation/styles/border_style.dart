import 'package:flutter/material.dart';

UnderlineInputBorder underlineBorder(
    {double size = 0.2, Color color = Colors.green}) {
  return UnderlineInputBorder(
      borderSide: BorderSide(width: size, color: color));
}
