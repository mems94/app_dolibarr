import 'package:flutter/material.dart';

void showMySnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text('$message'),
    duration: Duration(seconds: 5),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
