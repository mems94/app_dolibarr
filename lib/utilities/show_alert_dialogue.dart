import 'package:app_dolibarr/models/produit_tiers.dart';
import 'package:app_dolibarr/models/produit_tiers_model.dart';
import 'package:app_dolibarr/screens/liste_produit_envoyer.dart';
import 'package:app_dolibarr/utilities/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

showMyAlertDialog(BuildContext context, ProduitTiers e) {
  var alert = AlertDialog(
    title: Text(
      'SUPPRESSION DE PRODUIT',
      style: TextStyle(
        fontSize: 16.0,
      ),
    ),
    content: Text(
      'Cette action va effacer le produit defnitivement',
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: OutlineButton(
          borderSide: BorderSide.none,
          highlightElevation: 5.0,
          child: Text(
            'SUPPRIMER',
            style: TextStyle(
              letterSpacing: 2.0,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            await Provider.of<ProduitTiersModel>(context, listen: false)
                .deleteProduitAndTiers(e.id);
            Navigator.pop(ScaffoldMessenger.of(context).context);
            print('Produit supprimé');
            showMySnackbar(context, "Produit supprimé");
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: OutlineButton(
          borderSide: BorderSide.none,
          child: Text(
            'ANNULER',
            style: TextStyle(
              color: Colors.black,
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pop(ScaffoldMessenger.of(context).context);
          },
        ),
      ),
    ],
  );
  showDialog(
    context: context,
    builder: (_) => alert,
  );
}
