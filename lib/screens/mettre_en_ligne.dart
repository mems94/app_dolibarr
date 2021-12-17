import 'package:app_dolibarr/components/buildTextField.dart';
import 'package:app_dolibarr/services/check_connectivity.dart';
import 'package:app_dolibarr/utilities/mettre_en_ligne.dart';
import 'package:app_dolibarr/utilities/showSnackBar.dart';
import 'package:flutter/material.dart';

class MettreEnLigne extends StatefulWidget {
  //Id from the accueil
  // int id;
  // MettreEnLigne();

  @override
  _MettreEnLigneState createState() => _MettreEnLigneState();
}

class _MettreEnLigneState extends State<MettreEnLigne> {
  TextEditingController _controlleridentifiant = TextEditingController();
  TextEditingController _controllerMotDePasse = TextEditingController();
  TextEditingController _controllerURL = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();
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
          child: Form(
            key: _loginFormKey,
            child: Column(
              children: [
                buildTextField(
                    "Identifiant", Icons.person, _controlleridentifiant, false),
                buildTextField(
                    "Mot de passe", Icons.lock, _controllerMotDePasse, true),
                buildTextField("Addresse de Dolibarr", Icons.public,
                    _controllerURL, false),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // primary: Colors.green,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    //check textField is not empty
                    if (_loginFormKey.currentState.validate()) {
                      //check connectivity
                      bool connectivity = await checkConnectivity();
                      //if ok do all actions below otherwise show snackbar
                      if (connectivity) {
                        mettreEnLigne(
                            _controlleridentifiant.text,
                            _controllerMotDePasse.text,
                            _controllerURL.text,
                            context);
                      } else {
                        showMySnackbar(
                            context, 'Vous n\'avez pas d\'accces internet');
                      }
                    }
                  },
                  child: Text('Mettre en ligne'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
