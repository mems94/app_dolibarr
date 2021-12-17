import 'package:app_dolibarr/models/produit_tiers_model.dart';
import 'package:app_dolibarr/utilities/date_formatted.dart';
import 'package:app_dolibarr/utilities/show_alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListeProduitEnvoyer extends StatefulWidget {
  @override
  _ListeProduitEnvoyerState createState() => _ListeProduitEnvoyerState();
}

class _ListeProduitEnvoyerState extends State<ListeProduitEnvoyer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des produits envoyés'),
        centerTitle: true,
      ),
      body: Consumer<ProduitTiersModel>(
        builder: (context, produitTiersModel, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: GestureDetector(
                onLongPress: () {
                  Provider.of<ProduitTiersModel>(context, listen: false)
                      .showMettreEnLigne();
                },
                child: DataTable(
                  onSelectAll: (value) {},
                  columns: [
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Contact')),
                    DataColumn(label: Text('Total')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: produitTiersModel.listeProduitTiersEnvoye
                      .map(
                        (e) => DataRow(selected: false, cells: [
                          DataCell(
                              Text(convertDateSecondeTodateFormatter(e.date))),
                          DataCell(Text(e.contact)),
                          DataCell(
                              Text((e.prixUnitaire * e.quantite).toString())),
                          DataCell(
                              GestureDetector(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                  size: 25.0,
                                ),
                              ), onTap: () {
                            showMyAlertDialog(context, e);
                            // Provider.of<ProduitTiersModel>(context,
                            //         listen: false)
                            //     .deleteProduitAndTiers(e.id);
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => ListeProduitEnvoyer()));
                            // print('Produit supprimé');
                          }),
                        ]),
                      )
                      .toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
