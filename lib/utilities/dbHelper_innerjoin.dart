import 'dart:async';
import 'dart:io' as io;
import 'package:app_dolibarr/models/produit.dart';
import 'package:app_dolibarr/models/produit_tiers.dart';
import 'package:app_dolibarr/models/tiers.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Produit(this.id, this.idTiers, this.designation, this.prixUnitaire,
//       this.quantite);

class DbHelperProduit {
  static Database _db;
  //Fields for Product table
  static const String ID = "id";
  static const String ID_TIERS_FOREIGN_KEY = "idTiers";
  static const String DESIGNATION = 'designation';
  static const String PRIX_UNITAIRE = 'prixUnitaire';
  static const String QUANTITE = 'quantite';
  //Field for Tiers table
  static const String ID_TIERS = "id";
  static const String TYPE = 'type';
  static const String CONTACT = 'contact';
  static const String DATE = 'date';
  static const String PAIEMENT = 'paiement';
  static const String STATUS = 'status';
  //Field for db and table
  static const String TABLE = 'Produit';
  static const String TABLE_TIERS = 'Tiers';
  static const String DB_NAME = 'Produit12.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory getDocuments = await getApplicationDocumentsDirectory();
    String path = join(getDocuments.path, DB_NAME);
    var db = openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY,$ID_TIERS_FOREIGN_KEY INTEGER, $DESIGNATION TEXT, $PRIX_UNITAIRE REAL,$QUANTITE INTEGER)");
    debugPrint("TABLE $TABLE CREATED");
    await db.execute(
        "CREATE TABLE $TABLE_TIERS ($ID_TIERS INTEGER PRIMARY KEY,$TYPE TEXT, $CONTACT TEXT, $DATE TEXT, $PAIEMENT TEXT, $STATUS INTEGER)");
    debugPrint("TABLE $TABLE_TIERS CREATED");
  }

//REQUEST FOR PRODUCTS
  Future<Produit> save(Produit produit) async {
    var dbClient = await db;

    produit.id = await dbClient.insert(TABLE, produit.toMap());

    return produit;

    /*await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ( $NAME ) VALUES('" + employee.name + "')";
      return await txn.rawInsert(query);
    });*/
  }

//Obtenir plusieurs produit
  Future<List<Produit>> getProduits() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE,
        columns: [ID, ID_TIERS, DESIGNATION, PRIX_UNITAIRE, QUANTITE]);
    // List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");

    List<Produit> produits = [];

    if (produits.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        produits.add(Produit.fromMap(maps[i]));
      }
    }

    return produits;
  }

//Obtenir un produit
  Future<List<Produit>> getProduit(int id) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('Produit',
        columns: ['designation', 'prixUnitaire', 'quantite'],
        where: '"id" = ?',
        whereArgs: [id]);
    // List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");

    List<Produit> produits = [];

    if (produits.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        produits.add(Produit.fromMap(maps[i]));
      }
    }

    return produits;
  }

  //  Future<NoDoItem> getItem(int id) async{
  //   var dbClient = await db;
  //   var result = await dbClient.rawQuery("SELECT * FROM $TABLE WHERE id = $ID ");
  //   //var result = await dbClient.query(TABLE, columns: [ID, ITEMNAME, DATECREATED]);
  //   if(result.length == 0) return null;
  //   return NoDoItem.fromMap(result.first);

  // }

  //Obtenir un produit
  Future<Produit> getProduit1(int id) async {
    var dbClient = await db;
    var resultat =
        await dbClient.rawQuery("SELECT * FROM $TABLE WHERE id = $ID ");
    // var result = await dbClient.query(TABLE, columns: [ID, ITEMNAME, DATECREATED]);
    if (resultat.length == 0) return null;
    return Produit.fromMap(resultat.first);
  }

//REQUEST FOR TIERS
  Future<Tiers> saveTiers(Tiers tiers) async {
    var dbClient = await db;

    tiers.id = await dbClient.insert(TABLE_TIERS, tiers.toMap());

    return tiers;
  }

  Future<List<Tiers>> getTiers() async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .query(TABLE_TIERS, columns: [ID_TIERS, TYPE, CONTACT, DATE, PAIEMENT]);
    // List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");

    List<Tiers> tierses = [];

    if (tierses.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        tierses.add(Tiers.fromMap(maps[i]));
      }
    }

    return tierses;
  }

//Get produits and tiers according to status 0 ou 1
  Future<List<ProduitTiers>> getProduitsAndTiersWithStatus(int status) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery(
        "SELECT Produit.id, Produit.idTiers, $DESIGNATION, $CONTACT, $DATE, $PRIX_UNITAIRE, $QUANTITE FROM $TABLE INNER JOIN $TABLE_TIERS ON Produit.idTiers = Tiers.id WHERE Tiers.status = $status");
    List<ProduitTiers> listeProduitTiers = <ProduitTiers>[];
    for (var i = 0; i < maps.length; i++) {
      listeProduitTiers.add(ProduitTiers.fromMap(maps[i]));
    }
    return listeProduitTiers;
  }

//GET liste des produits AND tiers
  Future<List<ProduitTiers>> getProduitsAndTiers() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery(
        "SELECT Produit.id, Produit.idTiers, $DESIGNATION, $CONTACT, $DATE, $PRIX_UNITAIRE, $QUANTITE FROM $TABLE INNER JOIN $TABLE_TIERS ON Produit.idTiers = Tiers.id");
    List<ProduitTiers> listeProduitTiers = <ProduitTiers>[];
    for (var i = 0; i < maps.length; i++) {
      listeProduitTiers.add(ProduitTiers.fromMap(maps[i]));
    }
    return listeProduitTiers;
  }

  //GET liste des produits AND tiers with specific ID from the list
  Future<Map> getProduitsAndTiersWithSpecificId(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT Produit.id, $DATE, $CONTACT, $TYPE, $PAIEMENT, $DESIGNATION, $QUANTITE, $PRIX_UNITAIRE FROM $TABLE INNER JOIN $TABLE_TIERS ON Produit.idTiers = Tiers.id WHERE Produit.id = $id");
    if (result == null) return null;
    return result.first;
    // return ProductTiersModelAPI.fromMap(result.first);
  }

//MAJ status to 1 apres envoie des produits dans dolibarr serveur
  Future<int> updateProduitAndTiersWhenEnvoye(int id) async {
    var dbClient = await db;
    return dbClient
        .rawUpdate("UPDATE $TABLE_TIERS SET $STATUS = 1 WHERE $ID_TIERS = $id");
  }

//MAJ CONTACT ET PRODUIT
  Future<int> updateProduitAndTiers(ProduitTiers produitTiers) async {
    var dbClient = await db;

    // row to update
    // Map<String, dynamic> row = {
    //   '$DESIGNATION': '${produitTiers.designation}',
    //   '$PRIX_UNITAIRE': '${produitTiers.prixUnitaire}',
    //   '$QUANTITE': '${produitTiers.quantite}',
    // };

    //update table tiers
    await dbClient.rawUpdate(
        'UPDATE $TABLE SET $DESIGNATION = ?, $PRIX_UNITAIRE = ?, $QUANTITE = ? WHERE $ID = ?',
        [
          "${produitTiers.designation}",
          "${produitTiers.prixUnitaire}",
          "${produitTiers.quantite}",
          "${produitTiers.id}"
        ]);
    print("FROM BASE, ID : ${produitTiers.id}");
    print("FROM BASE, ID TIERS : ${produitTiers.idTiers}");

    return await dbClient.rawUpdate(
        'UPDATE $TABLE_TIERS SET $CONTACT = ? WHERE $ID_TIERS = ?',
        ["${produitTiers.contact}", '${produitTiers.id}']);

    // do the update and get the number of affected rows
    // int idUpdatedTiers = await dbClient.update(TABLE, row,
    //     where: '$ID_TIERS_FOREIGN_KEY = ?',
    //     whereArgs: ['${produitTiers.idTiers}']);

    // await dbClient.rawUpdate(
    //     "UPDATE $TABLE SET $DESIGNATION , $PRIX_UNITAIRE = $prixUnitaire , $QUANTITE = $quantite WHERE $ID_TIERS_FOREIGN_KEY = $idTiers ");
    // return await dbClient.rawUpdate(
    //     "UPDATE $TABLE_TIERS SET = $CONTACT = $contact  WHERE $ID_TIERS = $id");
    // return dbClient.rawUpdate(
    //     "UPDATE $TABLE SET Tiers.contact = ${produitTiers.contact}, Produit.designation = ${produitTiers.designation}, Produit.quantite = ${produitTiers.quantite}, Produit.prixUnitaire = ${produitTiers.prixUnitaire} FROM $TABLE p INNER JOIN $TABLE_TIERS t ON p.idTiers = t.id WHERE p.idTiers IN (${produitTiers.idTiers}) "); //WHERE $ID = ${produitTiers.id}
    // return dbClient.update(TABLE, Produit.toMap(),
    //     where: '$ID=?', whereArgs: [lisaAccessItem.id]);
    // JOIN $TABLE_TIERS ON Produit.idTiers = Tiers.id $TABLE_TIERS
  }

  /*  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs:[id]);
  } */

  Future<int> removeProduitAndTiers(int id) async {
    var dbClient = await db;
    await dbClient
        .delete(TABLE, where: '$ID_TIERS_FOREIGN_KEY = ?', whereArgs: [id]);
    return await dbClient
        .delete(TABLE_TIERS, where: '$ID_TIERS = ?', whereArgs: [id]);
    // "DELETE * FROM Produit INNER JOIN Tiers ON Produit.idTiers = Tiers.id WHERE Produit.idTiers = Tiers.id");
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
