import 'package:flutter/material.dart';

extension StringExtension on String {
  get categoryColor {
    switch (this) {
      case 'Entertainment':
        return Colors.red[400];
      case 'Food':
        return Colors.green[400];
      case 'Personal':
        return Colors.blue[400];
      case 'Transportation':
        return Colors.purple[400];
      default:
        return Colors.orange[400];
    }
  }
}
