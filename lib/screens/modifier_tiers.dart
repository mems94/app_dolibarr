import 'package:app_dolibarr/components/buildTextField.dart';
import 'package:app_dolibarr/models/produit.dart';
import 'package:app_dolibarr/models/produit_tiers.dart';
import 'package:app_dolibarr/models/produit_tiers_model.dart';
import 'package:app_dolibarr/models/tiers.dart';
import 'package:app_dolibarr/screens/accueil.dart';
import 'package:app_dolibarr/screens/contact.dart';
import 'package:app_dolibarr/utilities/date_formatted.dart';
import 'package:app_dolibarr/utilities/dbHelper_innerjoin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModifierTiers extends StatefulWidget {
  int id;
  ModifierTiers(this.id);
  // Function produitCallback;
  // ModifierTiers(this.produitCallback);
  @override
  _ModifierTiersState createState() => _ModifierTiersState();
}

class _ModifierTiersState extends State<ModifierTiers> {
  TextEditingController _contactController = TextEditingController();
  TextEditingController _designationController = TextEditingController();
  TextEditingController _prixUnitaireController = TextEditingController();
  TextEditingController _quantiteController = TextEditingController();

  // String listeDeroulanteType;
  // String listeDeroulantePaiement = 'Mode de paiement';
  String contact = "";
  String designation = "";
  double prixUnitaire = 0.0;
  int quantite = 0;
  int idTiersForUpdate = 0;

  Produit unProduitSaved;
  final _modificationTiersKey = GlobalKey<FormState>();

//Create database instance
  var db = DbHelperProduit();
  // var dbTiers = DbHelperTiers();

  void initialiserValeur(BuildContext context) async {
    //Get the list from datalist from model
    // print("ID FOR MODIFIER CONTACT : ${widget.id}");
    var dataFromList =
        await Provider.of<ProduitTiersModel>(context, listen: false)
            .getProduitsAndTiersWithSpecificId(widget.id);
    //initialize all variables

    idTiersForUpdate = dataFromList['idTiers'];
    _contactController.text = dataFromList['contact'];
    _designationController.text = dataFromList['designation'];
    _prixUnitaireController.text = dataFromList['prixUnitaire'].toString();
    _quantiteController.text = dataFromList['quantite'].toString();
  }

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
    initialiserValeur(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Modification'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(13.0),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: _modificationTiersKey,
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
                // Row(
                //   children: [
                //     Icon(Icons.baby_changing_station_rounded),
                //     Padding(padding: EdgeInsets.only(left: 15.0)),
                //     Expanded(
                //       child: DropdownButton<String>(
                //         isExpanded: true,
                //         disabledHint: Text('Type'),
                //         value: listeDeroulanteType,
                //         hint: Text('Type'),
                //         icon: const Icon(Icons.arrow_downward),
                //         iconSize: 24,
                //         elevation: 16,
                //         style: const TextStyle(
                //           color: Colors.grey,
                //         ),
                //         underline: Container(
                //           height: 2,
                //           color: Colors.grey,
                //         ),
                //         onChanged: (String newValue) {
                //           setState(() {
                //             listeDeroulanteType = newValue;
                //           });
                //         },
                //         items: <String>['Type', 'Achat', 'Vente']
                //             .map<DropdownMenuItem<String>>((String value) {
                //           return DropdownMenuItem<String>(
                //             value: value,
                //             child: Text(value),
                //           );
                //         }).toList(),
                //       ),
                //     ),
                //   ],
                // ),
                // buildTextField("Type", Icons.merge_type),
                buildTextField(
                    "Contact", Icons.contact_phone, _contactController, false),
                //Dropdown button paiement
                // Row(
                //   children: [
                //     Icon(Icons.credit_card_outlined),
                //     Padding(padding: EdgeInsets.only(left: 15.0)),
                //     Expanded(
                //       child: DropdownButton<String>(
                //         isExpanded: true,
                //         value: listeDeroulantePaiement,
                //         hint: Row(
                //           children: [
                //             Icon(Icons.arrow_downward_outlined),
                //             Text('Paiement'),
                //           ],
                //         ),
                //         icon: const Icon(Icons.arrow_downward_outlined),
                //         iconSize: 24,
                //         elevation: 16,
                //         style: const TextStyle(
                //           color: Colors.grey,
                //         ),
                //         // underline: Container(
                //         //   height: 2,
                //         //   color: Colors.grey,
                //         // ),
                //         onChanged: (String newValue) {
                //           setState(() {
                //             listeDeroulantePaiement = newValue;
                //           });
                //         },
                //         items: <String>[
                //           'Mode de paiement',
                //           'Cheque',
                //           'Credit',
                //           'Espece'
                //         ].map<DropdownMenuItem<String>>((String value) {
                //           return DropdownMenuItem<String>(
                //             value: value,
                //             child: Text(value),
                //           );
                //         }).toList(),
                //       ),
                //     ),
                //   ],
                // ),
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
                      //Check if TextField is not empty
                      if (_modificationTiersKey.currentState.validate()) {
                        // contact = _contactController.text;
                        designation = _designationController.text;
                        prixUnitaire =
                            double.parse(_prixUnitaireController.text);
                        quantite = int.parse(_quantiteController.text);

                        //Add tiers
                        // Tiers unTiers = Tiers(listeDeroulanteType, contact,
                        //     convertDateToSeconds(), listeDeroulantePaiement);

                        // Tiers unTiersSaved = await db.saveTiers(unTiers);
                        // Add Tiers to database
                        // int unTiersSavedId = await Provider.of<ProduitTiersModel>(
                        //         context,
                        //         listen: false)
                        //     .addTiers(unTiers);

                        // print("FROM PROVIDER - Tiers saved $unTiersSavedId");
                        //Create

                        //Creation de produit tiers pour la mise à jour
                        ProduitTiers produitTiersAMAJ = ProduitTiers(
                            widget.id,
                            idTiersForUpdate,
                            _designationController.text,
                            _contactController.text.toUpperCase(),
                            convertDateToSeconds(),
                            double.parse(_prixUnitaireController.text),
                            int.parse(_quantiteController.text));
                        //Add product
                        int produiTiersMAJ =
                            await Provider.of<ProduitTiersModel>(context,
                                    listen: false)
                                .updateProduitAndTiers(produitTiersAMAJ);

                        print(
                            "FROM PROVIDER - Produit tiers MAJ : $produiTiersMAJ");

                        _contactController.clear();
                        _designationController.clear();
                        _prixUnitaireController.clear();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AppDolibarr()));
                      }
                    },
                    child: Text(
                      'Enregistrer modification',
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
