import 'package:app_dolibarr/screens/accueil.dart';
import 'package:app_dolibarr/screens/contact.dart';
import 'package:app_dolibarr/screens/mettre_en_ligne.dart';
import 'package:app_dolibarr/screens/modifier_contact.dart';
import 'package:app_dolibarr/screens/nouveau_tiers.dart';
import 'package:app_dolibarr/screens/products/product_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bienvenue dans Dolibarr',
      darkTheme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        //'/': (context) => AppDolibarr(),
        '/': (context) => ProductView(),
        '/nouveautiers': (context) => NouveauTiers(),
        // '/contact': (context) => Contact(int id),
        '/mettreEnLigne': (context) => MettreEnLigne(),
        '/modifierContact': (context) => ModifierContact(),
      },
    );
  }
}
