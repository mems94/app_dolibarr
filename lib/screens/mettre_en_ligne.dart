import 'package:app_dolibarr/components/buildTextField.dart';
import 'package:flutter/material.dart';

class MettreEnLigne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mise en ligne'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildTextField("Identifiant", Icons.person, null, false),
              buildTextField("Mot de passe", Icons.lock, null, true),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => debugPrint("Mis en ligne"),
                child: Text('Uploader'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
