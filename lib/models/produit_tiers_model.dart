import 'dart:convert';

import 'package:app_dolibarr/constants/urls.dart';
import 'package:app_dolibarr/models/produit.dart';
import 'package:app_dolibarr/models/produit_tiers.dart';
import 'package:app_dolibarr/models/tiers.dart';
import 'package:app_dolibarr/services/auth_service.dart';
import 'package:app_dolibarr/utilities/shared_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:app_dolibarr/utilities/dbHelper_innerjoin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as client;

class ProduitTiersModel extends ChangeNotifier {
  ProduitTiersModel();

  int newListCount;
  bool connected = false;
  bool stateButtonModifier = false;
  bool stateButtonMettreAJour = false;
  bool stateButtonNouveau = true;

  DbHelperProduit dbForLogin = DbHelperProduit();
  var dbForProduitTiers = DbHelperProduit();
  //Liste des produits dejà envoyés
  List<ProduitTiers> _myListeProduitDejaEnvoye = <ProduitTiers>[];
  //Liste des produits non envoyés
  List<ProduitTiers> _myListeProduitNonEnvoye = <ProduitTiers>[];

  //Liste des etats du case a cocher
  List<bool> listeEtatCochage = <bool>[];

  //List tiers pour autosuggestion
  List<String> _listTiers = [];

  //Liste de tous les produits
  // List<ProduitTiers> myListProduitTiers = <ProduitTiers>[];

  // List<ProduitTiers> get listProduitTiers {
  //   // notifyListeners();
  //   return myListProduitTiers;
  // }

//Getter for listTiers Fomr dolibarr online
  List<String> get listeTiers => _listTiers;

  //Status color
  Future<Color> statusColor() async {
    print("Etat connected => $connected");
    if (connected) {
      return Colors.green;
    }
    return Colors.grey;
  }

  //deleteTokenSaved
  void deleteSavedToken() {
    setValueInPrefs("dbToken", " ");
    print("Token delete");
  }

//Get user status connected or not
  Future<bool> checkUserStatus() async {
    if (connected) {
      return true;
    }
    return false;
  }

  //Change user status
  Future<int> changeUserStatus() async {
    connected = true;
    notifyListeners();
    return 1;
  }

//Logout user
  void logoutUser() {
    if (connected) {
      connected = false;
    }
  }

//Get suppliers and customer
  Future<List<String>> getListTiersOnlinenoAuth(String url) async {
    var baseURL = 'https://' + url + '/api/index.php';

    var token = await getValueFromPrefs('dbToken');
    print("TOKEN : $token");
    final response = await client.get(
      Uri.parse('$baseURL/thirdparties'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'DOLAPIKEY': '$token'
      },
    );
    dynamic body = json.decode(response.body);
    //Add name tiers to yhe list
    for (var i = 0; i < body.length; i++) {
      _listTiers.add(body[i]['name']);
      print(body[i]['name']);
    }

    return _listTiers;
  }

//Get suppliers and customer
  Future<List<String>> getListTiersOnline(
      String username, String password, String url) async {
    AuthService _authService = AuthService();
    var baseURL = url + '/api/index.php';

    var token = await _authService.loginwithUrl(username, password, url);
    print("TOKEN : $token");
    final response = await client.get(
      Uri.parse('$baseURL/thirdparties'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'DOLAPIKEY': '$token'
      },
    );
    dynamic body = json.decode(response.body);
    //Add name tiers to yhe list
    for (var i = 0; i < body.length; i++) {
      _listTiers.add(body[i]['name']);
      print(body[i]['name']);
    }

    return _listTiers;
  }

  //Add element to list
//Getter liste des produits et tiers non envoyé
  List<ProduitTiers> get listeProduitTiersNonEnvoye {
    // updateProduitTiersListView();
    return _myListeProduitNonEnvoye;
  }

//Getter liste des produits et tiers dejà envoyé
  List<ProduitTiers> get listeProduitTiersEnvoye {
    // updateProduitTiersListView();
    return _myListeProduitDejaEnvoye;
  }

  //Save id list on long press
  Future<dynamic> saveIdListToPreference(int id) async {
    print("$id In model");
    var okSave = await setValueInPrefs('idListAPI', id.toString());
    return okSave;
  }

  //Get idList on login process
  Future<int> getIdListFromPreferences(String key) async {
    var idFromPref = await getValueFromPrefs(key);
    print("$idFromPref - In getPreferences");
    return int.parse(idFromPref);
  }

  //Show modifier button contact
  void showModifierContact() {
    stateButtonModifier = !stateButtonModifier;
  }

//show button mettre en ligne
  void showMettreEnLigne() {
    stateButtonMettreAJour = !stateButtonMettreAJour;
    stateButtonNouveau = !stateButtonNouveau;
    notifyListeners();
  }

  //Actualisation
  void actualisation() {
    stateButtonNouveau = true;
    stateButtonMettreAJour = false;
    notifyListeners();
  }

//Add new tiers to Tiers table
  Future<int> addTiers(Tiers tiers) async {
    Tiers unTiersSaved = await dbForProduitTiers.saveTiers(tiers);
    notifyListeners();
    return unTiersSaved.id;
  }

  //get Product from the list
  Future<Produit> getOneProductFromList(int id) async {
    Produit produit = await dbForProduitTiers.getProduit1(id);
    print('ID FROM LIST : $id');
    // if (id == 0) {
    //   oneProduct = _myListeProduitNonEnvoye[(id)];
    // }
    // oneProduct = _myListeProduitNonEnvoye[(id - 3)];
    // updateProduitTiersListView();
    return produit;
  }

//Get produit from database
  Future<Produit> getOneProduit(int id) async {
    Produit produit = await dbForProduitTiers.getProduit1(id);
    print('Produit obtenu ${produit.designation}');
    notifyListeners();
    return produit;
  }

  Future<int> addProduitTiersToList(Produit produit) async {
    Produit unProduitSaved = await dbForProduitTiers.save(produit);
    // int idProduitTiersAdded = await dbForItem.save(lisaAccessItem);
    // LisaAccessItem newAccessItem = await dbForItem.getItem(idItemAdded);
    // myListAccess.add(newAccessItem);

    updateProduitTiersListView();
    // updateProduitListViewWithStatus0();
    // updateProduitListViewWithStatus1();
    // notifyListeners();
    print('Item $unProduitSaved.id added');
    return unProduitSaved.id;
  }

//   void updateProduitTiersListView() async {
// //    myListAccess = List<LisaAccessItem>();
//     // Future<List<LisaAccessItem>> itemList = dbForItem.getItems();
//     myListProduitTiers.clear();
//     Future<List<ProduitTiers>> ptList = dbForProduitTiers.getProduitsAndTiers();
//     // ptList.then((eachItem) {
//     //   this.myListProduitTiers = eachItem;
//     // this.newListCount = eachItem.length;
//     ptList.then((element) {
//       // myListProduitTiers = ProduitTiers.fromMap(element);
//       // myListProduitTiers.add(ProduitTiers.fromMap(element));
//       this.myListProduitTiers = element;
//       notifyListeners();
//     });
//   }

  void updateProduitTiersListView() async {
    updateProduitListViewWithStatus0();
    updateProduitListViewWithStatus1();
    notifyListeners();
  }

//MAJ produits et tiers non envoyés
  void updateProduitListViewWithStatus0() async {
    _myListeProduitNonEnvoye.clear();
    Future<List<ProduitTiers>> ptList =
        dbForProduitTiers.getProduitsAndTiersWithStatus(0);
    ptList.then((element) {
      this._myListeProduitNonEnvoye = element;
      notifyListeners();
    });
  }

//MAJ produits et tiers deja envoyés
  void updateProduitListViewWithStatus1() async {
    _myListeProduitDejaEnvoye.clear();
    Future<List<ProduitTiers>> ptList =
        dbForProduitTiers.getProduitsAndTiersWithStatus(1);
    ptList.then((element) {
      this._myListeProduitDejaEnvoye = element;
      notifyListeners();
    });
  }

//Get produit with specific id
  Future<Map> getProduitsAndTiersWithSpecificId(int id) async {
    // int idFromPreferences = await getIdListFromPreferences(id.toString());
    var oneP = await dbForProduitTiers.getProduitsAndTiersWithSpecificId(id);
    return oneP;
  }

  // Future<int> delete(int id) async {
  //   var dbClient = await db;
  //   return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  // }

  Future<int> updateProduitAndTiers(ProduitTiers produitTiers) async {
    var response = await dbForProduitTiers.updateProduitAndTiers(produitTiers);
    updateProduitTiersListView();
    // updateProduitListViewWithStatus0();
    // updateProduitListViewWithStatus1();
    return response;
  }

  Future<int> deleteProduitAndTiers(int id) {
    var response = dbForProduitTiers.removeProduitAndTiers(id);
    updateProduitTiersListView();
    // updateProduitListViewWithStatus0();
    // updateProduitListViewWithStatus1();
    return response;
  }

  Future<int> updateProduitAndTiersStatusTo1(int id) async {
    int result = await dbForProduitTiers.updateProduitAndTiersWhenEnvoye(id);
    //MAJ Liste
    updateProduitTiersListView();
    return result;
  }
}
