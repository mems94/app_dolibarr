import 'package:flutter/material.dart';

TextField buildTextField(String textNT, IconData iconsNT,
    TextEditingController textFieldController) {
  return TextField(
    controller: textFieldController,
    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    onEditingComplete: () {},
    decoration: InputDecoration(
      labelText: textNT,
      icon: Icon(
        iconsNT,
      ),
    ),
  );
}
