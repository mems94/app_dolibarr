import 'package:app_dolibarr/components/buildTextField.dart';
import 'package:app_dolibarr/models/produit.dart';
import 'package:app_dolibarr/models/produit_tiers_model.dart';
import 'package:app_dolibarr/models/tiers.dart';
import 'package:app_dolibarr/utilities/date_formatted.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

// ignore: must_be_immutable
class NouveauTiers extends StatefulWidget {
  // Function produitCallback;
  // NouveauTiers(this.produitCallback);
  @override
  _NouveauTiersState createState() => _NouveauTiersState();
}

class _NouveauTiersState extends State<NouveauTiers> {
  TextEditingController _contactController = TextEditingController();
  TextEditingController _designationController = TextEditingController();
  TextEditingController _prixUnitaireController = TextEditingController();
  TextEditingController _quantiteController = TextEditingController();

  String listeDeroulanteType = 'Type';
  String listeDeroulantePaiement = 'Mode de paiement';
  String contact = "";
  String designation = "";
  double prixUnitaire = 0.0;
  int quantite = 0;
  final _nouveauTiersKey = GlobalKey<FormState>();

  Produit unProduitSaved;
  List<String> listeTiers = <String>[];

  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  void getListTiersOnline() {
    listeTiers =
        Provider.of<ProduitTiersModel>(context, listen: false).listeTiers;
  }

  @override
  void initState() {
    getListTiersOnline();
    super.initState();
  }

  void assignContact(String contactAutoSelect) {
    contact = contactAutoSelect;
    print(contact);
  }

  // var db = DbHelperProduit();
  // var dbTiers = DbHelperTiers();

  // void ajoutProduit() async {
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

// TODAY
  // contact = _contactController.text;
  // designation = _designationController.text;
  // prixUnitaire = double.parse(_prixUnitaireController.text);
  // quantite = int.parse(_quantiteController.text);

  // Tiers unTiers = Tiers(
  //     listeDeroulanteType, contact, dateFormatted(), listeDeroulantePaiement);
  // Tiers unTiersSaved = await db.saveTiers(unTiers);
  // debugPrint("${unTiersSaved.id}");
  // Produit unProduit =
  //     Produit(unTiersSaved.id, designation, prixUnitaire, quantite);
  // unProduitSaved = await db.save(unProduit);
  // debugPrint("${unProduitSaved.id}");
//      NoDoItem addedItem = await db.getItem(savedItemId);
//      setState(() {
//        _itemList.add(addedItem);
//        debugPrint("Item added");
//      });
  // }

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
        child: SingleChildScrollView(
          child: Form(
            key: _nouveauTiersKey,
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
                        items: <String>['Type', 'Achat', 'Vente']
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
                Row(
                  children: [
                    Icon(Icons.contact_phone),
                    Padding(padding: EdgeInsets.only(left: 15.0)),
                    Expanded(
                      child: SimpleAutoCompleteTextField(
                        key: key,
                        suggestions: listeTiers,
                        textChanged: (text) => assignContact(text),
                        // {
                        //   if (text != null) {
                        //     print(text);
                        //     contact = text;
                        //     print(contact);
                        //   }
                        // },
                        decoration: InputDecoration(
                            hintText: 'Contact',
                            hintStyle: TextStyle(fontSize: 13.0)),
                      ),
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     Icon(Icons.contact_phone),
                //     Padding(padding: EdgeInsets.only(left: 15.0)),
                //     Expanded(
                //       child: Autocomplete(
                //         optionsBuilder: (TextEditingValue textEditingValue) {
                //           if (textEditingValue.text == '') {
                //             return const Iterable<String>.empty();
                //           }
                //           return listeTiers.where((String option) {
                //             return option.contains(textEditingValue.text);
                //           });
                //         },
                //         // fieldViewBuilder: (context, textEditingController,
                //         //     focusNode, onFieldSubmitted) {
                //         //   // textEditingController.text = 'Contact';
                //         //   return TextField(
                //         //     decoration: InputDecoration(
                //         //       hintText: 'Contact',
                //         //     ),
                //         //     style: TextStyle(fontSize: 13.0),
                //         //     // controller: textEditingController,
                //         //     onSubmitted: (value) {
                //         //       contact = textEditingController.text;
                //         //       print(contact);
                //         //       return contact;
                //         //     },
                //         //   );
                //         // },
                //         onSelected: (value) {
                //           if (value == '') {
                //             contact = _contactController.text;
                //           }
                //           contact = value;
                //           print(contact);
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                // buildTextField("Type", Icons.merge_type),
                // buildTextField(
                //     "Contact", Icons.contact_phone, _contactController, false),
                //Dropdown button paiement
                Row(
                  children: [
                    Icon(Icons.credit_card_outlined),
                    Padding(padding: EdgeInsets.only(left: 15.0)),
                    Expanded(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: listeDeroulantePaiement,
                        hint: Row(
                          children: [
                            Icon(Icons.arrow_downward_outlined),
                            Text('Paiement'),
                          ],
                        ),
                        icon: const Icon(Icons.arrow_downward_outlined),
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
                        items: <String>[
                          'Mode de paiement',
                          'Cheque',
                          'Credit',
                          'Espece'
                        ].map<DropdownMenuItem<String>>((String value) {
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
                buildTextField("Designation", Icons.add_shopping_cart,
                    _designationController, false),
                buildTextField(
                    "PU", Icons.money, _prixUnitaireController, false,
                    clavier: TextInputType.number),
                buildTextField(
                    "Quantité", Icons.add, _quantiteController, false,
                    clavier: TextInputType.number),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // primary: Colors.green,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      //check if TextField not empty
                      if (_nouveauTiersKey.currentState.validate()) {
                        // contact = _contactController.text.toUpperCase();
                        designation = _designationController.text;
                        prixUnitaire =
                            double.parse(_prixUnitaireController.text);
                        quantite = int.parse(_quantiteController.text);
                        //Create Tiers
                        //Add tiers
                        Tiers unTiers = Tiers(
                            listeDeroulanteType,
                            contact.toUpperCase(),
                            convertDateToSeconds(),
                            listeDeroulantePaiement,
                            0);

                        // Tiers unTiersSaved = await db.saveTiers(unTiers);
                        // Add Tiers to database
                        int unTiersSavedId =
                            await Provider.of<ProduitTiersModel>(context,
                                    listen: false)
                                .addTiers(unTiers);

                        print("FROM PROVIDER - Tiers saved $unTiersSavedId");
                        //Create
                        Produit unProduit = Produit(unTiersSavedId, designation,
                            prixUnitaire, quantite);
                        //Add product
                        int unProduitSavedId =
                            await Provider.of<ProduitTiersModel>(context,
                                    listen: false)
                                .addProduitTiersToList(unProduit);
                        // unProduitSaved = await db.save(unProduit);

                        print(
                            "FROM PROVIDER - Produit saved $unProduitSavedId");
                        // contact = _contactController.text;
                        // designation = _designationController.text;
                        // prixUnitaire = _prixUnitaireController.text;
                        // ajoutProduit();

                        _contactController.clear();
                        _designationController.clear();
                        _prixUnitaireController.clear();

                        Navigator.pushNamed(context, '/');
                      }
                    },
                    child: Text(
                      'Enregistrer',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
