import 'package:flutter/material.dart';

TextFormField buildTextField(String textNT, IconData iconsNT,
    TextEditingController textFieldController, bool obsText,
    {TextInputType clavier = TextInputType.text}) {
  return TextFormField(
    keyboardType: clavier,
    obscureText: obsText,
    controller: textFieldController,
    style: TextStyle(
      fontWeight: FontWeight.normal,
    ),
    onEditingComplete: () {},
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Champ vide non autorisé';
      }
      return null;
    },
    decoration: InputDecoration(
      hintText: textNT,
      hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
      // labelText: textNT,
      icon: Icon(
        iconsNT,
      ),
    ),
  );
}
