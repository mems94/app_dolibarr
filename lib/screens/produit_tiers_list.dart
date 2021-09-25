import 'package:app_dolibarr/models/produit_tiers.dart';
import 'package:app_dolibarr/models/produit_tiers_model.dart';
import 'package:app_dolibarr/screens/contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProduitTiersList extends StatefulWidget {
  @override
  _ProduitTiersListState createState() => _ProduitTiersListState();
}

class _ProduitTiersListState extends State<ProduitTiersList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProduitTiersModel>(
      builder: (context, produitTiersModel, child) {
        return Container(
          child: ListView.custom(
            // shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            // scrollDirection: Axis.horizontal,
            childrenDelegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              ProduitTiers access =
                  Provider.of<ProduitTiersModel>(context, listen: true)
                      .listProduitTiers[index];
              //double total = access.prixUnitaire * access.quantite;
              return GestureDetector(
                onLongPress: () {
                  Provider.of<ProduitTiersModel>(context, listen: false)
                      .showMettreEnLigne();
                },
                child: DataTable(columns: [
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Contact')),
                  DataColumn(label: Text('Total')),
                  DataColumn(label: Text('Info')),
                ], rows: [
                  DataRow(cells: [
                    DataCell(Text(access.date)),
                    DataCell(Text(access.contact)),
                    DataCell(Text(
                        (access.prixUnitaire * access.quantite).toString())),
                    DataCell(GestureDetector(
                      child: Icon(Icons.info_outline),
                      onTap: () {
                        return Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          print('ICON CALLED');
                          return Contact(access.id);
                        }));
                      },
                    )),
                  ])
                ]),
              );
            }, childCount: produitTiersModel.listProduitTiersCount),
          ),
        );
      },
    );
  }
}
