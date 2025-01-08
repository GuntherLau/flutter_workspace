import 'package:flutter/material.dart';

class SnackBarUtil {
  static showSnackBar({
    required BuildContext context,
    required String text,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(milliseconds: 2000),
      ),
    );
  }
}