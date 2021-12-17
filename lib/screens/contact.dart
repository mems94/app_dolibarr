import 'package:app_dolibarr/models/produit.dart';
import 'package:app_dolibarr/models/produit_tiers_model.dart';
import 'package:app_dolibarr/screens/modifier_tiers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Contact extends StatefulWidget {
  int id;
  Contact(this.id);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  String designation;

  int quantite;

  double prixUnitaire;

  Produit pdt;

  List<DataColumn> creationColumn() {
    return [
      DataColumn(
        //Column date
        label: Text(
          'Designation',
          style: TextStyle(
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      //Column Contact
      DataColumn(
        label: Text(
          'PU',
          style: TextStyle(
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      //Column Total
      DataColumn(
        label: Text(
          'Quantité',
          style: TextStyle(
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
    ];
  }

  @override
  void initState() {
    obtenirProduit(context);
    super.initState();
  }

//Obtenir le produit
  void obtenirProduit(BuildContext context) async {
    print(widget.id);
    Map mapProduit =
        await Provider.of<ProduitTiersModel>(context, listen: false)
            .getProduitsAndTiersWithSpecificId(widget.id);

    setState(() {
      designation = mapProduit['designation'];
      prixUnitaire = mapProduit['prixUnitaire'];
      quantite = mapProduit['quantite'];
    });
  }

  @override
  Widget build(Object context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Produit'),
          centerTitle: true,
        ),
        body: GestureDetector(
          onLongPress: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ModifierTiers(widget.id);
            }));
          },
          child: DataTable(columns: creationColumn(), rows: [
            DataRow(cells: [
              DataCell(Text(designation ?? 'Salle')),
              DataCell(Text(prixUnitaire.toString() ?? '50000')),
              DataCell(Text(quantite.toString() ?? '2'))
            ])
          ]),
        ));
  }
}
