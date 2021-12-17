import 'package:app_dolibarr/models/produit_tiers.dart';
import 'package:app_dolibarr/models/produit_tiers_model.dart';
import 'package:app_dolibarr/screens/contact.dart';
import 'package:app_dolibarr/utilities/date_formatted.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProduitTiersList extends StatefulWidget {
  @override
  _ProduitTiersListState createState() => _ProduitTiersListState();
}

class _ProduitTiersListState extends State<ProduitTiersList> {
  // bool etatCaseACocher = false;
  List<ProduitTiers> selectedProducts;
  List<ProduitTiers> notSelectedProducts;
  bool etatCheckBox = false;

  @override
  void initState() {
    selectedProducts = [];
    notSelectedProducts = [];
    super.initState();
  }

  bool onNotSelectedProducts(bool notSelectedEtat) {
    return !notSelectedEtat;
  }

//When product selectionné
  void onSelectedProducts(bool etatCase, ProduitTiers e) {
    setState(() {
      if (etatCase) {
        selectedProducts.add(e);
        notSelectedProducts.remove(e);
      } else {
        selectedProducts.remove(e);
        notSelectedProducts.add(e);
      }
    });
  }

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
              onTap: () {
                Provider.of<ProduitTiersModel>(context, listen: false)
                    .showMettreEnLigne();
              },
              child: DataTable(
                showCheckboxColumn: false,
                onSelectAll: (value) {},
                columns: [
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Contact')),
                  DataColumn(label: Text('Total')),
                  DataColumn(label: Text('Info')),
                ],
                rows: produitTiersModel.listeProduitTiersNonEnvoye
                    .map(
                      (e) => DataRow(
                          selected: selectedProducts.contains(e),
                          onSelectChanged: (value) async {
                            Provider.of<ProduitTiersModel>(context,
                                    listen: false)
                                .showMettreEnLigne();
                            onSelectedProducts(value, e);
                            // setState(() {
                            //   etatCaseACocher = value;
                            // });
                            if (value) {
                              dynamic dyn =
                                  await Provider.of<ProduitTiersModel>(context,
                                          listen: false)
                                      .saveIdListToPreference(e.id);
                              if (dyn != null) {
                                print(e.id);
                                print('ID SAVED BY THE PREFERENCES');
                              }
                            }
                          },
                          cells: [
                            DataCell(Text(
                                convertDateSecondeTodateFormatter(e.date))),
                            DataCell(Text(e.contact)),
                            DataCell(
                                Text((e.prixUnitaire * e.quantite).toString())),
                            DataCell(
                                GestureDetector(
                                  child: Icon(
                                    Icons.add,
                                    // color: Colors.green,
                                    // color: Color(0xFF24D876),
                                    size: 35.0,
                                  ),
                                  onLongPress: () async {
                                    dynamic dyn =
                                        await Provider.of<ProduitTiersModel>(
                                                context,
                                                listen: false)
                                            .saveIdListToPreference(e.id);
                                    if (dyn != null) {
                                      print(e.id);
                                      print('ID SAVED BY THE PREFERENCES');
                                    }
                                  },
                                ), onTap: () {
                              Navigator.push(
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
