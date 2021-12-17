import 'package:app_dolibarr/screens/accueil.dart';
import 'package:app_dolibarr/screens/liste_produit_envoyer.dart';
import 'package:flutter/material.dart';

Drawer customDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.green,
          ),
          child: Text('Menu'),
        ),
        ListTile(
          leading: Icon(Icons.circle),
          title: const Text('Non envoyé'),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AppDolibarr()));
          },
        ),
        ListTile(
          leading: Icon(Icons.send),
          title: const Text('Dejà envoyé'),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ListeProduitEnvoyer()));
          },
        ),
      ],
    ),
  );
}
