import 'package:app_dolibarr/models/produit.dart';
import 'package:app_dolibarr/models/produit_tiers.dart';
import 'package:app_dolibarr/models/tiers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:app_dolibarr/utilities/dbHelper_innerjoin.dart';

class ProduitTiersModel extends ChangeNotifier {
  ProduitTiersModel();

  int newListCount;

  bool stateButtonMettreAJour = false;
  bool stateButtonNouveau = true;

  DbHelperProduit dbForLogin = DbHelperProduit();
  var dbForProduitTiers = DbHelperProduit();

  List<ProduitTiers> myListProduitTiers = <ProduitTiers>[];

  List<ProduitTiers> get listProduitTiers {
    // notifyListeners();
    return myListProduitTiers;
  }

//show button mettre en ligne
  void showMettreEnLigne() {
    stateButtonMettreAJour = !stateButtonMettreAJour;
    stateButtonNouveau = !stateButtonNouveau;
    notifyListeners();
  }

//hide button nouveau
  // void hideButtonNouveau() {
  //   stateButtonNouveau = !stateButtonNouveau;
  //   notifyListeners();
  // }

  // Future<int> getCount() async {
  //   int count = await dbForItem.getCount();
  //   notifyListeners();
  //   return count;
  // }

  // int get listProduitTiersCount {
  //   return myListProduitTiers.length;
  // }

  // set listProduitTiers{

  // }

//   Future<int> deleteAccessItem(int id, [int indexList]) async {
//     int feedback = await dbForItem.delete(id);
// //    myListAccess.removeAt(indexList);
//     updateAccesListView();
//     return feedback;
//   }

//Add new tiers to Tiers table
  Future<int> addTiers(Tiers tiers) async {
    Tiers unTiersSaved = await dbForProduitTiers.saveTiers(tiers);
    notifyListeners();
    return unTiersSaved.id;
  }

  //get Product from the list

  ProduitTiers getOneProductFromList(int id) {
    ProduitTiers oneProduct = myListProduitTiers[(id - 1)];
    notifyListeners();
    return oneProduct;
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
    // notifyListeners();
    print('Item $unProduitSaved.id added');
    return unProduitSaved.id;
  }

  // handleSubmittedAccessUpdateInDB(int index, LisaAccessItem item) {
  //   myListAccess.removeWhere((element) {
  //     // ignore: unnecessary_statements
  //     myListAccess[index].siteName == item.siteName;
  //     return;
  //   });
  // }

  // updateAccessItem(LisaAccessItem lisaAccessItem) {
  //   dbForItem.update(lisaAccessItem);
  //   updateAccesListView();
  // }

  void updateProduitTiersListView() async {
//    myListAccess = List<LisaAccessItem>();
    // Future<List<LisaAccessItem>> itemList = dbForItem.getItems();
    myListProduitTiers.clear();
    Future<List<ProduitTiers>> ptList = dbForProduitTiers.getProduitsAndTiers();
    // ptList.then((eachItem) {
    //   this.myListProduitTiers = eachItem;
    // this.newListCount = eachItem.length;
    ptList.then((element) {
      // myListProduitTiers = ProduitTiers.fromMap(element);
      // myListProduitTiers.add(ProduitTiers.fromMap(element));
      this.myListProduitTiers = element;
      notifyListeners();
    });
    // });
  }

  // Future<ProduitTiers> getAccessItem(int id) async {
  //   var accessItem = await dbForItem.getItem(id);
  //   return accessItem;
  // }

  // Future<bool> getUser(String username, String password) async {
  //   LisaLogin user = await dbForLogin.getItem(username, password);
  //   print('User not in database');
  //   if (user != null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // Future<int> createUser(LisaLogin lisaLogin) async {
  //   int result = await dbForLogin.save(lisaLogin);
  //   notifyListeners();
  //   updateAccesListView();
  //   return result;
  // }
}
