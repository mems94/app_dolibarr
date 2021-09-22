import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

SizedBox empty() {
  return const SizedBox.shrink();
}

SizedBox spacing({double vertical, double horizontal}) {
  return SizedBox(height: vertical, width: horizontal);
}

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
