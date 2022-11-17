import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showMessage(
  BuildContext context,
  String message, {
  bool isError = true,
}) {
  Flushbar(
    message: message,
    duration: const Duration(seconds: 4),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.easeIn,
    animationDuration: const Duration(milliseconds: 200),
    backgroundColor:
        isError ? const Color(0xff9c2d05) : const Color(0xff197527),
    isDismissible: true,
    titleText: Text(
      isError ? "Error" : 'Success',
      style: const TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
    ),
    icon: const Icon(
      Icons.error,
      color: Colors.white,
    ),
  ).show(context);
}

void showSuccessMessage(BuildContext context, {String? message}) {
  Flushbar(
    message: message!,
    duration: const Duration(seconds: 4),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.easeIn,
    animationDuration: const Duration(milliseconds: 500),
    backgroundColor: Colors.green,
    isDismissible: true,
    titleText: const Text(
      'Success',
      style: TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
    ),
    icon: const Icon(
      Icons.check,
      color: Colors.white,
    ),
  ).show(context);
}