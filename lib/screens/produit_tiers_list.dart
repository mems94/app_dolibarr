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
        // List<ProduitTiers> access =
        //     Provider.of<ProduitTiersModel>(context, listen: true)
        //         .listProduitTiers;
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
                  DataColumn(label: Text('Info')),
                ],
                rows: produitTiersModel.listProduitTiers
                    .map(
                      (e) => DataRow(
                          selected: false,
                          onSelectChanged: null,
                          cells: [
                            DataCell(Text(e.date)),
                            DataCell(Text(e.contact)),
                            DataCell(
                                Text((e.prixUnitaire * e.quantite).toString())),
                            DataCell(
                                GestureDetector(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.blueAccent,
                                    // color: Color(0xFF24D876),
                                    size: 35.0,
                                  ),
                                ), onTap: () {
                              return Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    print('ICON CALLED');
                                    return Contact(e.id);
                                  },
                                ),
                              );
                            }),
                          ]),
                    )
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
