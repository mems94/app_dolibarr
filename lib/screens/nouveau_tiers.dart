import 'package:app_dolibarr/components/buildTextField.dart';
import 'package:app_dolibarr/models/produit.dart';
import 'package:app_dolibarr/models/tiers.dart';
import 'package:app_dolibarr/utilities/date_formatted.dart';
import 'package:app_dolibarr/utilities/dbHelper_innerjoin.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NouveauTiers extends StatefulWidget {
  Function produitCallback;
  NouveauTiers(this.produitCallback);
  @override
  _NouveauTiersState createState() => _NouveauTiersState();
}

class _NouveauTiersState extends State<NouveauTiers> {
  TextEditingController _contactController = TextEditingController();
  TextEditingController _designationController = TextEditingController();
  TextEditingController _prixUnitaireController = TextEditingController();
  TextEditingController _quantiteController = TextEditingController();

  String listeDeroulanteType = 'Achat';
  String listeDeroulantePaiement = 'Espece';
  String contact = "";
  String designation = "";
  double prixUnitaire = 0.0;
  int quantite = 0;

  Produit unProduitSaved;

  var db = DbHelperProduit();
  // var dbTiers = DbHelperTiers();

  void ajoutProduit() async {
    // setState(() {
    //   print(listeDeroulanteType);
    //   print(listeDeroulantePaiement);
    //   print(_contactController.text);
    //   print(_designationController.text);
    //   print(_prixUnitaireController.text);
    //   print(_quantiteController.text);
    // });

    // Produit(this.id, this.idTiers, this.designation, this.prixUnitaire,
    //   this.quantite);

// //     NoDoItem noDoItem = new NoDoItem(text, dateFormatted());

    contact = _contactController.text;
    designation = _designationController.text;
    prixUnitaire = double.parse(_prixUnitaireController.text);
    quantite = int.parse(_quantiteController.text);

    Tiers unTiers = Tiers(
        listeDeroulanteType, contact, dateFormatted(), listeDeroulantePaiement);

    Tiers unTiersSaved = await db.saveTiers(unTiers);

    debugPrint("${unTiersSaved.id}");

    Produit unProduit =
        Produit(unTiersSaved.id, designation, prixUnitaire, quantite);

    unProduitSaved = await db.save(unProduit);

    debugPrint("${unProduitSaved.id}");

//      NoDoItem addedItem = await db.getItem(savedItemId);

//      setState(() {
//        _itemList.add(addedItem);
//        debugPrint("Item added");
//      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nouveau tiers'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(13.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.0),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'TIERS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //dropdownbutton button
            Row(
              children: [
                Icon(Icons.baby_changing_station_rounded),
                Padding(padding: EdgeInsets.only(left: 15.0)),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    disabledHint: Text('Type'),
                    value: listeDeroulanteType,
                    hint: Text('Type'),
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                    underline: Container(
                      height: 2,
                      color: Colors.grey,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        listeDeroulanteType = newValue;
                      });
                    },
                    items: <String>['Achat', 'Vente']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            // buildTextField("Type", Icons.merge_type),
            buildTextField("Contact", Icons.contact_phone, _contactController),
            //Dropdown button paiement
            Row(
              children: [
                Icon(Icons.ac_unit),
                Padding(padding: EdgeInsets.only(left: 15.0)),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: listeDeroulantePaiement,
                    hint: Row(
                      children: [
                        Icon(Icons.ac_unit),
                        Text('Paiement'),
                      ],
                    ),
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                    // underline: Container(
                    //   height: 2,
                    //   color: Colors.grey,
                    // ),
                    onChanged: (String newValue) {
                      setState(() {
                        listeDeroulantePaiement = newValue;
                      });
                    },
                    items: <String>['Cheque', 'Credit', 'Espece']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            // buildTextField("Paiement", Icons.money),
            // buildTextField("Produit", Icons.add_shopping_cart),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "PRODUIT",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            buildTextField(
                "Designation", Icons.add_shopping_cart, _designationController),
            buildTextField(
                "PU", Icons.download_outlined, _prixUnitaireController),
            buildTextField("Quantité", Icons.add, _quantiteController),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  // contact = _contactController.text;
                  // designation = _designationController.text;
                  // prixUnitaire = _prixUnitaireController.text;
                  ajoutProduit();
                  widget.produitCallback(unProduitSaved);
                  Navigator.pushNamed(context, '/');
                  // setState(() {});
                },
                child: Text(
                  'Enregistrer',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
