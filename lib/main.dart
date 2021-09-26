import 'package:app_dolibarr/models/produit_tiers_model.dart';
import 'package:app_dolibarr/screens/accueil.dart';
import 'package:app_dolibarr/screens/contact.dart';
import 'package:app_dolibarr/screens/login/login_view.dart';
import 'package:app_dolibarr/screens/main/main_view.dart';
import 'package:app_dolibarr/screens/mettre_en_ligne.dart';
import 'package:app_dolibarr/screens/modifier_contact.dart';
import 'package:app_dolibarr/screens/nouveau_tiers.dart';
import 'package:app_dolibarr/screens/products/product_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => ProduitTiersModel(),
      child: App(),
    ),
  );
}

// class MainViewModelRoel extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginView(),
//     );
//   }
// }

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bienvenue dans Dolibarr',
      darkTheme:
          ThemeData(primarySwatch: Colors.blue, primaryColor: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => AppDolibarr(),
        '/nouveautiers': (context) => NouveauTiers(),
        // '/contact': (context) => Contact(),
        '/mettreEnLigne': (context) => MettreEnLigne(),
        '/modifierContact': (context) => ModifierContact(),
      },
    );
  }
}
