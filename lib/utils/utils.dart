import 'package:flutter/material.dart';

class Utils{
  static void showSnackBar(
      {required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}