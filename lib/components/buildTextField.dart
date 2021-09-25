import 'package:flutter/material.dart';

TextField buildTextField(String textNT, IconData iconsNT,
    TextEditingController textFieldController, bool obsText) {
  return TextField(
    obscureText: obsText,
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
