import 'package:flutter/material.dart';

Color getProductColor(String? color) {
    switch (color) {
      case 'Green':
        return Colors.green;

      case 'Blue':
        return Colors.blue;

      case 'Orange':
        return Colors.orange;

      case 'Purple':
        return Colors.purple;

      case 'Pink':
        return Colors.pink;

      default:
        return Colors.grey;
    }
  }