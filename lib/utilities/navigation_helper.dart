import 'package:flutter/material.dart';

void goto(BuildContext context, Widget screen, {bool isReplaced = false}) {
  isReplaced
      ? Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => screen))
      : Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
}
